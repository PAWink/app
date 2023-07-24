import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key, required this.deptId}) : super(key: key);
  final String deptId;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  DateTime _dateTime1 = DateTime.now();
  DateTime _dateTime2 = DateTime.now();
  String total1 = '0';
  String total2 = '0';
  String total3 = '0';
  String total4 = '0';
  String total5 = '0';

  List data = [];
  //int totalDeptIdCount = 0;
  Map<String, int> deptIdCounts = {};

  void _showDate1() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime1 = value;
        });
      }
    });
  }

  void _showDate2() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime2 = value;
        });
      }
    });
  }

  Future<void> insertTime(
    String result,
    DateTime dateFirst,
    DateTime dateAfter,
  ) async {
    String apiUrl = 'http://10.0.2.2/satisfy/report.php';
    String token =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluc2F0aXNmeSJ9.tFEPJ4vS29s6P-5YO_VGz9CoGMwQdbj38Gg4JHrdeZE';
    String dateFirst1 = DateFormat('yyyy-MM-dd').format(dateFirst);
    String dateAfter1 = DateFormat('yyyy-MM-dd').format(dateAfter);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          'deptid': widget.deptId,
          'datefirst': dateFirst1,
          'dateafter': dateAfter1,
        }),
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        total1 = '0';
        total2 = '0';
        total3 = '0';
        total4 = '0';
        total5 = '0';
      } else {
        // Failed to insert data
        print('Failed to insert rating. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred while inserting rating: $e');
    }
  }

  @override
  void initState() {
    super.initState();
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
            ),
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                    SizedBox(
                      child: Text(
                        'โปรดเลือกเวลาเพื่อแสดงรายงาน',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: _showDate1,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Text(
                                  'เวลาเริ่มต้น',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  DateFormat('yyyy-MM-dd').format(_dateTime1),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.blue[500],
                        ),
                        SizedBox(
                          child: Center(
                            child: Text(
                              "---",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          width: 60,
                        ),
                        MaterialButton(
                          onPressed: _showDate2,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Text(
                                  'เวลาสิ้นสุด',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  DateFormat('yyyy-MM-dd').format(_dateTime2),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.blue[500],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            insertTime(widget.deptId, _dateTime1, _dateTime2)
                                .then((_) {
                              setState(() {
                                for (var item in data) {
                                  if (item['point'].toString() == '1') {
                                    total1 = item['total'];
                                  }
                                  if (item['point'].toString() == '2') {
                                    total2 = item['total'];
                                  }
                                  if (item['point'].toString() == '3') {
                                    total3 = item['total'];
                                  }
                                  if (item['point'].toString() == '4') {
                                    total4 = item['total'];
                                  }
                                  if (item['point'].toString() == '5') {
                                    total5 = item['total'];
                                  }
                                }
                              });
                            });
                          },
                          child: const Text(
                            'แสดงรายงาน',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.black,
                            minimumSize: const Size(50, 70),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image(
                          image: AssetImage('image/1.png'),
                          width: 120,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              "น้อยมาก",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " $total1 คน  ",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: AssetImage('image/2.png'),
                          width: 120,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              "น้อย",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "  $total2 คน  ",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: AssetImage('image/3.png'),
                          width: 120,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              "พอใช้",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "  $total3 คน  ",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: AssetImage('image/4.png'),
                          width: 120,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              "ดี",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "  $total4 คน  ",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: AssetImage('image/5.png'),
                          width: 120,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              "ดีมาก",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "  $total5 คน  ",
                              style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
