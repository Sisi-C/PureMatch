import 'package:purematch/model/user.dart';

class Utils {
  static int ascendingSort(User a, User b) =>
      a.name.compareTo(b.name);
}
