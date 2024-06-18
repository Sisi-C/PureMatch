import 'package:purematch/model/user.dart';
import 'package:purematch/provider/user_provider.dart';
import 'package:purematch/widget/admin_listtile_widget.dart';
import 'package:purematch/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  final List<User> users;

  const AdminPage({
    Key? key,
    this.users = const [],
  }) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String text = '';
  List<User> selectedUsers = [];
  bool isAddEnabled = false;
  bool _searchBoolean = false;

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
      child: const Text(
        'Close',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Admins Added',
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center),
      content: Text(
          '${selectedUsers.map((e) => e.name).join(', ')} have been added as admins.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center),
      actions: [
        Expanded(
            child: Center(
          child: close,
        ))
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
    List<User> users = allUsers.where(containsSearchText).toList();
    Iterable<User> admin = users.where((user) => user.role == 'Admin');
    Iterable<User> moderator = users.where((user) => user.role == 'Moderator');

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: !_searchBoolean
                  ? IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = true;
                        });
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = false;
                        });
                      },
                    )),
          backgroundColor: const Color.fromRGBO(23, 23, 23, 1),
          title: !_searchBoolean
              ? const Text('Users', style: TextStyle(color: Colors.white))
              : SearchWidget(
                  text: text,
                  onChanged: (text) => setState(() => this.text = text),
                  hintText: 'Search for a user',
                ),
          actions: <Widget>[
            TextButton(
                child: const Text(
                  "Edit",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {})
          ],
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "Admins",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            Expanded(
              child: ListView(
                children: admin.map((user) {
                  return AdminListTileWidget(
                    admin: user,
                  );
                }).toList(),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text(
                  "Moderator",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            Expanded(
              child: ListView(
                children: moderator.map((moderator) {
                  return AdminListTileWidget(
                    admin: moderator,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.black,
          destinations: const <Widget>[
            Icon(Icons.people_alt_outlined, size: 30, color: Colors.white),
            Icon(Icons.do_not_disturb, size: 30, color: Colors.white54),
            Icon(Icons.messenger_sharp, size: 30, color: Colors.white54),
            Icon(Icons.check_circle_outline_outlined,
                size: 30, color: Colors.white54)
          ],
        ));
  }

  Widget buildAppBar() {
    return AppBar(
      leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: !_searchBoolean
              ? IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {},
                )
              : IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {},
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
