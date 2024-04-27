import 'package:purematch/model/user.dart';
import 'package:purematch/provider/user_provider.dart';
import 'package:purematch/widget/user_listtile_widget.dart';
import 'package:purematch/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatefulWidget {
  final List<User> users;

  const AddUserPage({
    Key? key,
    this.users = const [],
  }) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  String text = '';
  List<User> selectedUsers = [];
  bool isAddEnabled = false;

  @override
  void initState() {
    super.initState();
    selectedUsers = widget.users;
  }

  bool containsSearchText(User user) {
    final name = user.name;
    final textLower = text.toLowerCase();
    final userLower = name.toLowerCase();

    return userLower.contains(textLower);
  }

  void selectUser(User user) {
    final isSelected = selectedUsers.contains(user);
    setState(() {
          if (isSelected)
            selectedUsers.remove(user);
          else
            selectedUsers = [...selectedUsers, user];
          isAddEnabled = selectedUsers.isNotEmpty;
        });
  }

  showAlertDialog(BuildContext context) {
    Widget close = TextButton(
      child: const Text('Close'),
      onPressed: () => Navigator.of(context).pop(),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Admins Added'),
      content: Text(
          '${selectedUsers.map((e) => e.name).join(', ')} have been added as admins.'),
      actions: [
        close,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void addUser() => showAlertDialog(context);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final allUsers = provider.users;
    final users = allUsers.where(containsSearchText).toList();

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130), child: buildAppBar()),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: users.map((user) {
                  final isSelected = selectedUsers.contains(user);
                  return UserListTileWidget(
                    user: user,
                    isSelected: isSelected,
                    onSelectedUser: selectUser,
                  );
                }).toList(),
              ),
            )
          ],
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.black,
          destinations: const <Widget>[
            Icon(Icons.people_alt_outlined, size: 30, color: Colors.white),
            Icon(Icons.do_not_disturb, size: 30, color: Colors.white54),
            Icon(Icons.messenger_sharp, size: 30, color: Colors.white54),
            Icon(Icons.check_circle_outline_outlined, size: 30, color: Colors.white54)
          ],
        ));
  }

  Widget buildAppBar() {
    return AppBar(
      leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          )),
      title: const Text('Add Admin', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(23, 23, 23, 1),
      elevation: 0,
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: isAddEnabled ? addUser : null,
              child: Text('Add',
                  style: TextStyle(
                      color: isAddEnabled ? Colors.white : Colors.white54,
                      fontSize: 18)),
            )),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() => this.text = text),
          hintText: 'Search for a user',
        ),
      ),
    );
  }
}
