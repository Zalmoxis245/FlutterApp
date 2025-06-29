import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_app/custom_classes/choice_outlined_button.dart';
import 'package:flutter_app/globals.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';


/*void increaseScore(DatabaseReference ref, BuildContext context) async{
  final snapshot = await ref.child('$globalUser/score').get();
  ref.child("$globalUser/").update({
    "score": int.parse(snapshot.value.toString()) + 10
  }
  );
}

void decreaseScore(DatabaseReference ref, BuildContext context) async{
  final snapshot = await ref.child('$globalUser/score').get();
  ref.child("$globalUser/").update({
    "score": int.parse(snapshot.value.toString()) - 5
  }
  );
}*/

void makeSound(AudioPlayer player, String soundPath) async{
  await player.setAsset("assets/$soundPath");
  player.play();
}

void updateScore(DatabaseReference ref, int score) async{
  final snapshot = await ref.child("$globalUser/score").get();
  ref.child('$globalUser/').update({
    "score": int.parse(snapshot.value.toString()) + score
  });
}

class QuizModel {
  var _quizAnswer = '';
  var _quiz = '';

  void makeQuiz(int total, BuildContext context, DatabaseReference ref, int score) {
    if(total > 10){
      Navigator.of(context).popAndPushNamed('/campaign');
      updateScore(ref, score);
      if(globalUserCurrentLevel == globalLevel){
        globalUserCurrentLevel++;
      }
    }
    List<String> listOfSigns = ['+', '-', ':', '⋅'];
    Random random = Random();
    var selectedSign = listOfSigns[random.nextInt(listOfSigns.length)];
    var firstNumber = random.nextInt(6) + 6;
    var secondNumber = random.nextInt(3) + 3;
    var realResult = 0;

    if (selectedSign == '+') {
      realResult = firstNumber + secondNumber;
    } else if (selectedSign == '-') {
      realResult = firstNumber - secondNumber;
    } else if (selectedSign == '⋅') {
      realResult = firstNumber * secondNumber;
    } else if (selectedSign == ':') {
      if (firstNumber % secondNumber != 0) {
        if (firstNumber % 2 != 0) {
          firstNumber++;
        }
        for (int i = secondNumber; i > 0; i--) {
          if (firstNumber % i == 0) {
            secondNumber = i;
            break;
          }
        }
      }
      realResult = firstNumber ~/ secondNumber;
    }

    var falseMaker = [-3, -2, -1, 1, 2, 3];
    var randomlyChosen = falseMaker[random.nextInt(falseMaker.length)];

    var trueOrFalse = random.nextInt(2);

    _quizAnswer = 'TRUE';
    if (trueOrFalse == 0) {
      _quizAnswer = 'FALSE';
      realResult = realResult + randomlyChosen;
      if (realResult < 0) realResult = realResult + random.nextInt(2) + 4;
    }

    _quiz = '$firstNumber $selectedSign $secondNumber = $realResult';
  }

  get quizAnswer => _quizAnswer;
  get quiz => _quiz;
}

class QuizPage extends StatelessWidget {

  const QuizPage({super.key});

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

      body: Center(child: QuizPageForm()),
    ),
  );
}

class QuizPageForm extends StatefulWidget {

  const QuizPageForm({super.key});

  @override
  QuizPageFormState createState() {
    return QuizPageFormState();
  }
}

class QuizPageFormState extends State<QuizPageForm> {
  final ref = FirebaseDatabase.instance.ref("users");
  late Timer timer;
  late AudioPlayer player;
  late AudioPlayer clockPlayer;
  final quizModel = QuizModel();
  String aText = "Neutral";
  int total = 1;
  int clock = -1;
  int score = 0;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    clockPlayer = AudioPlayer();
    start();
  }

  void start(){
    quizModel.makeQuiz(total, context, ref, score);
    if(globalLevel == 2){
      clock = 10;
    }else{
      if(globalLevel == 1){
        clock = 20;
      }
    }
    total = 1;
    score = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(clock > 0){
          clock--;
        }
        if(clock == 0){
          total++;
          score = score - 5;
          aText = "Out of Time";
          quizModel.makeQuiz(total, context, ref, score);
          makeSound(player, "wrongSound.wav");
          if(clockPlayer.playing){
            clockPlayer.stop();
          }
          if(globalLevel == 2){
            clock = 10;
          }else{
            if(globalLevel == 1){
              clock = 20;
            }
          }
        }
        if(clock <= 5 && clock > 0){
          makeSound(clockPlayer, "clock.wav");
        }
      });
    });
  }
  void checkAnswer(String userChoice){
    total++;
    if(clockPlayer.playing){
      clockPlayer.stop();
    }
    if (userChoice == quizModel.quizAnswer && clock != 0) {
      score = score + 10;
      aText = "Correct";
      quizModel.makeQuiz(total, context, ref, score);
      if(globalLevel == 2){
        clock = 10;
      }else{
        if(globalLevel == 1){
          clock = 20;
        }
      }
      makeSound(player, "correctSound.wav");

    } else {
      score = score -5;
      aText = "Wrong";

      if(globalLevel == 2){
        clock = 10;
      }else{
        if(globalLevel == 1){
          clock = 20;
        }
      }
      quizModel.makeQuiz(total, context, ref, score);
      makeSound(player, "wrongSound.wav");
    }
  }
  @override
  void dispose(){
    player.dispose();
    clockPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 80,),
            Text(
              "Score: ${globalScore+score}",
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  color: Colors.white54
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              (clock != -1) ?"Time Left: $clock": "Unlimited Time",
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  color: Colors.white54
              ),
            ),
            const SizedBox(height: 30,),
            Text(
              "Question $total",
              style: const TextStyle(
                  fontSize: 60,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  color: Colors.white54
              ),
            ),
            const SizedBox(height: 120,),
            SizedBox(
              height: 100,
              child: Text(
                quizModel.quiz,
                style: const TextStyle(
                    fontSize: 50,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.bold,
                    color: Colors.white54
                ),
              ),
            ),
            const SizedBox(height: 60,),
            Text(
              (aText == "Neutral") ? "" :
              (aText == "Correct") ? "Correct": (aText == "Wrong") ? "Wrong" : "Out of Time",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  color: (aText == "Neutral") ? Colors.transparent :
                  (aText == "Correct") ? Colors.lightGreen: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 80,),
            Row(
              children: [
                ChoiceOutlinedButton(
                  userChoice: 'FALSE',
                  onTap: checkAnswer,
                ),
                ChoiceOutlinedButton(
                  userChoice: 'TRUE',
                  onTap: checkAnswer,
                )
              ],
            )


          ],
        ),
      )

    );
  }
}