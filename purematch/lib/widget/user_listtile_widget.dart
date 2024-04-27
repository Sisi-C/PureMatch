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
        onTap: () => onSelectedUser(user),
        tileColor: const Color.fromRGBO(44, 45, 48, 1),
      ),
    );
  }
}
