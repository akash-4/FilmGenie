import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FilmGenie {
  static Future<void> updateComment(
      int dID, String commentID, String comment) async {
    final QuerySnapshot userDoc = await Firestore.instance
        .collection('allMovies')
        .where('id', isEqualTo: dID)
        .getDocuments();
    String usId = userDoc.documents[0].documentID;
    await Firestore.instance
        .collection('allMovies')
        .document(usId)
        .collection('comments')
        .document(commentID)
        .updateData({
      'comment': comment,
      'isEdited': true,
    });
  }

  static Future<void> addComments(int dID, String comment, String uid) async {
    final userDoc =
        await Firestore.instance.collection('users').document(uid).get();
    final QuerySnapshot useDoc = await Firestore.instance
        .collection('allMovies')
        .where('id', isEqualTo: dID)
        .getDocuments();
    String usId = useDoc.documents[0].documentID;
    await Firestore.instance
        .collection('allMovies')
        .document(usId)
        .collection('comments')
        .document()
        .setData({
      'comment': comment,
      'uid': uid,
      'isEdited': false,
      'datetime': DateTime.now().toIso8601String(),
    });
  }

  static Future<void> deleteComments(int dID, String commentID) async {
    final QuerySnapshot userDoc = await Firestore.instance
        .collection('allMovies')
        .where('id', isEqualTo: dID)
        .getDocuments();
    String usId = userDoc.documents[0].documentID;
    await Firestore.instance
        .collection('allMovies')
        .document(usId)
        .collection('comments')
        .document(commentID)
        .delete();
  }

  static Future<void> updateFavourites(String id, String uid) async {
    final DocumentSnapshot doc =
        await Firestore.instance.collection('users').document(uid).get();
    List f = doc.data['favourites'];
    f.contains(id) ? f.remove(id) : f.add(id);
    await Firestore.instance.collection('users').document(uid).updateData({
      'favourites': f,
    });
  }

  static Future<void> updateWatchList(String id, String uid) async {
    final DocumentSnapshot doc =
        await Firestore.instance.collection('users').document(uid).get();
    List w = doc.data['watchList'];
    w.contains(id) ? w.remove(id) : w.add(id);
    await Firestore.instance.collection('users').document(uid).updateData({
      'watchList': w,
    });
  }

  static Future<void> updateRatings(String id, String uid, int star) async {
    final QuerySnapshot useDoc = await Firestore.instance
        .collection('allMovies')
        .where('id', isEqualTo: int.parse(id))
        .getDocuments();
    String usId = useDoc.documents[0].documentID;
    final DocumentSnapshot doc =
        await Firestore.instance.collection('allMovies').document(usId).get();
    Map<String, dynamic> r = doc.data['rates'] == null ? {} : doc.data['rates'];
    r[uid] = star;
    await Firestore.instance.collection('allMovies').document(usId).updateData({
      'rates': r,
    });
  }

  static Future<void> updateName(String uID, String name) async {
    await Firestore.instance.collection('users').document(uID).updateData({
      'displayName': name,
    });
  }

  static Future<void> startUpload(File imageToUpload, String uid) async {
    StorageUploadTask _uploadTask;

    StorageReference _storageReference =
        FirebaseStorage.instance.ref().child(uid);
    _uploadTask = _storageReference.putFile(imageToUpload);

    await _uploadTask.onComplete.whenComplete(() {
      print('File Uploaded');
      _storageReference.getDownloadURL().then((fileurl) {
        Firestore.instance.collection('users').document(uid).updateData({
          'photoUrl': fileurl,
        });

        print(fileurl);
      });
    });
  }

  static Future<void> updateProfileVisibility(bool visible, String uid) {
    Firestore.instance.collection('users').document(uid).updateData({
      'visible': visible,
    });
  }
}
