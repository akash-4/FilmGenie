import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final DateTime timestamp = DateTime.now();
final usersRef = Firestore.instance.collection("users");

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, displayName: user.displayName, email: user.email)
        : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future signInAnon() async {
    final FirebaseMessaging _fcm = FirebaseMessaging();
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      String fcmToken = await _fcm.getToken();
      final DocumentSnapshot token = await usersRef
          .document(user.uid)
          .collection('tokens')
          .document(fcmToken)
          .get();
      if (!token.exists) {
        if (fcmToken != null) {
          var tokens = usersRef
              .document(user.uid)
              .collection('tokens')
              .document(fcmToken);

          await tokens.setData({
            'token': fcmToken,
            'createdAt': FieldValue.serverTimestamp(),
            'platform': Platform.operatingSystem
          });
        }
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    final FirebaseMessaging _fcm = FirebaseMessaging();
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      String fcmToken = await _fcm.getToken();
      final DocumentSnapshot token = await usersRef
          .document(user.uid)
          .collection('tokens')
          .document(fcmToken)
          .get();
      if (!token.exists) {
        if (fcmToken != null) {
          var tokens = usersRef
              .document(user.uid)
              .collection('tokens')
              .document(fcmToken);

          await tokens.setData({
            'token': fcmToken,
            'createdAt': FieldValue.serverTimestamp(),
            'platform': Platform.operatingSystem
          });
        }
      }
      return user;
    } catch (error) {
      print(error.toString());
      return error;
    }
  }

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    final FirebaseMessaging _fcm = FirebaseMessaging();
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      final DocumentSnapshot doc = await usersRef.document(user.uid).get();
      if (!doc.exists) {
        usersRef.document(user.uid).setData({
          "id": user.uid,
          "photoUrl": null,
          "email": email,
          "displayName": name,
          "add.": "",
          "timestamp": timestamp,
          "name": null,
          "phoneNo": null,
          'favourites': [],
          'watchList': [],
          "visible": true
        });
      }
      String fcmToken = await _fcm.getToken();
      final DocumentSnapshot token = await usersRef
          .document(user.uid)
          .collection('tokens')
          .document(fcmToken)
          .get();
      if (!token.exists) {
        if (fcmToken != null) {
          var tokens = usersRef
              .document(user.uid)
              .collection('tokens')
              .document(fcmToken);

          await tokens.setData({
            'token': fcmToken,
            'createdAt': FieldValue.serverTimestamp(),
            'platform': Platform.operatingSystem
          });
        }
      }
      await user.sendEmailVerification();

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return error;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<FirebaseUser> login() async {
    final FirebaseMessaging _fcm = FirebaseMessaging();

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    await signingoogle();
    print("User Name : ${user.uid}");
    print("User Name : ${user.displayName}");
    String fcmToken = await _fcm.getToken();
    final DocumentSnapshot token = await usersRef
        .document(user.uid)
        .collection('tokens')
        .document(fcmToken)
        .get();
    if (!token.exists) {
      if (fcmToken != null) {
        var tokens =
            usersRef.document(user.uid).collection('tokens').document(fcmToken);

        await tokens.setData({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(),
          'platform': Platform.operatingSystem
        });
      }
    }
    return user;
  }

  Future signingoogle() async {
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      print('User signed in!: $account');
    }
  }

  createUserInFirestore() async {
    final FirebaseMessaging _fcm = FirebaseMessaging();
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;

    final DocumentSnapshot doc = await usersRef.document(user.uid).get();
    if (!doc.exists) {
      await usersRef.document(user.uid).setData({
        "id": user.uid,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "add.": "",
        "timestamp": timestamp,
        "name": null,
        "phoneNo": null,
        'favourites': [],
        'watchList': [],
        "visible": true
      });
    }
    String fcmToken = await _fcm.getToken();
    final DocumentSnapshot token = await usersRef
        .document(user.uid)
        .collection('tokens')
        .document(fcmToken)
        .get();
    if (!token.exists) {
      if (fcmToken != null) {
        var tokens =
            usersRef.document(user.uid).collection('tokens').document(fcmToken);

        await tokens.setData({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(),
          'platform': Platform.operatingSystem
        });
      }
    }
  }

  deleteToken(User user) async {
    final FirebaseMessaging _fcm = FirebaseMessaging();
    String fcmToken = await _fcm.getToken();
    final DocumentSnapshot token = await usersRef
        .document(user.uid)
        .collection('tokens')
        .document(fcmToken)
        .get();
    if (token.exists) {
      if (fcmToken != null) {
        var tokens =
            usersRef.document(user.uid).collection('tokens').document(fcmToken);

        await tokens.delete();
      }
    }
  }

  logout() {
    googleSignIn.signOut();
  }

  initiateFacebookLogin() async {
    FacebookLogin facebookLogin = new FacebookLogin();
    facebookLogin.logIn(['email']).then((facebookLoginResult) async {
      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.error:
          print("Error");
          // onLoginStatusChanged(false,null);
          break;
        case FacebookLoginStatus.cancelledByUser:
          print("CancelledByUser");
          // onLoginStatusChanged(false,null);
          break;
        case FacebookLoginStatus.loggedIn:
          {
            FacebookAccessToken myToken = facebookLoginResult.accessToken;
            AuthCredential credential =
                FacebookAuthProvider.getCredential(accessToken: myToken.token);
            FirebaseUser firebaseUser =
                (await FirebaseAuth.instance.signInWithCredential(credential))
                    .user;

            final AuthResult authResult =
                await _auth.signInWithCredential(credential);
            FirebaseUser user = authResult.user;
            final FirebaseMessaging _fcm = FirebaseMessaging();
            final DocumentSnapshot doc =
                await usersRef.document(user.uid).get();
            if (!doc.exists) {
              await usersRef.document(user.uid).setData({
                "id": user.uid,
                "photoUrl": user.photoUrl,
                "email": user.email,
                "displayName": user.displayName,
                "add.": "",
                "timestamp": timestamp,
                "name": null,
                "phoneNo": null,
                'favourites': [],
                'watchList': [],
                "visible": true
              });
            }
            String fcmToken = await _fcm.getToken();
            final DocumentSnapshot token = await usersRef
                .document(user.uid)
                .collection('tokens')
                .document(fcmToken)
                .get();
            if (!token.exists) {
              if (fcmToken != null) {
                var tokens = usersRef
                    .document(user.uid)
                    .collection('tokens')
                    .document(fcmToken);

                await tokens.setData({
                  'token': fcmToken,
                  'createdAt': FieldValue.serverTimestamp(),
                  'platform': Platform.operatingSystem
                });
              }
            }
          }
      }
    }).catchError((e) {
      print(e);
    });
  }
}
