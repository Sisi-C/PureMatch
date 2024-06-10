import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:purematch/model/user.dart';
import 'package:purematch/widget/photo_widget.dart';
import 'package:flutter/material.dart';

class UserListTileWidget extends StatelessWidget {
  final User user;
  final bool isSelected;
  final ValueChanged<User> onSelectedUser;

  const UserListTileWidget({
    Key? key,
    required this.user,
    required this.isSelected,
    required this.onSelectedUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: PhotoWidget(id: user.id, url: user.photo),
        title: Text(user.name,
            style: const TextStyle(
                color: Color.fromRGBO(230, 230, 230, 1),
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        subtitle: Text('Member since ${user.joinedAt}',
            style: const TextStyle(color: Colors.white54, height: 1.5)),
        trailing: isSelected
            ? const Icon(
                Icons.check_circle,
                color: Colors.white,
              )
            : const Icon(
                Icons.circle_outlined,
                color: Colors.grey,
              ),
        onTap: () {
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
                        PhotoWidget(id: user.id, url: user.photo),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(user.name,
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
                    userMenu(context, const Icon(Icons.person_add),
                        'Add as admin', show),
                    userMenu(context, const Icon(Icons.person_add),
                        'Add as moderator', show),
                    userMenu(context, const Icon(Icons.message_outlined),
                        'Send message', show),
                    userMenu(
                        context,
                        const Icon(Icons.warning_amber_rounded),
                        'Send warning',
                        showMenuBottomSheet,
                        "Sending a warning",
                        "Why are you sending a warning to this user?",
                        "This user will receive a warning message from True Master.",
                        "Warning has been sent!",
                        "has received a warning for"),
                    userMenu(
                        context,
                        const Icon(Icons.block_flipped),
                        'Ban user',
                        showMenuBottomSheet,
                        "Ban a user",
                        "Why are you banning this user?",
                        "This user will be removed from the app.",
                        "User banned!",
                        "has been removed from the True Master app for"),
                    cancleButton(context)
                  ],
                ),
              );
            },
          );
        },
        tileColor: const Color.fromRGBO(44, 45, 48, 1),
      ),
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

  Widget userMenu(BuildContext context, Icon icon, String menu, Function opTap,
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
            if (menu == "Send warning" || menu == "Ban user") {
              opTap(context, topic, question, description, menuTopic, message);
            } else {
              opTap();
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
      BuildContext context, String reason,String menuTopic, String message) {
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
    String userName = user.name;
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
                  '$userName $message $reason',
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
