import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double emojiRating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('image/b1.jpg'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Center(
                child: Container(
                  child: Text(
                    'กรุณาให้คะแนน จุดบริการ...',
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  allowHalfRating: false,
                  unratedColor: Colors.blue[200],
                  itemCount: 5,
                  itemSize: 230.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  updateOnDrag: true,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return IconButton(
                          iconSize: 300,
                          onPressed: () {
                            debugPrint('Hi there');
                          },
                          icon: Ink.image(
                            image: const AssetImage('image/1.png'),
                          ),
                        );
                      /*Icon(
                          Icons.sentiment_very_dissatisfied,
                          color:
                              emojiRating == 1 ? Colors.red : Colors.blue[200],
                        );*/
                      case 1:
                        return IconButton(
                          iconSize: 300,
                          onPressed: () {
                            debugPrint('Hi there');
                          },
                          icon: Ink.image(
                            image: const AssetImage('image/2.png'),
                          ),
                        );
                      /*Icon(
                          Icons.sentiment_dissatisfied,
                          color: emojiRating == 2
                              ? Colors.redAccent
                              : Colors.blue[200],
                        );*/
                      case 2:
                        return IconButton(
                          iconSize: 300,
                          onPressed: () {
                            debugPrint('Hi there');
                          },
                          icon: Ink.image(
                            image: const AssetImage('image/3.png'),
                          ),
                        );
                      /*Icon(
                          Icons.sentiment_neutral,
                          color: emojiRating == 3
                              ? Colors.amber
                              : Colors.blue[200],
                        );*/
                      case 3:
                        return IconButton(
                          iconSize: 300,
                          onPressed: () {
                            debugPrint('Hi there');
                          },
                          icon: Ink.image(
                            image: const AssetImage('image/4.png'),
                          ),
                        );
                      /*Icon(
                          Icons.sentiment_satisfied,
                          color: emojiRating == 4
                              ? Colors.lightGreen
                              : Colors.blue[200],
                        );*/
                      case 4:
                        return IconButton(
                          iconSize: 300,
                          onPressed: () {
                            debugPrint('Hi there');
                          },
                          icon: Ink.image(
                            image: const AssetImage('image/5.png'),
                          ),
                        );
                      /*Icon(
                          Icons.sentiment_very_satisfied,
                          color: emojiRating == 5
                              ? Colors.green
                              : Colors.blue[200],
                        );*/
                      default:
                        return Container();
                    }
                  },
                  onRatingUpdate: (ratingvalue) {
                    setState(() {
                      emojiRating = ratingvalue;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                emojiRating == 1
                    ? 'น้อยมาก'
                    : emojiRating == 2
                        ? 'น้อย'
                        : emojiRating == 3
                            ? 'พอใช้'
                            : emojiRating == 4
                                ? 'ดี'
                                : emojiRating == 5
                                    ? 'ดีมาก'
                                    : '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                    color: Colors.red[600]),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'ขอบคุณที่ใช้บริการ',
                style: TextStyle(fontSize: 50, color: Colors.blue[900]),
              ),
              Text(
                'Thank you',
                style: TextStyle(fontSize: 50, color: Colors.blue[900]),
              )
            ],
          ),
        ),
      ]),
    ));
  }
}
