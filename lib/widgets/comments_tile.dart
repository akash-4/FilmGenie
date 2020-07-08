import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmgenie/constants/color.dart';
import 'package:filmgenie/models/movieModel.dart';
import 'package:filmgenie/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'package:filmgenie/services/filmGenieDb.dart';

class CommentsTile extends StatefulWidget {
  final Movie movieItem;
  bool c_isEdited;
  final String commentID;
  final String c_dateTime;
  String comment;
  final String c_uid;
  CommentsTile(
      {this.c_dateTime,
      this.c_isEdited,
      this.movieItem,
      this.commentID,
      this.comment,
      this.c_uid});

  @override
  _CommentsTileState createState() => _CommentsTileState(comment: comment);
}

class _CommentsTileState extends State<CommentsTile> {
  String comment;
  String c_name = "";
  String c_photo = "";
  _CommentsTileState({this.comment});
  bool _isEditingText = false;
  TextEditingController _editingController;
  TextEditingController _addingController;
  Future _future;
  final _formKey = GlobalKey<FormState>();
  Future fetch() async {
    final DocumentSnapshot userDoc = await Firestore.instance
        .collection('users')
        .document(widget.c_uid)
        .get();

    setState(() {
      c_name = userDoc.data['displayName'];
      c_photo = userDoc.data['photoUrl'];
    });
  }

  @override
  void initState() {
    super.initState();
    _future = fetch();
    _editingController = TextEditingController(text: comment);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    final now = DateTime.now();
    final t = DateTime(now.year, now.month, now.day).toString();
    final y = DateTime(now.year, now.month, now.day - 1).toString();
    final tom = DateTime(now.year, now.month, now.day + 1).toString();
    final String today =
        t.substring(8, 10) + "/" + t.substring(5, 7) + "/" + t.substring(2, 4);

    final String yesterday =
        y.substring(8, 10) + "/" + y.substring(5, 7) + "/" + y.substring(2, 4);

    final String tomorrow = tom.substring(8, 10) +
        "/" +
        tom.substring(5, 7) +
        "/" +
        tom.substring(2, 4);

    String date = "";

    date = widget.c_dateTime.substring(8, 10) +
        "/" +
        widget.c_dateTime.substring(5, 7) +
        "/" +
        widget.c_dateTime.substring(2, 4);

    return FutureBuilder(
        future: _future,
        builder: (ctx, snapshot) {
          return Form(
              key: _formKey,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      _isEditingText = !_isEditingText;
                    });
                  },
                  child: Card(
                    elevation: 0.3,
                    color: AppTheme.black2,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  (c_photo != null)
                                      ? CircleAvatar(
                                          radius: 18,
                                          backgroundColor: AppTheme.black2,
                                          backgroundImage:
                                              NetworkImage(c_photo),
                                        )
                                      : CircleAvatar(
                                          radius: 18,
                                          backgroundColor: AppTheme.black2,
                                          child: Text(
                                            c_name.substring(0, 1),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                c_name + " ",
                                                style: TextStyle(
                                                    color: null,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                (date == today)
                                                    ? "Today"
                                                    : (date == yesterday)
                                                        ? "Yesterday"
                                                        : (date == tomorrow)
                                                            ? "Tomorrow"
                                                            : date,
                                                style: TextStyle(
                                                    color: null, fontSize: 12),
                                              ),
                                              Text(
                                                "," +
                                                    widget.c_dateTime
                                                        .toString()
                                                        .substring(11, 16),
                                                style: TextStyle(
                                                    color: null, fontSize: 12),
                                              ),
                                              (widget.c_isEdited)
                                                  ? Text(
                                                      " (edited)",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          Text(
                                            comment,
                                            style: TextStyle(
                                              color: null,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  (widget.c_uid == user.uid)
                                      ? PopupMenuButton<String>(
                                          padding: EdgeInsets.all(0),
                                          onCanceled: () {
                                            print(
                                                "You have canceled the menu.");
                                          },
                                          onSelected: (value) {
                                            if (value == "Delete") {
                                              showDialog(
                                                context: context,
                                                child: AlertDialog(
                                                  content: Text(
                                                    'Delete Review?',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  actions: [
                                                    FlatButton(
                                                      child: Text('No',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red,
                                                          )),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    FlatButton(
                                                      color: Colors.red,
                                                      child: Text('Yes'),
                                                      onPressed: () {
                                                        FilmGenie
                                                            .deleteComments(
                                                                widget.movieItem
                                                                    .id,
                                                                widget
                                                                    .commentID);
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                            if (value == "Edit") {
                                              setState(() {
                                                _isEditingText =
                                                    !_isEditingText;
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            MdiIcons.dotsVertical,
                                            color: Colors.red,
                                            size: 20.0,
                                          ),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: "Delete",
                                              child: Text("Delete",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  )),
                                            ),
                                            PopupMenuItem(
                                              value: "Edit",
                                              child: Text(
                                                "Edit",
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                          (widget.c_uid == user.uid)
                              ? (_isEditingText)
                                  ? Center(child: _editTitleTextField())
                                  : Container(
                                      height: 0,
                                    )
                              : Container(
                                  height: 0,
                                )
                        ],
                      ),
                    ),
                  )));
        });
  }

  Widget _editTitleTextField() {
    if (_isEditingText)
      return Center(
        child: TextFormField(
          validator: (String value) {
            if (value.isEmpty) {
              return "Comment can't empty";
            }
          },
          cursorColor: AppTheme.red,
          decoration: InputDecoration(
              errorStyle: TextStyle(color: AppTheme.red),
              suffixIcon: FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          color: AppTheme.red),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate())
                      _formKey.currentState.save();
                  })),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onSaved: (newValue) {
            setState(() {
              FilmGenie.updateComment(
                  widget.movieItem.id, widget.commentID, newValue);
              debugPrint(widget.commentID);
              comment = newValue;

              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _editingController,
          autocorrect: true,
          textInputAction: TextInputAction.newline,
        ),
      );
  }
}
