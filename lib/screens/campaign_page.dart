import 'package:flutter/material.dart';
import 'package:flutter_app/custom_classes/material_color.dart';
import 'package:flutter_app/globals.dart';

List<Widget> campaignLevels(int nr, BuildContext context){
  List <Widget> levels = <Widget>[];
  for (int i = 0; i <= nr; i++){
    levels.add(
      OutlinedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)) ,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )
            ),
            side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 5,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(createMaterialColor(const Color(0xFF0616F6)))
        ),

        onPressed: (globalUserCurrentLevel >= i) ? (){
          globalLevel = i;
          Navigator.pushNamed(context, "/quizPage");
        }: null,
        child: Text(
          (globalUserCurrentLevel >= i) ? "Level $i" : "Locked",
          style: const TextStyle(
              fontSize: 50,
              fontFamily: "Times New Roman",
              fontWeight: FontWeight.bold,
              color: Colors.white54
          ),
        ),
      ),
    );
    levels.add(
      const SizedBox(height: 20,)
    );
  }
  levels.removeLast();
  return levels;
}

class CampaignPage extends StatelessWidget {

  const CampaignPage({super.key});

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

      body: Center(child: CampaignPageForm()),
    ),
  );
}

class CampaignPageForm extends StatefulWidget {

  const CampaignPageForm({super.key});

  @override
  CampaignPageFormState createState() {
    return CampaignPageFormState();
  }
}

class CampaignPageFormState extends State<CampaignPageForm>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: double.infinity, height: 130,),
            const Text(
              "Campaign",
              style: TextStyle(
                fontSize: 50,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 70,),
            SizedBox(
              width: 300,
              height: 300,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: campaignLevels(3, context),
              ),
            ),
            const SizedBox(height: 100,),
            OutlinedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)) ,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
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
                Navigator.pushNamed(context, '/mainMenu');
              },
              child: const Text(
                " Back ",
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.bold,
                    color: Colors.white54
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}