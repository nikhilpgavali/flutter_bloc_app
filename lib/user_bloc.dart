import 'dart:async';

import 'User.dart';
import 'users_service.dart';

class UserBLoC {
  Stream<List<User>> get usersList async* {
    print("++++++");
    yield await UserService.browse();
  }

  final StreamController<int> _userCounter = StreamController<int>();

  Stream<int> get userCounter => _userCounter.stream;

  UserBLoC() {
    usersList.listen((list) => _userCounter.add(list.length));
  }
}
