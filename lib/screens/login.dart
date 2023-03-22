import 'package:flutter/material.dart';
import 'package:flutter_app/screens/signup.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("images/image.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,

      body: Center(child: LoginForm()),
    ),
  );
}

class LoginForm extends StatefulWidget {


  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Log In",
              style: TextStyle(
                fontSize: 50,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              )
          ),
          SizedBox(height: 250,),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty){
                  return "Please enter your username.";
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "Username",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10,),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty){
                  return "Please enter your password.";
                }
                return null;
              },
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "Password",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(

            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: (){
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );

              }
            },
            child: const Text(
              "Submit",
              style: TextStyle(
                fontFamily: "Times New Roman",
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.normal,
                color: Colors.blue,
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp())
            ),
          )


        ],
      ),
    );
  }
}

