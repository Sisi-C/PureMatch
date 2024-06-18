import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RoleMenuWidget extends StatefulWidget {
  const RoleMenuWidget(BuildContext context, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StatefulBottomSheetState createState() => _StatefulBottomSheetState();
}

class _StatefulBottomSheetState extends State<RoleMenuWidget> {
  String _selectedRole = "None";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back_ios_new_rounded),
                    const Text(
                      "         Role",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                        onPressed: () {
                          _showAlertDialog(context, _selectedRole);
                        },
                        child: const Text(
                          "Assign",
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        )),
                  ]),
            ),
            const Divider(
              height: 1,
              thickness: 2,
              color: Colors.grey,
            ),
            roleMenu(context, "Admin"),
            roleMenu(context, "Moderator")
          ],
        ),
      ),
    );
  }

  Widget roleMenu(BuildContext context, String role) {
    return Column(children: [
      ListTile(
        leading: (_selectedRole == role)
            ? const Icon(
                Icons.check_circle,
                color: Colors.blue,
              )
            : const Icon(
                Icons.circle_outlined,
                color: Colors.grey,
              ),
        title: Text(
          role,
          style: const TextStyle(fontSize: 18),
        ),
        onTap: () {
          setState(() {
            _selectedRole = role;
          });
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

  void _showAlertDialog(BuildContext context, String role) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Assign as $_selectedRole?'),
        content: Text('Are you sure you want to give this user $_selectedRole privileges?'),
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
            child: const Text('Assign', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}
