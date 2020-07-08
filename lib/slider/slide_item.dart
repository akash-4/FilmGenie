import '../constants/color.dart';
import '../slider/slide_dots.dart';
import 'package:flutter/material.dart';
import '../models/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  final int current_Page;
  SlideItem({this.index, this.current_Page});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: (index == 0)
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(slideList[index].imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Icon(
                    slideList[index].ico,
                    size: MediaQuery.of(context).size.height * 0.25,
                    color: Colors.red,
                  ),
                ),
        ),
        SizedBox(
          height: 10,
        ),
        (MediaQuery.of(context).size.height > 500)
            ? Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.repeated,
                  colors: [AppTheme.black1, AppTheme.black1],
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(55, 5, 55, 0),
                      child: Text(
                        slideList[index].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Proxima Nova",
                            fontWeight: FontWeight.w700,
                            fontSize: (MediaQuery.of(context).size.height < 600)
                                ? MediaQuery.of(context).size.height * 0.02
                                : 22,
                            color: AppTheme.offWhite),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.03),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < slideList.length; i++)
                                if (i == current_Page)
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ))
            : Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < slideList.length; i++)
                          if (i == current_Page)
                            SlideDots_new(true)
                          else
                            SlideDots_new(false)
                      ],
                    ),
                  )
                ],
              ),
      ],
    );
  }
}
