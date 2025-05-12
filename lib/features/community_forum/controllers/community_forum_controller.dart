import 'package:comunidadesucv/features/communities/data/dto/space_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityForumController extends GetxController {
  final Space space = Get.arguments;
  final Rx<IconData> spaceIcon = Rx<IconData>(Icons.group); // Icono por defecto

  @override
  void onInit() {
    super.onInit();
    _setSpaceIcon();
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
}
