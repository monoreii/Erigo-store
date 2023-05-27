import 'package:flutter/material.dart';
import './main.dart';
import './register.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF146C94),
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('aset/logo_erigo.png')),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: TextStyle(fontSize: 15),
              ),
              child: Text(
                'Forgot Password',
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return MyApp();
                      },
                    ),
                  );
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New User?'),
                TextButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return register();
                        },
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: TextStyle(fontSize: 15),
                  ),
                  child: Text(
                    'Create Account',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
