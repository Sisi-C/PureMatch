import 'dart:convert';

import 'package:purematch/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:purematch/model/user.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class UserProvider with ChangeNotifier {
  UserProvider() {
    load().then((users) {
      _users = users;
      notifyListeners();
    });
  }

  List<User> _users = [];

  List<User> get users => _users;

  Future load() async {
    // final response = await http.get(
    //   Uri.parse(
    //       'https://api.stage.purematch.co/users/sample'),
    // );
    // final usersJson = json.decode(response.body)['users'];

    final response = await rootBundle.loadString('assets/user/users.json');
    final usersJson = json.decode(response)['users'];

    return usersJson.map<User>((json) {
      
      return User.fromJson(json);
    }).toList()
      ..sort(Utils.ascendingSort);
  }
}
