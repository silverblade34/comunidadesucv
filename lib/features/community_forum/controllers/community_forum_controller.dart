import 'package:comunidadesucv/core/models/question.dart';
import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:comunidadesucv/features/community_feed/data/repository/community_feed_repository.dart';
import 'package:comunidadesucv/features/community_forum/data/repository/community_forum_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityForumController extends GetxController {
  final Space space = Get.arguments;
  final Rx<IconData> spaceIcon = Rx<IconData>(Icons.group);
  final RxList<Question> dataQuestion = <Question>[].obs;
  CommunityForumRepository communityForumRepository =
      CommunityForumRepository();
  CommunityFeedRepository communityFeedRepository = CommunityFeedRepository();

  int currentPage = 1;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isLoadingPrevious = false.obs;
  var hasMoreQuestions = true.obs;
  final int questionsLimit = 50;
  final RxMap<int, bool> userLikes = <int, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _setSpaceIcon();
    loadInitialQuestions();
  }

  void _setSpaceIcon() {
    switch (space.name) {
      case "UCV Connect":
        spaceIcon.value = Icons.link;
        break;
      case "UCV Pet Lovers":
        spaceIcon.value = Icons.pets;
        break;
      case "Comunidad Literaria UCV":
        spaceIcon.value = Icons.book;
        break;
      case "Eco UCV":
        spaceIcon.value = Icons.eco;
        break;
      case "Kpop Squad UCV":
        spaceIcon.value = Icons.music_note;
        break;
      case "Emprendedores UCV":
        spaceIcon.value = Icons.lightbulb_outline;
        break;
      default:
        spaceIcon.value = Icons.group;
        break;
    }
  }

  Future<void> loadInitialQuestions() async {
    if (isLoading.value) return;

    isLoading.value = true;
    currentPage = 1;

    try {
      final response = await communityForumRepository.questionsContainerSpace(
          space.contentContainerId, questionsLimit, currentPage);

      if (response.results.isEmpty) {
        hasMoreQuestions.value = false;
      } else {
        final filteredQuestionArchived = response.results
            .where((item) => item.content.metadata.archived == false)
            .toList();
        dataQuestion.assignAll(filteredQuestionArchived);
        hasMoreQuestions.value = response.results.length >= questionsLimit;
      }
    } catch (e) {
      print('Error loading initial questions: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreQuestions() async {
    if (isLoadingMore.value || !hasMoreQuestions.value) return;

    isLoadingMore.value = true;
    final nextPage = currentPage + 1;

    try {
      final response = await communityForumRepository.questionsContainerSpace(
          space.contentContainerId, questionsLimit, nextPage);

      if (response.results.isEmpty) {
        hasMoreQuestions.value = false;
      } else {
        dataQuestion.addAll(response.results);
        hasMoreQuestions.value = response.results.length >= questionsLimit;
        currentPage = nextPage; // Only update currentPage if successful
      }
    } catch (e) {
      print('Error loading more questions: ${e.toString()}');
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> loadPreviousQuestions() async {
    if (isLoadingPrevious.value || currentPage <= 1) return;

    isLoadingPrevious.value = true;
    final previousPage = currentPage - 1;

    try {
      final response = await communityForumRepository.questionsContainerSpace(
          space.contentContainerId, questionsLimit, previousPage);

      if (response.results.isNotEmpty) {
        dataQuestion.insertAll(0, response.results);
        currentPage = previousPage;
      }
    } catch (e) {
      print('Error loading previous questions: ${e.toString()}');
    } finally {
      isLoadingPrevious.value = false;
    }
  }

  // Helper function to format relative time
  String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} año${(difference.inDays / 365).floor() > 1 ? 's' : ''}';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} mes${(difference.inDays / 30).floor() > 1 ? 'es' : ''}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} día${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hora${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minuto${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'Ahora';
    }
  }

  void toggleLikePost(int questionId) async {
    if (userLikes.containsKey(questionId)) {
      return;
    } else {
      userLikes[questionId] = true;
    }

    final questionIndex =
        dataQuestion.indexWhere((question) => question.id == questionId);

    if (questionIndex != -1) {
      if (userLikes[questionId]!) {
        try {
          final question = dataQuestion[questionIndex];
          question.content.likes.total++;
          dataQuestion[questionIndex] = question;
          await communityFeedRepository.addLike(
              "humhub\\modules\\questions\\models\\Question",
              dataQuestion[questionIndex].id);
        } catch (e) {
          final question = dataQuestion[questionIndex];
          question.content.likes.total--;
          dataQuestion[questionIndex] = question;
        }
      } else {
        try {
          final question = dataQuestion[questionIndex];
          question.content.likes.total++;
          dataQuestion[questionIndex] = question;
          await communityFeedRepository.addLike(
              "humhub\\modules\\questions\\models\\Question",
              dataQuestion[questionIndex].id);
        } catch (e) {
          final question = dataQuestion[questionIndex];
          question.content.likes.total++;
          dataQuestion[questionIndex] = question;
        }
      }
    }
  }
}
