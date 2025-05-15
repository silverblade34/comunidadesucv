import 'package:comunidadesucv/features/community_forum/data/dto/answers_response_dto.dart';
import 'package:comunidadesucv/features/community_forum/data/dto/question_response_dto.dart';
import 'package:comunidadesucv/features/community_forum/data/dto/question_space_dto.dart';
import 'package:comunidadesucv/features/community_forum/data/provider/community_forum_provider.dart';

class CommunityForumRepository {
  CommunityForumProvider communityForumProvider = CommunityForumProvider();

  Future<QuestionSpaceDto> questionsContainerSpace(
      int containerId, int limit, int page) async {
    final response = await communityForumProvider.questionsContainerSpace(
        containerId, limit, page);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data);
    }
    return QuestionSpaceDto.fromJson(response.data);
  }

  Future<QuestionResponseDto> publishQuestion(
      String title, String message, int postContainerId) async {
    final response = await communityForumProvider.publishQuestion(
        title, message, postContainerId);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data.toString());
    }

    return QuestionResponseDto.fromJson(response.data);
  }

  Future<AnswersResponseDto> getAnswers(int questionId) async {
    final response = await communityForumProvider.getAnswers(questionId);

    if (response.data == null) {
      throw Exception("No se recibieron datos en la respuesta");
    } else if (response.statusCode == 400) {
      throw Exception("Error desconocido");
    } else if (response.statusCode == 404) {
      throw Exception(response.data.toString());
    }

    return AnswersResponseDto.fromJson(response.data);
  }

  Future<bool> publishAnswerQuestion(int questionId, String answer) async {
    final response =
        await communityForumProvider.publishAnswerQuestion(questionId, answer);

    if (response.statusCode == 200 && response.data != null) {
      return true;
    }

    return false;
  }
}
