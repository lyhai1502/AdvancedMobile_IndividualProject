import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:my_app/model/user.dart';
import 'package:provider/provider.dart';

class SetttingScreen extends StatefulWidget {
  const SetttingScreen({Key? key}) : super(key: key);

  @override
  _SetttingScreenState createState() => _SetttingScreenState();
}

class _SetttingScreenState extends State<SetttingScreen> {
  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();

    return Container(
      margin: const EdgeInsets.all(20),
      child: ListView(
        children: [
          // user card

          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () {},
                icons: Icons.info_rounded,
                iconStyle: IconStyle(
                  backgroundColor: Colors.purple,
                ),
                title: 'About',
                subtitle: "Learn more about app",
              ),
            ],
          ),
          // You can add a settings title
          SettingsGroup(
            settingsGroupTitle: "Account",
            items: [
              SettingsItem(
                onTap: () {
                  Navigator.pushNamed(context, '/Profile');
                },
                icons: CupertinoIcons.person,
                title: "Profile",
              ),
              SettingsItem(
                onTap: () {
                  CoolAlert.show(
                    confirmBtnText: 'OK',
                    context: context,
                    type: CoolAlertType.success,
                    text: 'Become a tutor successfuly!',
                  );
                },
                icons: CupertinoIcons.book,
                title: "Becoming a tutor",
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SettingsItem(
                onTap: () {
                  CoolAlert.show(
                      context: context,
                      type: CoolAlertType.confirm,
                      text: 'Do you want to sign out',
                      confirmBtnText: 'Yes',
                      confirmBtnColor: Colors.green,
                      onConfirmBtnTap: () {
                        user.cleanUser();
                        Navigator.pop(context);
                      });
                },
                icons: Icons.exit_to_app_rounded,
                title: "Sign Out",
              ),
              SettingsItem(
                onTap: () {},
                icons: CupertinoIcons.delete_solid,
                title: "Delete account",
                titleStyle: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
