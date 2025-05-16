import 'package:comunidadesucv/core/models/question.dart';
import 'package:comunidadesucv/core/widgets/custom_alert_dialog.dart';
import 'package:comunidadesucv/features/community_feed/data/repository/community_feed_repository.dart';
import 'package:comunidadesucv/features/community_forum/data/dto/answers_response_dto.dart';
import 'package:comunidadesucv/features/community_forum/data/repository/community_forum_repository.dart';
import 'package:get/get.dart';

class QuestionDetailController extends GetxController {
  final Question question = Get.arguments;
  RxList<Answer> answers = <Answer>[].obs;
  RxBool isLoading = true.obs;
  RxString sortOrder = "recent".obs;
  RxInt likes = 0.obs;
  bool isLiked = false;

  final CommunityForumRepository communityForumRepository =
      CommunityForumRepository();
  CommunityFeedRepository communityFeedRepository = CommunityFeedRepository();

  @override
  void onInit() {
    super.onInit();
    getAnswers();
    likes.value = question.content.likes.total;
  }

  Future<void> getAnswers() async {
    isLoading.value = true;
    try {
      final response = await communityForumRepository.getAnswers(question.id);
      answers.value = response.answers;
      sortAnswers();
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void sortAnswers() {
    if (sortOrder.value == "recent") {
      answers.sort((a, b) => b.id.compareTo(a.id));
    } else if (sortOrder.value == "votes") {
      answers.sort((a, b) => b.votesSummary.compareTo(a.votesSummary));
    }

    if (question.bestAnswer != null) {
      final bestAnswerIndex =
          answers.indexWhere((answer) => answer.id == question.bestAnswer);
      if (bestAnswerIndex != -1) {
        final bestAnswer = answers.removeAt(bestAnswerIndex);
        answers.insert(0, bestAnswer);
      }
    }
  }

  void changeSortOrder(String order) {
    sortOrder.value = order;
    sortAnswers();
  }

  Future<void> postAnswer(String answerText) async {
    try {
      await communityForumRepository.publishAnswerQuestion(
          question.id, answerText);
      try {
        final response = await communityForumRepository.getAnswers(question.id);
        answers.value = response.answers;
        sortAnswers();
      } catch (e) {
        print(e.toString());
      }
    } catch (e) {
      CustomAlertDialog.show(
        status: 'warning',
        message: '¡Atención!',
        description:
            'No se ha podido registrar su respuesta, intentelo de nuevo mas tarde por favor',
        buttonText: 'Aceptar',
        onAccept: () {
          print('Usuario confirmó la acción');
        },
      );
    }
  }

  Future<void> voteUpAnswer(int answerId) async {
    try {
      await communityForumRepository.voteUpAnswers(answerId);

      final index = answers.indexWhere((answer) => answer.id == answerId);
      if (index != -1) {
        final updatedAnswer = answers[index];
        updatedAnswer.votesSummary += 1;
        answers[index] = updatedAnswer;
        answers.refresh();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> voteDownAnswer(int answerId) async {
    try {
      await communityForumRepository.voteDownAnswers(answerId);

      final index = answers.indexWhere((answer) => answer.id == answerId);
      if (index != -1) {
        final updatedAnswer = answers[index];
        updatedAnswer.votesSummary -= 1;
        answers[index] = updatedAnswer;
        answers.refresh();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> markAsBestAnswer(int answerId) async {
    // try {
    //   await communityForumRepository.markAsBestAnswer(question.id, answerId);

    //   // Actualizar la pregunta localmente
    //   question.bestAnswer = answerId;

    //   // Reordenar las respuestas
    //   sortAnswers();

    //   Get.snackbar('Éxito', 'Mejor respuesta marcada correctamente');
    // } catch (e) {
    //   Get.snackbar('Error', 'No se pudo marcar como mejor respuesta');
    // }
  }

  bool isQuestionAuthor() {
    return false;
    // // Verificar si el usuario actual es el autor de la pregunta
    // // Esto dependerá de cómo manejas la autenticación en tu app
    // final currentUserId = Get.find<UserController>().user.value.id;
    // return currentUserId == question.createdBy.id;
  }

  void toggleLikePost() async {
    try {
      likes.value++;
      isLiked = true;
      await communityFeedRepository.addLike(
          "humhub\\modules\\questions\\models\\Question", question.id);
    } catch (e) {
      likes.value--;
    }
  }
}
