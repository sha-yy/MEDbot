import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MEDbotFirebaseUser {
  MEDbotFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

MEDbotFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MEDbotFirebaseUser> mEDbotFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MEDbotFirebaseUser>((user) => currentUser = MEDbotFirebaseUser(user));
