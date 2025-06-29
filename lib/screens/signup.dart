import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
/*import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;*/




class AccountModel{
  String username;
  String email;
  String password;

  AccountModel(this.username, this.email, this.password);
}

void addToDB(DatabaseReference ref, String usr, String eml, String pass, BuildContext context) async{
  final snapshot = await ref.child('$usr/').get();
  if (snapshot.exists){
    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username Already Taken!")),
      );
    }
  }else{
    ref.child(usr).set({
      "email": eml,
      "password": pass,
      "score": 0,
    });
    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data Saved Successfully!")),
      );
    }
  }
}
class SignUp extends StatelessWidget {

  const SignUp({super.key});

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

      body: Center(child: SignUpForm()),
    ),
  );
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});


  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm>{


  final ref = FirebaseDatabase.instance.ref("users");

  final _formKey = GlobalKey<FormState>();
  final _user = AccountModel("default","default","default");

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /*void register() async{
    final User? user = (
      await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
    ).user;

  }*/
  //Ma uitam la videoul asta:
  //https://www.youtube.com/watch?v=IPMIcGTzxGc - min 36:00
  //Dar are numai email si parola, fara username, pentru username ma uit aici :

  //https://stackoverflow.com/questions/54166806/how-to-make-flutter-sign-up-with-more-fields
  //https://firebase.google.com/docs/auth/android/manage-users



  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                "Sign Up",
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
                    return "Please enter your password.";
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
                controller: _emailController,
                validator: (value) => EmailValidator.validate(value.toString()) ? null : "Please enter a valid email",
                onSaved: (val){
                  _user.email = val.toString();
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: "Email",
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
              onPressed: () async {
                if (_formKey.currentState!.validate()){
                  _formKey.currentState!.save();
                  addToDB(ref, _user.username, _user.email, _user.password, context);
                  Navigator.pushNamed(context, '/loginPageRegistered');

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
                "Log In",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.normal,
                  color: Colors.blue,
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),


          ],
        ),
      )
    );
  }
}

