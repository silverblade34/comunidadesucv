import 'package:comunidadesucv/config/constants/colors.dart';
import 'package:comunidadesucv/config/constants/constance.dart';
import 'package:comunidadesucv/features/community_detail/data/dto/content_space_dto.dart';
import 'package:comunidadesucv/features/community_feed/controllers/community_feed_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CommunityFeedPage extends GetView<CommunityFeedController> {
  const CommunityFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildAnimatedSearchBar(),
            ),
            _buildCommunityTitle(),
            Expanded(
              child: _buildFeedContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF0E0745),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed("/communities"),
              child: Container(
                padding: const EdgeInsets.all(9),
                child: const Icon(
                  Ionicons.home,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed("/registered_post"),
              child: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: const Color(0xFF8260F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed("/perfil"),
              child: Container(
                padding: const EdgeInsets.all(9),
                child: const Icon(
                  Ionicons.person,
                  color: Colors.grey,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            ConstanceData.LogoUcv,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          const Text(
            'Comunidades Digitales',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(128, 149, 117, 205),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Text(
            'Buscar',
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(6),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget _buildCommunityTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Text(
            controller.space.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: controller.space.lastMemberships.isEmpty
                      ? 0
                      : controller.space.lastMemberships.length == 1
                          ? 28
                          : controller.space.lastMemberships.length == 2
                              ? 28 + 13
                              : controller.space.lastMemberships.length >= 3
                                  ? 28 + 13 + 13
                                  : 0,
                  height: 28,
                  child: Stack(
                    children: [
                      if (controller.space.lastMemberships.isNotEmpty)
                        Positioned(
                          right: 0,
                          child: ClipOval(
                            child: Image.network(
                              controller.space.lastMemberships[0].user.imageUrl,
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if (controller.space.lastMemberships.length > 1)
                        Positioned(
                          right: 15, // 32 * 0.7 = aproximadamente 22
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                controller
                                    .space.lastMemberships[1].user.imageUrl,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      if (controller.space.lastMemberships.length > 2)
                        Positioned(
                          right: 30, // (32 * 0.7) * 2 = aproximadamente 44
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                controller
                                    .space.lastMemberships[2].user.imageUrl,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
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
    );
  }

  Widget _buildFeedContent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.dataPost.isEmpty) {
        return const Center(
            child: Text(
          'No hay publicaciones disponibles',
          style: TextStyle(fontSize: 13),
        ));
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemCount: controller.dataPost.length,
        itemBuilder: (context, index) {
          final post = controller.dataPost[index];
          final user = post.content.metadata.createdBy;

          final hasImage = post.content.files.isNotEmpty;
          final imageId = hasImage ? post.content.files.first['id'] : null;

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
        color: AppColors.textBlackUCV,
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
                    child: Image.network(
                      userImageUrl,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.person,
                            size: 40, color: Colors.grey);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
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
                      fontSize: 14,
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
                  GestureDetector(
                    onTap: () {
                      controller.toggleLike(postId);
                      HapticFeedback.lightImpact();
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                      child: Icon(
                        controller.userLikes[postId] == true
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: controller.userLikes[postId] == true
                            ? Colors.red
                            : Colors.pink,
                        size: 28,
                        key: ValueKey<bool>(
                            controller.userLikes[postId] == true),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${post.content.likes.total}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      _showCommentsModal(context, postId);
                    },
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.lightBlue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${post.content.comments.total}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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

  void _showCommentsModal(BuildContext context, int postId) {
    final TextEditingController commentController = TextEditingController();

    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: const BoxDecoration(
          color: AppColors.textBlackUCV,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            // Título
            const Text(
              'Comentarios',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Obx(() {
                final comments = controller.postComments[postId] ?? [];

                if (comments.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay comentarios aún',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: Image.network(
                              comment.userImage,
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person,
                                    size: 35, color: Colors.grey);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  comment.text,
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
                    );
                  },
                );
              }),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      controller.user.value.profile!.imageUrl,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.person,
                            size: 30, color: Colors.grey);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      decoration: const InputDecoration(
                        hintText: 'Agregar comentario...',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (commentController.text.isNotEmpty) {
                        controller.addComment(postId, commentController.text);
                        commentController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4169E1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}
