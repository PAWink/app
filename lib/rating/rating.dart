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

  Future<void> insertRating(double rating) async {
    String apiUrl = 'http://10.0.2.2/satisfy/postdata.php';
    String token =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluc2F0aXNmeSJ9.tFEPJ4vS29s6P-5YO_VGz9CoGMwQdbj38Gg4JHrdeZE';

    /*Map<String, dynamic> requestData = {
      'depid': '1',
      'point': rating.toString()
    };*/

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

  Future<String> getAllName() async {
    String apiUrl = 'http://10.0.2.2/satisfy/getdata.php';
    String token =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluc2F0aXNmeSJ9.tFEPJ4vS29s6P-5YO_VGz9CoGMwQdbj38Gg4JHrdeZE';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          data = jsonData;
          //deptName = getDeptNameById(widget.deptId);
        });
        print(jsonData);
        return "success";
      } else {
        // Failed to fetch data
        print('Failed to fetch data. Error: ${response.reasonPhrase}');
        return "error";
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred while fetching data: $e');
      return "error";
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
  void initState() {
    super.initState();
    getAllName();
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('image/logo.png'),
                      width: 300,
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
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'กรุณาให้คะแนนความพึงพอใจ',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 40,
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
                      itemSize: 230.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      updateOnDrag: true,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return IconButton(
                              iconSize: 300,
                              onPressed: () {
                                showDialog(
                                  barrierColor: Colors.white.withOpacity(.6),
                                  context: context,
                                  builder: (_) {
                                    Timer(Duration(seconds: 1), () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog after 1 seconds
                                      setState(() {
                                        emojiRating = 1;
                                      });
                                      insertRating(emojiRating);
                                    });
                                    return Dialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "ขอบคุณที่ใช้บริการ",
                                              style: TextStyle(
                                                fontSize: 80,
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "THANK YOU",
                                              style: TextStyle(
                                                fontSize: 80,
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Ink.image(
                                image: AssetImage('image/1.png'),
                              ),
                            );

                          case 1:
                            return IconButton(
                              iconSize: 300,
                              onPressed: () {
                                showDialog(
                                  barrierColor: Colors.white.withOpacity(.6),
                                  context: context,
                                  builder: (_) {
                                    Timer(Duration(seconds: 1), () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        emojiRating = 2;
                                      });
                                      insertRating(emojiRating);
                                    });
                                    return Dialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "ขอบคุณที่ใช้บริการ",
                                              style: TextStyle(
                                                fontSize: 80,
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "THANK YOU",
                                              style: TextStyle(
                                                fontSize: 80,
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Ink.image(
                                image: AssetImage('image/2.png'),
                              ),
                            );

                          case 2:
                            return IconButton(
                              iconSize: 300,
                              onPressed: () {
                                showDialog(
                                    barrierColor: Colors.white.withOpacity(.6),
                                    context: context,
                                    builder: (_) {
                                      Timer(Duration(seconds: 1), () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          emojiRating = 3;
                                        });
                                        insertRating(emojiRating);
                                      });
                                      return Dialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ขอบคุณที่ใช้บริการ",
                                                style: TextStyle(
                                                  fontSize: 80,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "THANK YOU",
                                                style: TextStyle(
                                                  fontSize: 80,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: Ink.image(
                                image: AssetImage('image/3.png'),
                              ),
                            );
                          case 3:
                            return IconButton(
                              iconSize: 300,
                              onPressed: () {
                                showDialog(
                                    barrierColor: Colors.white.withOpacity(.6),
                                    context: context,
                                    builder: (_) {
                                      Timer(Duration(seconds: 1), () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          emojiRating = 4;
                                        });
                                        insertRating(emojiRating);
                                      });
                                      return Dialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ขอบคุณที่ใช้บริการ",
                                                style: TextStyle(
                                                  fontSize: 80,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "THANK YOU",
                                                style: TextStyle(
                                                  fontSize: 80,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: Ink.image(
                                image: AssetImage('image/4.png'),
                              ),
                            );
                          case 4:
                            return IconButton(
                              iconSize: 300,
                              onPressed: () {
                                showDialog(
                                    barrierColor: Colors.white.withOpacity(.6),
                                    context: context,
                                    builder: (_) {
                                      Timer(Duration(seconds: 1), () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          emojiRating = 5;
                                        });
                                        insertRating(emojiRating);
                                      });
                                      return Dialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "ขอบคุณที่ใช้บริการ",
                                                style: TextStyle(
                                                  fontSize: 80,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "THANK YOU",
                                                style: TextStyle(
                                                  fontSize: 80,
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: Ink.image(
                                image: AssetImage('image/5.png'),
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
                    children: [
                      Text(
                        '     น้อยมาก   ',
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '   น้อย   ',
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '   พอใช้   ',
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '      ดี   ',
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '       ดีมาก   ',
                        style: TextStyle(
                          fontSize: 60,
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
