import 'package:app/rating/rating.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.deptId, required this.deptName})
      : super(key: key);
  final String deptId;
  final String deptName;

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String selectedName = '';
  List<dynamic> data = [];

  Future<void> getAllName() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2/satisfy/getdata.php"),
      headers: {
        "Accept": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImFkbWluc2F0aXNmeSJ9.tFEPJ4vS29s6P-5YO_VGz9CoGMwQdbj38Gg4JHrdeZE",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        data = jsonData;
      });
      print(jsonData);
    } else {
      // Failed to fetch data
      print('Failed to fetch data. Error: ${response.reasonPhrase}');
    }
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
                    height: 30,
                  ),
                  Container(
                    child: Image(
                      image: AssetImage('image/logo.png'),
                      width: 220,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'กรุณาให้คะแนนความพึงพอใจ',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'กรุณาเลือกจุดบริการ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        DropdownButton<String>(
                          value: selectedName.isNotEmpty ? selectedName : null,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            size: 90,
                            color: Colors.blue,
                          ),
                          elevation: 24,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                          ),
                          hint: Text("เลือกแผนก"),
                          items: data.map<DropdownMenuItem<String>>(
                            (dynamic item) {
                              final deptName = item['deptname'];
                              final deptId = item['deptid'].toString();
                              return DropdownMenuItem<String>(
                                child: Text(deptName),
                                value: deptId,
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedName = value!;
                            });
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Rating(
                                  deptId: selectedName,
                                  deptName: data.firstWhere((item) =>
                                      item['deptid'].toString() ==
                                      selectedName)['deptname'],
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'เข้าหน้าให้คะแนน',
                            style: TextStyle(fontSize: 30),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            onPrimary: Colors.black,
                            minimumSize: const Size(60, 70),
                          ),
                        ),
                        Row(),
                      ],
                    ),
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
