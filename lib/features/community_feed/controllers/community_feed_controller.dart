import 'dart:typed_data';

import 'package:comunidadesucv/core/models/comment_status.dart';
import 'package:comunidadesucv/core/models/pending_comment.dart';
import 'package:comunidadesucv/core/models/user_detail.dart';
import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:comunidadesucv/features/community_detail/data/repository/community_detail_repository.dart';
import 'package:comunidadesucv/features/community_feed/data/repository/community_feed_repository.dart';
import 'package:comunidadesucv/features/splash/data/repository/splash_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CommunityFeedController extends GetxController {
  final box = GetStorage();

  final Space space = Get.arguments;

  SplashRepository splashRepository = SplashRepository();
  CommunityDetailRepository communityDetailRepository =
      CommunityDetailRepository();
  CommunityFeedRepository communityFeedRepository = CommunityFeedRepository();

  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isLoadingPrevious = false.obs;
  var hasMorePosts = true.obs;
  var hasMorePreviousPosts = false.obs;

  final RxList<Post> dataPost = <Post>[].obs;
  final RxMap<int, Uint8List> imagesMap = <int, Uint8List>{}.obs;
  final RxMap<int, bool> userLikes = <int, bool>{}.obs;

  final RxSet<int> likedCommentIds = <int>{}.obs;
  final RxSet<int> likedCommentOfCommentIds = <int>{}.obs;

  final pendingComments = <PendingComment>[].obs;
  final postVisualizingComments = <CommentItem>[].obs;

  final Rx<UserDetail> user = UserDetail.empty().obs;
  final Set<int> expandedCommentIds = <int>{};

  // Variables para la gestión de comentarios
  final RxList<CommentItem> comments = <CommentItem>[].obs;
  bool isInitialCommentsLoading = false;
  bool isLoadingMoreComments = false;
  bool isAddingComment = false;
  bool noMoreCommentsToLoad = false;

  // Variables para la paginación
  int currentPage = 1;
  int minPage = 1;
  final int postsLimit = 10;
  final int commentLimit = 10;
  int? currentPostId;

  final RxBool isSearchActive = false.obs;
  final RxString searchQuery = ''.obs;
  final RxList filteredPosts = [].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    _loadUser();
    loadInitialPosts();

    scrollController.addListener(_scrollListener);
    // Initialize search functionality
    filteredPosts.assignAll(dataPost);
    ever(dataPost, (_) => updateFilteredPosts());
    ever(searchQuery, (_) => updateFilteredPosts());
  }

  // Carga de los datos del usuario
  void _loadUser() async {
    var userData = box.read("user");
    if (userData != null) {
      user.value = userData;
    } else {
      Get.snackbar("Error", "No se encontró información del usuario");
    }
  }

  void toggleSearch() {
    isSearchActive.value = !isSearchActive.value;
    if (!isSearchActive.value) {
      searchQuery.value = '';
      updateFilteredPosts();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    updateFilteredPosts();
  }

  void updateFilteredPosts() {
    if (searchQuery.value.isEmpty) {
      filteredPosts.assignAll(dataPost);
    } else {
      filteredPosts.assignAll(dataPost
          .where((post) => post.message
              .toString()
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList());
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    // Si estamos al 80% del scroll, cargamos más posts
    if (scrollController.position.pixels >
        scrollController.position.maxScrollExtent * 0.8) {
      if (!isLoadingMore.value && hasMorePosts.value) {
        loadMorePosts();
      }
    }

    // Cargar posts anteriores cuando estamos cerca del inicio (scroll < 50 píxeles)
    if (scrollController.position.pixels < 50) {
      if (!isLoadingPrevious.value &&
          currentPage > minPage &&
          !isLoading.value) {
        loadPreviousPosts();
      }
    }
  }

  Future<void> loadMorePosts() async {
    if (isLoadingMore.value || !hasMorePosts.value) return;

    isLoadingMore.value = true;
    currentPage++;

    try {
      final response = await communityDetailRepository.postContainerSpace(
          space.contentContainerId, postsLimit, currentPage);

      if (response.results.isEmpty) {
        hasMorePosts.value = false;
      } else {
        final filteredPostsArchived = response.results
            .where((item) => item.content.metadata.archived == false)
            .toList();
        dataPost.assignAll(filteredPostsArchived);

        hasMorePosts.value = response.results.length >= postsLimit;
      }
    } catch (e) {
      currentPage--;
      Get.snackbar("Error", "Error al cargar más publicaciones");
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> loadPreviousPosts() async {
    if (isLoadingPrevious.value || currentPage <= minPage) return;

    isLoadingPrevious.value = true;
    int previousPage = currentPage - 1;

    if (previousPage < minPage) {
      isLoadingPrevious.value = false;
      return;
    }

    try {
      final response = await communityDetailRepository.postContainerSpace(
          space.contentContainerId, postsLimit, previousPage);

      if (response.results.isNotEmpty) {
        final filteredPostsArchived = response.results
            .where((item) => item.content.metadata.archived == false)
            .toList();

        dataPost.insertAll(0, filteredPostsArchived);
        currentPage = previousPage;

        if (previousPage <= 1) {
          minPage = 1;
          hasMorePreviousPosts.value = false;
        } else {
          hasMorePreviousPosts.value = true;
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Error al cargar publicaciones anteriores");
    } finally {
      isLoadingPrevious.value = false;
    }
  }

  Future<void> loadInitialPosts() async {
    if (isLoading.value) return;

    isLoading.value = true;
    currentPage = 1;

    try {
      final response = await communityDetailRepository.postContainerSpace(
          space.contentContainerId, postsLimit, currentPage);

      if (response.results.isEmpty) {
        hasMorePosts.value = false;
      } else {
        final filteredPostsArchived = response.results
            .where((item) => item.content.metadata.archived == false)
            .toList();
        dataPost.assignAll(filteredPostsArchived);

        hasMorePosts.value = response.results.length >= postsLimit;
      }
    } catch (e) {
      Get.snackbar("Error", "Error al cargar publicaciones");
    } finally {
      isLoading.value = false;
    }
  }

  // Método para refrescar los posts
  Future<void> refreshPosts() async {
    hasMorePosts.value = true;
    await loadInitialPosts();
  }

  // Método para alternar la expansión de respuestas para un comentario
  void toggleCommentExpansion(int commentId, int postId, int objectId) {
    if (expandedCommentIds.contains(commentId)) {
      expandedCommentIds.remove(commentId);
    } else {
      expandedCommentIds.add(commentId);
    }
    update(['comments-list-$objectId']);
  }

  void initCommentLoading(int objectId) {
    comments.clear();
    isInitialCommentsLoading = true;
    currentPage = 1;
    noMoreCommentsToLoad = false;
    currentPostId = objectId;
    update(['comments-list-$objectId']);

    getCommentsByPost(objectId);
  }

  // Obtener comentarios por post (primera carga)
  Future<void> getCommentsByPost(int objectId) async {
    try {
      final response = await communityFeedRepository.getComments(
          objectId, currentPage, commentLimit);

      comments.assignAll(response.results);

      // Verificar si hay más páginas para cargar
      noMoreCommentsToLoad = currentPage >= response.pages;

      isInitialCommentsLoading = false;
      update(['comments-list-$objectId']);
    } catch (e) {
      isInitialCommentsLoading = false;
      update(['comments-list-$objectId']);
    }
  }

  // Cargar más comentarios (paginación)
  Future<void> loadMoreComments(int objectId) async {
    if (isLoadingMoreComments || noMoreCommentsToLoad) return;

    isLoadingMoreComments = true;
    update(['comments-list-$objectId']);

    try {
      currentPage++;
      final response = await communityFeedRepository.getComments(
          objectId, currentPage, commentLimit);

      // Agregar nuevos comentarios a la lista existente
      comments.addAll(response.results);

      // Verificar si hay más páginas para cargar
      noMoreCommentsToLoad = currentPage >= response.pages;

      isLoadingMoreComments = false;
      update(['comments-list-$objectId']);
    } catch (e) {
      currentPage--; // Revertir incremento de página si hay error
      isLoadingMoreComments = false;
      update(['comments-list-$objectId']);
    }
  }

  // Refrescar comentarios (pull to refresh)
  Future<void> refreshComments(int objectId) async {
    currentPage = 1;
    noMoreCommentsToLoad = false;

    try {
      final response = await communityFeedRepository.getComments(
          objectId, currentPage, commentLimit);

      comments.assignAll(response.results);

      // Verificar si hay más páginas para cargar
      noMoreCommentsToLoad = currentPage >= response.pages;

      update(['comments-list-$objectId']);
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudieron refrescar los comentarios',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    }
  }

  // Método para verificar si un comentario tiene sus respuestas expandidas
  bool isCommentExpanded(int commentId) {
    return expandedCommentIds.contains(commentId);
  }

  void toggleLikePost(int postId) async {
    if (userLikes.containsKey(postId)) {
      return;
    } else {
      userLikes[postId] = true;
    }

    final postIndex = dataPost.indexWhere((post) => post.id == postId);

    if (postIndex != -1) {
      if (userLikes[postId]!) {
        try {
          dataPost[postIndex].content.likes.total++;
          await communityFeedRepository.addLike(
              dataPost[postIndex].content.metadata.objectModel,
              dataPost[postIndex].content.metadata.objectId);
        } catch (e) {
          dataPost[postIndex].content.likes.total--;
        }
      } else {
        try {
          dataPost[postIndex].content.likes.total--;
          await communityFeedRepository.addLike(
              dataPost[postIndex].content.metadata.objectModel,
              dataPost[postIndex].content.metadata.objectId);
        } catch (e) {
          dataPost[postIndex].content.likes.total++;
        }
      }
    }
  }

  Future<void> addCommentPost({
    required int postId,
    required String text,
    required int objectId,
  }) async {
    if (text.trim().isEmpty) return;

    isAddingComment = true;
    update(['comment-submit-btn']);

    final postIndex = dataPost.indexWhere((post) => post.id == postId);
    if (postIndex == -1) {
      Get.snackbar('Error', 'No se encontró la publicación');
      return;
    }

    final objectModel = dataPost[postIndex].content.metadata.objectModel;
    final objectId = dataPost[postIndex].content.metadata.objectId;

    final pendingId = DateTime.now().millisecondsSinceEpoch.toString();
    final newComment = PendingComment(
      id: pendingId,
      postId: postId,
      message: text,
      status: CommentStatus.sending,
      createdBy: CreatedBy(
          id: 1,
          guid: "guid",
          displayName:
              "${user.value.profile!.firstname} ${user.value.profile!.lastname}",
          url: "${user.value.profile!.url}",
          // ignore: unnecessary_string_interpolations
          imageUrl: "${user.value.profile!.imageUrl}",
          // ignore: unnecessary_string_interpolations
          imageUrlOrg: "${user.value.profile!.imageUrlOrg}",
          // ignore: unnecessary_string_interpolations
          bannerUrl: "${user.value.profile!.bannerUrl}",
          // ignore: unnecessary_string_interpolations
          bannerUrlOrg: "${user.value.profile!.bannerUrlOrg}",
          tags: [],
          carrera: "",
          filial: "",
          codigo: ""),
      createdAt: DateTime.now().toIso8601String(),
    );

    pendingComments.add(newComment);

    update(['comments-list-$objectId']);

    dataPost[postIndex].content.comments.total++;

    try {
      final commentSaved =
          await communityFeedRepository.addComment(objectModel, objectId, text);

      pendingComments.removeWhere((c) => c.id == pendingId);

      comments.insert(0, commentSaved);

      update(['comments-list-$objectId']);

      isAddingComment = false;
      update(['comment-submit-btn']);
    } catch (e) {
      final failedCommentIndex =
          pendingComments.indexWhere((c) => c.id == pendingId);

      if (failedCommentIndex != -1) {
        pendingComments[failedCommentIndex].status = CommentStatus.failed;
        update(['comments-list-$objectId']);
      }

      dataPost[postIndex].content.comments.total--;
    }
  }

  Future<bool> likeComment(CommentItem comment, int objectId) async {
    try {
      bool success = await communityFeedRepository.addLike(
          "humhub\\modules\\comment\\models\\Comment", comment.id);

      if (success) {
        // Buscar el comentario en la lista y actualizar su estado
        final index = comments.indexWhere((item) => item.id == comment.id);
        if (index != -1) {
          final updatedComment = comments[index];

          // Verificar si el comentario ya está en nuestra lista de likes
          final bool currentLikedState = likedCommentIds.contains(comment.id);

          // Actualizar nuestra lista de comentarios con like
          if (!currentLikedState) {
            likedCommentIds.add(comment.id);
            updatedComment.likes.total += 1;
          } else {
            likedCommentIds.remove(comment.id);
            if (updatedComment.likes.total > 0) {
              updatedComment.likes.total -= 1;
            }
          }

          // Actualizar el comentario en la lista
          comments[index] = updatedComment;

          // Refrescar la UI
          update(['comments-list-$objectId']);
        }
      }

      return success;
    } catch (e) {
      print("Error liking comment: ${e.toString()}");
      return false;
    }
  }

  // Ahora, en tu controlador, añadimos la función para manejar likes en comentarios anidados
  Future<bool> likeNestedComment(
      CommentItem nestedComment, int objectId, int parentCommentId) async {
    try {
      bool success = await communityFeedRepository.addLike(
          "humhub\\modules\\comment\\models\\Comment", nestedComment.id);

      if (success) {
        // Verificamos si el comentario ya tiene like
        final bool currentLikedState =
            likedCommentOfCommentIds.contains(nestedComment.id);

        // Actualizamos la lista de likes
        if (!currentLikedState) {
          likedCommentOfCommentIds.add(nestedComment.id);
        } else {
          likedCommentOfCommentIds.remove(nestedComment.id);
        }

        // Buscar el comentario padre en la lista
        final parentIndex =
            comments.indexWhere((item) => item.id == parentCommentId);
        if (parentIndex != -1 && comments[parentIndex].comments != null) {
          // Buscar el comentario anidado dentro del padre
          final nestedIndex = comments[parentIndex]
              .comments!
              .indexWhere((item) => item.id == nestedComment.id);

          if (nestedIndex != -1) {
            // Actualizar el contador de likes
            if (!currentLikedState) {
              comments[parentIndex].comments![nestedIndex].likes.total += 1;
            } else if (comments[parentIndex]
                    .comments![nestedIndex]
                    .likes
                    .total >
                0) {
              comments[parentIndex].comments![nestedIndex].likes.total -= 1;
            }

            update(['replies-comment-$parentCommentId']);
          }
        }
      }

      return success;
    } catch (e) {
      print("Error liking nested comment: ${e.toString()}");
      return false;
    }
  }

  String cleanMessage(String message) {
    final cleanedMessage = message.replaceAll(
        RegExp(r'!\[\]\(file-guid:[a-zA-Z0-9-]+ \".*?\"\)'), '');
    return cleanedMessage;
  }

  Future<void> loadImage(int idFile, String token) async {
    if (imagesMap.containsKey(idFile)) return;

    final response = await http.get(
      Uri.parse(
          "https://comunidadesucv.uvcv.edu.pe/api/v1/file/download/$idFile"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      imagesMap[idFile] = response.bodyBytes;
    }
  }

  Future<void> retryComment(String pendingId, int objectId) async {
    final pendingIndex = pendingComments.indexWhere((c) => c.id == pendingId);
    if (pendingIndex == -1) return;

    final comment = pendingComments[pendingIndex];
    comment.status = CommentStatus.sending;
    update(['comments-${comment.postId}']);

    await addCommentPost(
        postId: comment.postId, text: comment.message, objectId: objectId);
  }
}
