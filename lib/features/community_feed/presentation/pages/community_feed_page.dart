import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/core/models/comment_status.dart';
import 'package:comunidadesucv/core/models/pending_comment.dart';
import 'package:comunidadesucv/core/widgets/avatar_image.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:comunidadesucv/features/community_feed/controllers/community_feed_controller.dart';
import 'package:comunidadesucv/features/community_feed/presentation/widgets/animated_counter.dart';
import 'package:comunidadesucv/features/community_feed/presentation/widgets/animated_search.dart';
import 'package:comunidadesucv/features/community_feed/presentation/widgets/commentlike_button_animation.dart';
import 'package:comunidadesucv/features/community_feed/presentation/widgets/community_title.dart';
import 'package:comunidadesucv/features/community_feed/presentation/widgets/replylike_button_animation.dart';
import 'package:comunidadesucv/features/community_feed/presentation/widgets/responsive_navigation_feed.dart';
import 'package:comunidadesucv/features/community_feed/presentation/widgets/simplelike_button_animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CommunityFeedPage extends GetView<CommunityFeedController> {
  const CommunityFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CommunityTitle(
              controller: controller,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => AnimatedSearch(
                    onSearch: controller.updateSearchQuery,
                    isSearchActive: controller.isSearchActive.value,
                    onSearchTap: controller.toggleSearch,
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: _buildFeedContent(),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: ResponsiveNavigationFeed(
        controller: controller,
      ),
    );
  }

  Widget _buildFeedContent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.isSearchActive.value && controller.filteredPosts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No se encontraron resultados para "${controller.searchQuery.value}"',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      if (controller.filteredPosts.isEmpty) {
        return Center(
          child: Text(
            'No hay publicaciones disponibles',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refreshPosts,
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Obx(() => controller.isLoadingPrevious.value
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : SizedBox.shrink()),
            ),

            // Lista principal de posts
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = controller.filteredPosts[index];
                    final user = post.content.metadata.createdBy;
                    final hasImage = post.content.files.isNotEmpty;
                    final imageId =
                        hasImage ? post.content.files.first['id'] : null;

                    return _buildPostItem(
                      context: context,
                      post: post,
                      userImageUrl: user.imageUrl,
                      userName: user.displayName,
                      imageId: imageId,
                      message: post.message,
                      likes: post.content.likes.total,
                      comments: post.content.comments.total,
                    );
                  },
                  childCount: controller.filteredPosts.length,
                ),
              ),
            ),

            // Indicador de carga para más posts (al final)
            SliverToBoxAdapter(
              child: Obx(() => controller.isLoadingMore.value
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  : SizedBox.shrink()),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPostItem({
    required BuildContext context,
    required Post post,
    required String userImageUrl,
    required String userName,
    int? imageId,
    required String message,
    required int likes,
    required int comments,
  }) {
    final hasImage = imageId != null;
    final postId = post.id;

    if (hasImage) {
      controller.loadImage(imageId,
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3NDMzODA1MjQsImlzcyI6Imh0dHA6Ly9jb211bmlkYWRlc3Vjdi51dmN2LmVkdS5wZSIsIm5iZiI6MTc0MzM4MDUyNCwidWlkIjoxLCJlbWFpbCI6IndlYm1hc3RlckB1Y3YuZWR1LnBlIn0.TlA5yxow3ugHd0rX3SjvhEL1W6ntQTeOHOnWR-9mncnXkpPNf2mU489GnyS5BFjNuzQS64ItfYL3PGTQ436-3w");
    }
    final String cleanedMessage = controller.cleanMessage(message);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDialogDark,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 15),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  ClipOval(
                      child: AvatarImage(
                          avatar:
                              'https://trilce.ucv.edu.pe/Fotos/Mediana/${post.content.metadata.createdBy.codigo}.jpg',
                          avatarError: userImageUrl,
                          width: 40,
                          height: 40)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (cleanedMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                  left: 15,
                  right: 25,
                ),
                child: MarkdownBody(
                  data: cleanedMessage,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            if (hasImage)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: controller.imagesMap.containsKey(imageId)
                        ? DecorationImage(
                            image: MemoryImage(controller.imagesMap[imageId]!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey[300],
                  ),
                  child: !controller.imagesMap.containsKey(imageId)
                      ? const Center(child: CircularProgressIndicator())
                      : null,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  SimpleLikeButtonAnimation(
                    postId: postId,
                    isLiked: controller.userLikes[postId] == true ||
                        post.content.userLiked,
                    onToggle: (id) => controller.toggleLikePost(post),
                  ),
                  const SizedBox(width: 5),
                  AnimatedCounter(
                    count: post.content.likes.total,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _showCommentsModal(context, post);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.lightBlue,
                          size: 22,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${post.content.comments.total}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modal de los comentarios del Post con paginación y efectos de shimmer
  void _showCommentsModal(BuildContext context, Post post) async {
    final TextEditingController commentController = TextEditingController();
    final int postId = post.id;
    final int objectId = post.content.metadata.objectId;

    // Iniciar carga de comentarios antes de mostrar el modal
    controller.initCommentLoading(objectId);

    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: const BoxDecoration(
          color: AppColors.backgroundDialogDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Comentarios',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildCommentsListWithPagination(objectId, postId),
            ),
            _buildCommentInput(context, commentController, postId, objectId),
          ],
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  // Widget para construir la lista de comentarios con paginación
  Widget _buildCommentsListWithPagination(int objectId, int postId) {
    return GetBuilder<CommunityFeedController>(
      id: 'comments-list-$objectId',
      builder: (ctrl) {
        final pendingForThisPost = controller.pendingComments
            .where((c) => c.postId == postId)
            .toList();

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!ctrl.isLoadingMoreComments &&
                !ctrl.noMoreCommentsToLoad &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent * 0.8) {
              ctrl.loadMoreComments(objectId);
            }
            return false;
          },
          child: RefreshIndicator(
            onRefresh: () => ctrl.refreshComments(objectId),
            color: AppColors.backgroundDialogDark,
            backgroundColor: Colors.grey[800],
            child: ctrl.isInitialCommentsLoading
                ? _buildCommentsShimmer()
                : (ctrl.comments.isEmpty && pendingForThisPost.isEmpty)
                    ? _buildEmptyComments()
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: pendingForThisPost.length +
                            ctrl.comments.length +
                            (ctrl.isLoadingMoreComments ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == ctrl.comments.length &&
                              ctrl.isLoadingMoreComments) {
                            return _buildLoadingMoreIndicator();
                          }

                          if (index < pendingForThisPost.length) {
                            return _buildPendingCommentItem(
                                pendingForThisPost[index], objectId);
                          }
                          final commentIndex =
                              index - pendingForThisPost.length;

                          return _buildCommentItem(
                              ctrl.comments[commentIndex], postId, objectId);
                        },
                      ),
          ),
        );
      },
    );
  }

  // Widget for displaying pending comments
  Widget _buildPendingCommentItem(PendingComment pendingComment, int objectId) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              pendingComment.createdBy.imageUrl,
              width: 35,
              height: 35,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: 35, color: Colors.grey);
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      pendingComment.createdBy.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _formatDate(pendingComment.createdAt),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  pendingComment.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),

                // Status indicator
                if (pendingComment.status == CommentStatus.sending)
                  const Text(
                    'Publicando...',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontStyle: FontStyle.italic),
                  )
                else if (pendingComment.status == CommentStatus.failed)
                  GestureDetector(
                    onTap: () =>
                        controller.retryComment(pendingComment.id, objectId),
                    child: const Text(
                      'No se pudo enviar. Toca para volver a intentarlo.',
                      style: TextStyle(color: Colors.redAccent, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para mostrar efecto shimmer durante la carga inicial
  Widget _buildCommentsShimmer() {
    return ListView.builder(
      itemCount: 5, // Número de placeholders de shimmer
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.shimmerHighlightColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar placeholder
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre usuario placeholder
                      Container(
                        height: 12,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Contenido comentario placeholder
                      Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 10,
                        width: MediaQuery.of(Get.context!).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget para mostrar mensaje cuando no hay comentarios
  Widget _buildEmptyComments() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 60, color: Colors.grey[600]),
          const SizedBox(height: 16),
          Text(
            'No hay comentarios todavía',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¡Sé el primero en comentar!',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

// Ahora, modificamos la función _buildCommentItem para integrar nuestro nuevo widget
  Widget _buildCommentItem(CommentItem comment, int postId, int objectId) {
    final String timeAgo = _formatDate(comment.createdAt);
    // Verificamos si el comentario actual está en la lista de likes del usuario
    final bool isLiked = controller.likedCommentIds.contains(comment.id);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: AvatarImage(
                avatar:
                    'https://trilce.ucv.edu.pe/Fotos/Mediana/${comment.createdBy.codigo}.jpg',
                avatarError: comment.createdBy.imageUrl,
                width: 50,
                height: 50),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        comment.createdBy.displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                parseMessage(comment.message, 14),
                const SizedBox(height: 6),
                Row(
                  children: [
                    CommentLikeButtonAnimation(
                      commentId: comment.id,
                      isLiked: isLiked,
                      comment: comment,
                      onToggle: (commentItem) {
                        controller.likeComment(commentItem, objectId);
                      },
                    ),
                  ],
                ),
                // Mostrar botón "Ver X respuestas" si el comentario tiene respuestas
                if ((comment.commentsCount ?? 0) > 0 &&
                    comment.comments != null)
                  _buildRepliesSection(comment, postId, objectId),
              ],
            ),
          ),
        ],
      ),
    );
  }

  RichText parseMessage(String message, double fontSizeText) {
    final mentionRegex =
        RegExp(r'\[([^\]]+)\]\(mention:([^\s]+)\s+"([^"]+)"\)');
    final spans = <TextSpan>[];

    int start = 0;

    for (final match in mentionRegex.allMatches(message)) {
      if (match.start > start) {
        spans.add(TextSpan(text: message.substring(start, match.start)));
      }

      final name = match.group(1)!;
      final guid = match.group(2)!;
      final url = match.group(3)!;

      spans.add(
        TextSpan(
          text: name,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Aquí puedes manejar la navegación al perfil
              print('Ir a perfil: $url (guid: $guid)');
            },
        ),
      );

      start = match.end;
    }

    if (start < message.length) {
      spans.add(TextSpan(text: message.substring(start)));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(color: Colors.white, fontSize: fontSizeText),
      ),
    );
  }

  // Widget para mostrar indicador de carga al cargar más comentarios
  Widget _buildLoadingMoreIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
          ),
        ),
      ),
    );
  }

  // Widget para el campo de entrada de comentarios
  Widget _buildCommentInput(BuildContext context,
      TextEditingController commentController, int postId, int objectId) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          GetBuilder<CommunityFeedController>(
            builder: (ctrl) => ClipOval(
                child: AvatarImage(
                    avatar:
                        'https://trilce.ucv.edu.pe/Fotos/Mediana/${ctrl.user.value.profile!.codigo}.jpg',
                    avatarError: ctrl.user.value.profile!.imageUrl,
                    width: 30,
                    height: 30)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: commentController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                hintText: '¿Qué opinas sobre esto?',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
                border: InputBorder.none,
              ),
            ),
          ),
          GetBuilder<CommunityFeedController>(
            id: 'comment-submit-btn',
            builder: (ctrl) => GestureDetector(
              onTap: ctrl.isAddingComment
                  ? null
                  : () {
                      if (commentController.text.isNotEmpty) {
                        ctrl.addCommentPost(
                            postId: postId,
                            text: commentController.text,
                            objectId: objectId);
                        commentController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ctrl.isAddingComment
                      ? Colors.grey[600]
                      : const Color(0xFF4169E1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: ctrl.isAddingComment
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 20,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para mostrar la sección de respuestas (botón de expandir o lista de respuestas)
  Widget _buildRepliesSection(CommentItem comment, int postId, int objectId) {
    final isExpanded = controller.isCommentExpanded(comment.id);

    return GetBuilder<CommunityFeedController>(
      id: 'replies-comment-${comment.id}',
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () => controller.toggleCommentExpansion(
                  comment.id, postId, objectId),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  isExpanded
                      ? 'Ocultar respuestas'
                      : 'Ver ${comment.commentsCount} ${comment.commentsCount == 1 ? 'respuesta' : 'respuestas'}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // Mostrar las respuestas si están expandidas
            if (isExpanded && comment.comments != null)
              _buildNestedReplies(comment.comments!, postId, objectId, comment),
          ],
        );
      },
    );
  }

  // Widget para mostrar las respuestas anidadas
  Widget _buildNestedReplies(List<CommentItem> replies, int postId,
      int objectId, CommentItem parentComment) {
    return Container(
      padding: const EdgeInsets.only(left: 10), // Indentación para respuestas
      child: Column(
        children: replies
            .map((reply) =>
                _buildReplyItem(reply, postId, objectId, parentComment.id))
            .toList(),
      ),
    );
  }

  // Widget para mostrar una respuesta individual
  Widget _buildReplyItem(
      CommentItem reply, int postId, int objectId, int parentCommentId) {
    final bool isLiked = controller.likedCommentOfCommentIds.contains(reply.id);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8), // Espacio para la línea vertical
          ClipOval(
            child: Image.network(
              reply.createdBy.imageUrl,
              width: 28, // Tamaño más pequeño para respuestas
              height: 28,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: 28, color: Colors.grey);
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Reemplazamos el GestureDetector por nuestro widget animado
                    Text(
                      reply.createdBy.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _formatDate(reply.createdAt),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                parseMessage(reply.message, 13),
                if (reply.files.isNotEmpty) _buildAttachedFiles(reply.files),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ReplyLikeButtonAnimation(
                      commentId: reply.id,
                      isLiked: isLiked,
                      comment: reply,
                      onToggle: (replyComment) {
                        // Pasamos el ID del comentario padre para saber dónde actualizar la UI
                        controller.likeNestedComment(
                            replyComment, objectId, parentCommentId);
                      },
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => {},
                      child: const Text(
                        'Responder',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Función para formatear fecha
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 365) {
        return '${(difference.inDays / 365).floor()} año(s)';
      } else if (difference.inDays > 30) {
        return '${(difference.inDays / 30).floor()} mes(es)';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} día(s)';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hora(s)';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minuto(s)';
      } else {
        return 'ahora';
      }
    } catch (e) {
      return dateString;
    }
  }

  // Widget para mostrar archivos adjuntos
  Widget _buildAttachedFiles(List<dynamic> files) {
    if (files.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files[index];
          return Container(
            width: 70,
            height: 70,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: _getFilePreview(file),
            ),
          );
        },
      ),
    );
  }

  Widget _getFilePreview(dynamic file) {
    if (file is Map && file.containsKey('type')) {
      if (file['type'].toString().contains('image')) {
        return Image.network(
          file['url'] ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image, color: Colors.grey);
          },
        );
      } else if (file['type'].toString().contains('video')) {
        return const Icon(Icons.video_file, color: Colors.blue);
      } else if (file['type'].toString().contains('pdf')) {
        return const Icon(Icons.picture_as_pdf, color: Colors.red);
      }
    }
    return const Icon(Icons.insert_drive_file, color: Colors.grey);
  }
}
