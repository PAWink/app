import 'package:app/detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/welcome/welcome.dart';

class Rating extends StatefulWidget {
  final String deptId;
  final String deptName;
  const Rating({Key? key, required this.deptId, required this.deptName})
      : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double emojiRating = 0;
  List data = [];
  late Timer _timer;
  bool _isButtonDisabled = false;
  int _countdown = 30;

  // Method to start the timer
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_countdown == 0) {
        setState(() {
          _isButtonDisabled = false;
        });
        timer.cancel();
      }
      if (this.mounted) {
        setState(() {
          // Perform state update here
          _countdown--;
        });
      }
    });
  }

  // Method to handle button click
  void handleButtonClick(double rating) {
    setState(() {
      _isButtonDisabled = true;
      _countdown = 30; // Reset the countdown
    });

    // Start the timer
    startTimer();

    // Perform your rating logic here
    insertRating(rating);
  }

  @override
  void initState() {
    super.initState();
    startTimer(); // Start the timer when the widget is initialized
  }

  Future<void> insertRating(double rating) async {
    String apiUrl = 'http://10.0.2.2/satisfy/postdata.php';
    String token =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluc2F0aXNmeSJ9.tFEPJ4vS29s6P-5YO_VGz9CoGMwQdbj38Gg4JHrdeZE';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          'point': rating.toString(),
          'deptid': widget.deptId,
        }),
      );

      if (response.statusCode == 200) {
        // Data successfully inserted
        print('Rating inserted successfully!');
        print(widget.deptId);
      } else {
        // Failed to insert data
        print('Failed to insert rating. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred while inserting rating: $e');
    }
  }

  String getDeptNameById(String deptId) {
    for (var item in data) {
      if (item['deptid'].toString() == deptId) {
        return item['deptname'];
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('image/b1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          // Handle double-tap to exit the app
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Detail(
                                deptId: widget.deptId,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          child: Image(
                            image: AssetImage('image/setting.png'),
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      // Handle double-tap to exit the app
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Image(
                        image: AssetImage('image/logo.png'),
                        width: 220,
                      ),
                    ),
                  ),
                  /*SizedBox(
                    height: 10,
                  ),*/
                  Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.deptName}',
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'กรุณาให้คะแนนความพึงพอใจ',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      allowHalfRating: false,
                      unratedColor: Colors.blue[200],
                      itemCount: 5,
                      itemSize: 150.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      updateOnDrag: true,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return IgnorePointer(
                              ignoring: _isButtonDisabled,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 300,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.white70,
                                          duration: Duration(seconds: 1),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ขอบคุณที่ใช้บริการ",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "THANK YOU",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        if (mounted) {
                                          // Perform state update here
                                          emojiRating = 1;
                                        }
                                      });

                                      handleButtonClick(emojiRating);
                                    },
                                    icon: Ink.image(
                                      image: AssetImage('image/1.png'),
                                    ),
                                  ),
                                  /*_isButtonDisabled
                                      ? Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white70,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$_countdown',
                                                style: TextStyle(
                                                  fontSize: 100,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),*/
                                ],
                              ),
                            );

                          case 1:
                            return IgnorePointer(
                              ignoring: _isButtonDisabled,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 300,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.white70,
                                          duration: Duration(seconds: 1),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ขอบคุณที่ใช้บริการ",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "THANK YOU",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        if (mounted) {
                                          // Perform state update here
                                          emojiRating = 2;
                                        }
                                      });

                                      handleButtonClick(emojiRating);
                                    },
                                    icon: Ink.image(
                                      image: AssetImage('image/2.png'),
                                    ),
                                  ),
                                  /* _isButtonDisabled
                                      ? Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white70,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$_countdown',
                                                style: TextStyle(
                                                  fontSize: 100,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),*/
                                ],
                              ),
                            );

                          case 2:
                            return IgnorePointer(
                              ignoring: _isButtonDisabled,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 300,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.white70,
                                          duration: Duration(seconds: 1),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ขอบคุณที่ใช้บริการ",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "THANK YOU",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        if (mounted) {
                                          // Perform state update here
                                          emojiRating = 3;
                                        }
                                      });

                                      handleButtonClick(emojiRating);
                                    },
                                    icon: Ink.image(
                                      image: AssetImage('image/3.png'),
                                    ),
                                  ),
                                  /* _isButtonDisabled
                                      ? Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white70,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$_countdown',
                                                style: TextStyle(
                                                  fontSize: 100,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),*/
                                ],
                              ),
                            );

                          case 3:
                            return IgnorePointer(
                              ignoring: _isButtonDisabled,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 300,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.white70,
                                          duration: Duration(seconds: 1),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ขอบคุณที่ใช้บริการ",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "THANK YOU",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        if (mounted) {
                                          // Perform state update here
                                          emojiRating = 4;
                                        }
                                      });

                                      handleButtonClick(emojiRating);
                                    },
                                    icon: Ink.image(
                                      image: AssetImage('image/4.png'),
                                    ),
                                  ),
                                  /* _isButtonDisabled
                                      ? Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white70,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$_countdown',
                                                style: TextStyle(
                                                  fontSize: 100,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),*/
                                ],
                              ),
                            );

                          case 4:
                            return IgnorePointer(
                              ignoring: _isButtonDisabled,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 300,
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.white70,
                                          duration: Duration(seconds: 1),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ขอบคุณที่ใช้บริการ",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "THANK YOU",
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                      setState(() {
                                        if (mounted) {
                                          // Perform state update here
                                          emojiRating = 5;
                                        }
                                      });

                                      handleButtonClick(emojiRating);
                                    },
                                    icon: Ink.image(
                                      image: AssetImage('image/5.png'),
                                    ),
                                  ),
                                  /* _isButtonDisabled
                                      ? Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white70,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '$_countdown',
                                                style: TextStyle(
                                                  fontSize: 100,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),*/
                                ],
                              ),
                            );
                          default:
                            return Container();
                        }
                      },
                      onRatingUpdate: (ratingValue) {
                        setState(() {
                          emojiRating = ratingValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'น้อยมาก   ',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' น้อย   ',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '  พอใช้   ',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '    ดี   ',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '    ดีมาก   ',
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  /*SizedBox(
                    height: 40,
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
                      fontSize: 120,
                      color: Colors.red[600],
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
