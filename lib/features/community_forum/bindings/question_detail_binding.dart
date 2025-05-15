import 'package:comunidadesucv/features/community_forum/controllers/question_detail_controller.dart';
import 'package:get/get.dart';

class QuestionDetailBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<QuestionDetailController>(() => QuestionDetailController());
  }
}