import 'package:purematch/model/user.dart';
import 'package:purematch/provider/user_provider.dart';
import 'package:purematch/widget/user_listtile_widget.dart';
import 'package:purematch/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatefulWidget {
  final bool isMultiSelection;
  final List<User> users;

  const AddUserPage({
    Key? key,
    this.isMultiSelection = false,
    this.users = const [],
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  String text = '';
  List<User> selectedUsers = [];

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
    );
  }

  Widget buildAppBar() {
    return AppBar(
      leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          )),
      title: const Text('Add Admin'),
      centerTitle: true,
      backgroundColor: const Color.fromRGBO(23, 23, 23, 1),
      elevation: 0,
      actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {},
              child: const Text("Add",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
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

  void selectUser(User user) {
    if (widget.isMultiSelection) {
      final isSelected = selectedUsers.contains(user);
      setState(() =>
          isSelected ? selectedUsers.remove(user) : selectedUsers.add(user));
    } else {
      Navigator.pop(context, user);
    }
  }

}
