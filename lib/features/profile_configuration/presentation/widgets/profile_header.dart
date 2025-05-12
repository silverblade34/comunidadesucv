import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String filial;
  final String? profileImageUrl;

  const ProfileHeader({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.filial,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 70, 
            bottom: 16
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$firstName $lastName',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                filial,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -45,
          left: 0,
          child: _buildProfileImage(context),
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF7FFFD4),
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 4,
        ),
      ),
      child: ClipOval(
        child: profileImageUrl != null
            ? Image.network(
                profileImageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _defaultProfileIcon(),
              )
            : _defaultProfileIcon(),
      ),
    );
  }

  Widget _defaultProfileIcon() {
    return const Icon(
      Icons.person,
      size: 40,
      color: Colors.white,
    );
  }
}