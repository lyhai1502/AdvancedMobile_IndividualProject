import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:my_app/model/user.dart';
import 'package:provider/provider.dart';

class SetttingScreen extends StatelessWidget {
  const SetttingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          // user card
          SettingsGroup(
            items: [
              SettingsItem(
                onTap: () {},
                icons: Icons.fingerprint,
                iconStyle: IconStyle(
                  iconsColor: Colors.white,
                  withBackground: true,
                  backgroundColor: Colors.blue,
                ),
                title: 'Privacy',
                subtitle: "Lock to improve your privacy",
              ),
              SettingsItem(
                onTap: () {},
                icons: Icons.dark_mode_rounded,
                iconStyle: IconStyle(
                  iconsColor: Colors.white,
                  withBackground: true,
                  backgroundColor: Colors.red,
                ),
                title: 'Dark mode',
                subtitle: "Automatic",
                trailing: Switch.adaptive(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
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
