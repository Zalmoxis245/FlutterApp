import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/globals.dart';
/*import 'dart:async';*/
import 'package:flutter_app/custom_classes/material_color.dart';

class Constants {
  /*static const String firstItem = 'Profile';
  static const String secondItem = 'Settings';*/
  static const String thirdItem = 'Log Out';

  static const List<String> choices = <String>[
    /*firstItem,
    secondItem,*/
    thirdItem,
  ];
}

/*void choiceAction(String choice) {
  if (choice == Constants.firstItem) {
    print('Go to profile page');
  } else if (choice == Constants.secondItem) {
    print('Go to settings page');
  } else if (choice == Constants.thirdItem) {
    print('Log out');
  }
}*/

void updateScore(DatabaseReference ref, BuildContext context) async{
  final snapshot = await ref.child('$globalUser/score').get();
  globalScore = int.parse(snapshot.value.toString());
}

class MainMenu extends StatelessWidget {

  const MainMenu({super.key});

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

      body: Center(child: MainMenuForm()),
    ),
  );
}

class MainMenuForm extends StatefulWidget {

  const MainMenuForm({super.key});

  @override
  MainMenuFormState createState() {
    return MainMenuFormState();
  }
}

class MainMenuFormState extends State<MainMenuForm>{

  final ref = FirebaseDatabase.instance.ref('users');
  var appBarHeight = AppBar().preferredSize.height;

  /*Timer? timer;*/

  @override
  void initState() {
    super.initState();
    setState(() {
      updateScore(ref, context);
    });
    /*timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => setState(() {
      updateScore(ref, context);
    }) );*/
  }

  @override
  void dispose() {
    /*timer?.cancel();*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            globalUser,
            style: const TextStyle(
              fontFamily: "Times New Roman",
              fontSize: 26,
            ),
          ),
        ),
        actions: <Widget>[

          PopupMenuButton<String>(
            icon: const Icon(IconData(0xee35, fontFamily: 'MaterialIcons',), size: 40.0, color: Colors.white,),
            offset: Offset(30.0, appBarHeight),
            onSelected: (val){
              if(val == "Log Out"){
                Navigator.of(context).popUntil(ModalRoute.withName("/loginPageInitial"));
                globalUser = "";
              }
            },
            color: Colors.black54,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "Times New Roman",
                      fontWeight: FontWeight.bold,
                      color: Colors.white54,
                    ),
                  ),
                );
              }).toList();
            },
          ),
          const SizedBox(width: 20,)

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: double.infinity,height: 50,),
            const Text(
              "MathMania",
              style: TextStyle(
                fontSize: 50,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 60,),
            const Text(
              "Score:",
              style: TextStyle(
                fontSize: 80,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.bold,
                color: Colors.white54
              ),
            ),
            Text(
              globalScore.toString(),
              style: const TextStyle(
                fontSize: 35,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.bold,
                color: Colors.white54
              ),
            ),
            const SizedBox(height: 20,),
            OutlinedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)) ,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  )
                ),
                side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 5,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(createMaterialColor(const Color(0xFF061616)))

              ),
              onPressed: (){
                Navigator.pushNamed(context, '/campaign');
              },
              child: const Text(
                "Campaign",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  color: Colors.white54
                ),
              ),
            ),
            const SizedBox(height: 10,),
            OutlinedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)) ,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 5,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(createMaterialColor(const Color(0xFF061616)))

              ),
              onPressed: (){},
              child: const Text(
                "Leaderboard",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.bold,
                    color: Colors.white54
                ),
              ),
            ),
            const SizedBox(height: 10,),
            OutlinedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)) ,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 5,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(createMaterialColor(const Color(0xFF061616)))

              ),
              onPressed: (){
                SystemNavigator.pop();
              },
              child: const Text(
                "Quit",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.bold,
                    color: Colors.white54
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}