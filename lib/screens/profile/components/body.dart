import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/user_model.dart';
import 'package:plant_app/providers/my_bottom_nav_provider.dart';
import 'package:plant_app/screens/profile/edit_profile_screen.dart';
import 'package:plant_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'profile_menu.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Auth>(context, listen: true).user;

    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Column(
        children: [
          user.avatarImgPath != null
              ? CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.12,
                  backgroundColor: kPrimaryColor,
                  backgroundImage: NetworkImage(
                    '${api}/image?path=${user.avatarImgPath}',
                    headers: {'Connection': 'keep-alive'},
                  ),
                )
              : CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.12,
                  backgroundColor: Color(0xFFE7EBEE),
                  child: Image.asset(
                    'assets/icons/avatar.png',
                    color: kPrimaryColor,
                  ),
                ),
          Text(
            user.email,
            style: TextStyle(
              color: kTextLightColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
            text: 'Log Out',
            icon: "assets/icons/Log out.svg",
            press: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.popUntil(context, (route) => route.isFirst);
              Provider.of<BottomNavigatorProvider>(context, listen: false)
                  .changeIndex(index: 0);
            },
          ),
        ],
      ),
    );
  }
}
