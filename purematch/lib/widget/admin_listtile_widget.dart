import 'package:flutter/cupertino.dart';
import 'package:purematch/model/user.dart';
import 'package:purematch/widget/photo_widget.dart';
import 'package:flutter/material.dart';
import './role_menu.dart';

class AdminListTileWidget extends StatelessWidget {
  final User admin;
  const AdminListTileWidget({Key? key, required this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: PhotoWidget(id: admin.id, url: admin.photo),
        title: Text(admin.name,
            style: const TextStyle(
                color: Color.fromRGBO(230, 230, 230, 1),
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        subtitle: Text('${admin.role} since ${admin.joinedAt}',
            style: const TextStyle(color: Colors.white54, height: 1.5)),
        onTap: () {
          showAdminBottomSheet(context);
        },
        tileColor: const Color.fromRGBO(44, 45, 48, 1),
      ),
    );
  }

  void showAdminBottomSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Wrap(
            runSpacing: 10,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  PhotoWidget(id: admin.id, url: admin.photo),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(admin.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(
                height: 1,
                thickness: 2,
                color: Colors.grey,
                indent: 16,
                endIndent: 16,
              ),
              adminMenu(context, const Icon(Icons.clear_rounded),
                  'Remove as ${admin.role}', _showBanDialog),
              adminMenu(context, const Icon(Icons.assignment_ind_outlined),
                  'Change role', showRoleAssignBottomSheet, "Role"),
              adminMenu(context, const Icon(Icons.message_outlined),
                  'Send message', show),
              adminMenu(
                  context,
                  const Icon(Icons.warning_amber_rounded),
                  'Send warning',
                  showMenuBottomSheet,
                  "Sending a warning",
                  "Why are you sending a warning to this admin?",
                  "This admin will receive a warning message from True Master.",
                  "Warning has been sent!",
                  "has received a warning for"),
              cancleButton(context)
            ],
          ),
        );
      },
    );
  }

  Widget cancleButton(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget adminMenu(BuildContext context, Icon icon, String menu, Function opTap,
      [String? topic,
      String? question,
      String? description,
      String? menuTopic,
      String? message]) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: icon,
          title: Text(menu, style: const TextStyle(fontSize: 20)),
          visualDensity: const VisualDensity(vertical: -4),
          onTap: () {
            Navigator.pop(context);
            if (menu == "Send warning" || menu == "Ban admin") {
              opTap(context, topic, question, description, menuTopic, message);
            } else {
              opTap(context);
            }
          },
        ),
        const Divider(
          height: 1,
          thickness: 2,
          color: Colors.grey,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }

  void show() {}

   void _showBanDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Are you sure want to remove this user ?'),
        content: Text('this user will lose all ${admin.role} privileges.'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancle', style: TextStyle(color: Colors.blue),),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }

  void showRoleAssignBottomSheet(BuildContext context, String topic) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return RoleMenuWidget(context);
      },
    );
  }

  void showMenuBottomSheet(BuildContext context, String topic, String question,
      String description, String menuTopic, String message) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        showDragHandle: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Wrap(
              runSpacing: 4,
              children: <Widget>[
                Center(
                  child: Text(
                    topic,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(question,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(description),
                    ],
                  ),
                ),
                reasonMenu(
                    context, 'Nudity or sexual activity', menuTopic, message),
                reasonMenu(
                    context, 'Hate speech or symbols', menuTopic, message),
                reasonMenu(context, 'False information', menuTopic, message),
                reasonMenu(context, 'Scam or fraud', menuTopic, message),
                reasonMenu(context, 'Violence or dangerous organization',
                    menuTopic, message),
                reasonMenu(context, 'Intellectual property violation',
                    menuTopic, message),
                reasonMenu(context, 'Sale or illegal or regulated goods',
                    menuTopic, message),
                reasonMenu(
                    context, 'Suicide or self-injury', menuTopic, message),
                reasonMenu(context, 'Something else', menuTopic, message),
                cancleButton(context)
              ],
            ),
          );
        });
  }

  Widget reasonMenu(
      BuildContext context, String reason, String menuTopic, String message) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              reason,
              style: const TextStyle(fontSize: 20),
            ),
            visualDensity: const VisualDensity(vertical: -4),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
              showSelectedMenuBottomSheet(context, menuTopic, message, reason);
            },
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
          )
        ]);
  }

  void showSelectedMenuBottomSheet(
    BuildContext context,
    String menuTopic,
    String message,
    String reason,
  ) {
    String adminName = admin.name;
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.check_circle,
                  size: 120,
                  color: Colors.green,
                ),
                Text(
                  menuTopic,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$adminName $message $reason',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Undo",
                      style: TextStyle(fontSize: 20),
                    )),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Okay",
                      style: TextStyle(fontSize: 20),
                    )),
              ],
            ));
      },
    );
  }
}
