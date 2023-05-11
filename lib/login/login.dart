import 'package:app/regisDont/regisdont.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        //คลิกที่จอแล้วออกจากtextformfield
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
//section1
            Expanded(
              //แบ่งจอ
              flex: 1, //แบ่งจอเป็นส่วน
              child: Container(
                // ignore: sort_child_properties_last
                child: const Image(
                  image: NetworkImage(
                      'https://www.engdict.com/data/dict/media/images_public/numbe-00046278637329065146173794_normal.png'),
                  width: 200,
                ),
                color: Colors.white,
              ),
            ),
//section2
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(50.0),
                  child: SingleChildScrollView(
                    //เวลากด textformfield แล้วมันไม่ติด pixel
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          height: 50,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: TextFormField(
                            style:
                                const TextStyle(backgroundColor: Colors.white),
                            cursorColor: Colors.green,
                            maxLines: null, //เพิ่มบรรทัดใหม่อัตโนมัติ
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(
                                      color: Colors.yellow, width: 5)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: TextFormField(
                            cursorColor: Colors.green,
                            maxLines: null,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              hoverColor: Colors.amber,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(
                                      color: Colors.yellow, width: 5)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Or',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterDont())), // เร้าจากข้อความไปหน้าอื่น
                          child: const Text(
                            'Register a new account',
                            style: TextStyle(
                                color: Colors.white,
                                decoration:
                                    TextDecoration.underline, //ขีดเส้นใต้
                                decorationColor: Colors.white,
                                decorationThickness: 1.8), //ความหนาของเส้น
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Login',
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              minimumSize: const Size(100, 40)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
