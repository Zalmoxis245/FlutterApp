import 'package:flutter/material.dart';
import 'package:flutter_app/custom_classes/material_color.dart';

class ChoiceOutlinedButton extends StatelessWidget {
  final String userChoice;
  final Function onTap;

  const ChoiceOutlinedButton({super.key,
    required this.userChoice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: OutlinedButton(
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
            child: Text(
              userChoice,
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                  color: Colors.white54
              ),
            ),
            onPressed: () => onTap(userChoice)),
      ),
    );
  }
}