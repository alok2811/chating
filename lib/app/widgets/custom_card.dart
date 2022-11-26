import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String msg;
  final String additionalInfo;

  const CustomCard({Key? key, required this.msg, this.additionalInfo = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  //real message
                  TextSpan(
                    text: "$msg ",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),

                  //fake additionalInfo as placeholder
                  TextSpan(
                      text: additionalInfo,
                      style: const TextStyle(color: Colors.transparent)),
                ],
              ),
            ),
          ),

          //real additionalInfo
          Positioned(
            right: 8.0,
            bottom: 4.0,
            child: Text(
              additionalInfo,
              style: const TextStyle(fontSize: 8.0, color: Colors.black38),
            ),
          )
        ],
      ),
    );
  }
}
