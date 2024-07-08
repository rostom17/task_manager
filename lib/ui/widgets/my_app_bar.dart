import 'package:flutter/material.dart';
import 'package:task_manager/ui/controller/authentication_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';
import 'package:task_manager/ui/utilities/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {super.key, required this.url, required this.fromUpdatedProfile});

  final String url;
  final bool fromUpdatedProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.themeColor,
      leading: CircleAvatar(
        child: CachedNetworkImage(
          imageUrl: url,
          progressIndicatorBuilder: (_, __, ____) {
            return const CircularProgressIndicator();
          },
          errorWidget: (_, __, ___) {
            return const Icon(Icons.ac_unit);
          },
        ),
      ),
      title: GestureDetector(
        onTap: () {
          if (fromUpdatedProfile == true) return;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${AuthenticationController.userData?.firstName ?? ''} ${AuthenticationController.userData?.lastName ?? ''}',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.forgroundColor),
            ),
            Text(
              AuthenticationController.userData?.email ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.forgroundColor,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            AuthenticationController.clearAllData();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                (route) => false);
          },
          icon: const Icon(
            Icons.logout,
            color: AppColors.forgroundColor,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
