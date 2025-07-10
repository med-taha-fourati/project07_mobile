import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

FocusNode fn = new FocusNode();
FocusNode fn2 = new FocusNode();

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 
        Text('Login'),
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Form(
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                focusNode: fn,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.3
                    )
                  ),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: fn.hasFocus ? Colors.green : Colors.grey
                  )
                ),
                onChanged: (value) => _username = value,
                validator: (value) => value!.isEmpty ? 'Enter username' : null,
              ),
              TextFormField(
                focusNode: fn2,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  focusColor: Colors.green,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2.3
                    )
                  ),
                  label: 
                    Text("Password"),

                  labelStyle:TextStyle(
                    color: fn.hasFocus ? Colors.green : Colors.grey
                  )
                  ),
                obscureText: true,
                onChanged: (value) => _password = value,
                validator: (value) => value!.isEmpty ? 'Enter password' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {}
                ,
                child: Text("Login"),
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.green),
                  backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 219, 239, 219))
                )
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text('No account? Register'),
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.green),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
