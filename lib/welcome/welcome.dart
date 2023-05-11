import 'package:app/rating/rating.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<String> list = <String>[
    'พยาบาล',
    'หมอ',
    'บุคลากร',
    'ผู้ช่วยพยาบาล',
    'ฝ่าย IT',
    'ฝ่ายการเงิน',
  ];
  String dropdownValue = 'พยาบาล';
  final double circleRadius = 100;
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
              )),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: Image(
                    image: AssetImage('image/logo.png'),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(children: [
                      Text(
                        'กรุณาให้คะแนนความพึงพอใจ',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 70),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'กรุณาเลือกจุดบริการ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 50),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          size: 90,
                          color: Colors.blue,
                        ),
                        elevation: 24,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 40),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Rating()));
                        },
                        child: const Text(
                          'เข้าหน้าให้คะแนน',
                          style: TextStyle(fontSize: 50),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.black,
                            minimumSize: const Size(400, 70)),
                      ),
                      Row(),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
