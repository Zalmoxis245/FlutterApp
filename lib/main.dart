import 'package:flutter/material.dart';
import 'package:flutter_app/screens/campaign_page.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/screens/main_menu.dart';
import 'package:flutter_app/screens/quiz_page.dart';
import 'firebase_options.dart';

/*
      Trebuie sa mai fac niste ajustari si sa completez urmatoarele
      Meniul trebuie sa contina:
        - un buton cu "Leaderboard"
      Leaderboard:
        - va trebuii sa fac inca o pagina cu leaderboard, as putea sa pun
          scorurile intr-un ListView, cu Row-uri pentru fiecare player
      DB:
        - va trebuii sa integrez firebase.auth in aplicatia mea in loc de metoda
          pe care o folosesc acum
        - va trebuii sa gasesc o metoda prin care sa ma pot loga numai cu user si
          parola in loc de email si parola.
        - va trebuii sa fac "flutter pub add firebase_auth" in terminal
        - link-uri:
        https://blog.logrocket.com/building-gaming-leaderboard-flutter/
        file:///C:/Users/Dani/Downloads/blog-logrocket-com-building-gaming-leaderboard-flutter-.pdf
        https://firebase.google.com/docs/auth/flutter/start
        https://www.reddit.com/r/FlutterDev/comments/yfow1k/building_a_gaming_leaderboard_in_flutter/
        https://github.com/firebase/functions-samples/tree/main/username-password-auth
        https://stackoverflow.com/questions/37467492/how-to-provide-user-login-with-a-username-and-not-an-email
        https://firebase.google.com/docs/auth/admin/create-custom-tokens

        - probabil voi folosi ultimul link:
            * voi face email/password auth cu un link la DB unde va fi username ul si scorul
            * la login voi lua username ul si parola si voi genera un token pentru client
            * token ul va fi verificat



      Sunet:
        - va trebuii sa pun audio de fiecare data cand user ul raspunde corect
          sau gresit in quiz: audioplayers/just_audio
        - as putea sa astept sa vad ce a folosit Abid si Arsenii


      pubspec.yaml:
        - trebuie sa ma uit la fiecare dependency pentru noi versiuni



      Optimization:
        - it runs like shit, need to fix that
        - I could get rid of choice_outlined_button separate class

 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: '/loginPageInitial',
        routes: {
          '/loginPageInitial': (context) => new Login(/*false*/),
          '/signup': (context) => new SignUp(),
          '/mainMenu': (context) => new MainMenu(),
          '/quizPage': (context) => new QuizPage(),
          '/campaign': (context) => new CampaignPage(),
        },
    );
  }
}



