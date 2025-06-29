import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/globals.dart';
/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';*/




class LoginModel{
  String username;
  String password;

  LoginModel(this.username, this.password);
}

void checkAccountInformation(DatabaseReference ref, String usr, String pass, BuildContext context, Function clearText, /*CollectionReference fireRef*/) async{

  /*QuerySnapshot snap = await fireRef.where("username", isEqualTo: usr).get();*/


  final snapshot = await ref.child('$usr/').get();
  if (snapshot.exists){
    final snapshot2 = await ref.child('$usr/password').get();
    if (snapshot2.value == pass){

      //Here the usr goes to MainMenu
      globalUser = usr;
      clearText();
      final snapshot3 = await ref.child('$usr/score').get();
      globalScore = int.parse(snapshot3.value.toString());
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome $usr !")),
        );
        Navigator.pushNamed(context, '/mainMenu');
      }
    }else{
      if (context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Wrong Password!"))
        );
      }
    }
  }else{
    if (context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("This username is not in our database!"))
      );
    }
  }
}

class Login extends StatelessWidget {

  /*final bool registered;*/
  const Login(/*this.registered,*/ {super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("images/image.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: const Scaffold(
      backgroundColor: Colors.transparent,

      body: Center(child: LoginForm(/*registered*/)),
    ),
  );
}

class LoginForm extends StatefulWidget {
  /*final bool registered;*/
  const LoginForm(/*this.registered,*/ {super.key});

  @override
  LoginFormState createState() {
    return LoginFormState(/*registered*/);
  }
}

class LoginFormState extends State<LoginForm> {

  /*final bool registered;
  LoginFormState(this.registered);

  @override
  void initState(){
    if(registered) {
      super.initState();

      WidgetsBinding.instance
          .addPostFrameCallback((_) =>
      const SnackBar(content: Text("Data Saved Successfully!")));
    }
  }*/
  /*final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference fireRef = FirebaseFirestore.instance.collection('users');*/
  final ref = FirebaseDatabase.instance.ref('users');
  final _user = LoginModel("default", "default");
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();

  @override
  void initState(){
    super.initState();
    clearTextFields();
  }
  void clearTextFields(){
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                "Log In",
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                )
            ),
            const SizedBox(height: 250,),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "Please enter your username.";
                  }
                  _formKey.currentState!.save();
                  return null;
                },
                onSaved: (val) {
                  _user.username = val.toString();
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: "Username",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "Please enter your password.";
                  }
                  _formKey.currentState!.save();
                  return null;
                },
                onSaved: (val){
                  _user.password = val.toString();
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: "Password",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(

              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                  checkAccountInformation(ref, _user.username, _user.password, context, clearTextFields,/* fireRef*/);
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
            const SizedBox(height: 10,),
            InkWell(
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.normal,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/signup');
                clearTextFields();
              }
            )


          ],
        ),
      )
    );
  }
}

