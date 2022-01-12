import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/custom/custom_cache_manager.dart';
import 'package:plant_app/models/user_model.dart';
import 'package:plant_app/screens/profile/edit_profile_screen.dart';
import 'package:plant_app/screens/profile/feedback_screen.dart';
import 'package:plant_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Auth>(context, listen: true).user;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(color: Color(0xFFE7EBEE)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(65),
              child: user.avatarImgPath != null
                  ? CachedNetworkImage(
                      imageUrl: '${url}/${user.avatarImgPath}',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  color: kPrimaryColor)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      cacheManager: CustomCacheManager.instance,
                    )
                  : Image.asset(
                      'assets/images/avatar.png',
                      color: kPrimaryColor,
                      // fit: BoxFit.fill,
                    ),
            ),
          ),
          Text(
            user.email,
            style: TextStyle(
              color: kTextLightColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 14),
          ProfileMenu(
            text: 'Edit Profile',
            icon: 'assets/icons/User Icon.svg',
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
          ProfileMenu(
            text: 'Feedback/Report Issue',
            icon: 'feedback',
            // text: 'Help Center',
            // icon: 'assets/icons/Question mark.svg',

            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackScreen()),
              );
            },
          ),
          ProfileMenu(
            text: 'Log Out',
            icon: "assets/icons/Log out.svg",
            press: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
