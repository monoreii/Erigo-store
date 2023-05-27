import 'package:flutter/material.dart';
import './Login.dart';

void main() async {
  runApp(const reg());
}

class reg extends StatelessWidget {
  const reg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'register',
      home: register(),
    );
  }
}

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);
  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    bool passwordNotVisible = true;

    // Future<void> _regiter() async {
    //   final String username = _usernameController.text;
    //   final String email = _emailController.text;
    //   final String password = _passwordController.text;
    //   final String confirmPassword = _confirmPasswordController.text;

    //   await _shopcart
    //       .add({"name": name, "price": 100000, "qty": qty, "size": size});

    //   _nameController.text = '';
    //   _qtyController.text = '';
    //   _sizeController.text = '';

    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text('You have successfully deleted a product')));
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF146C94),
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('aset/logo_erigo.png')),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: passwordNotVisible,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
