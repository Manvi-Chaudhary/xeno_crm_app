import 'package:firebase_auth/firebase_auth.dart';


class Authentication{

  static Authentication sharedAuth = Authentication();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future signInWithGoogle() async {
    try {
      UserCredential res;
      GoogleAuthProvider _googleauthprovider = GoogleAuthProvider();
      res = await _auth.signInWithProvider(_googleauthprovider);
      return res.user!.uid;
    } catch (e) {
      print("error "+e.toString());
      return null;
    }
  }
}