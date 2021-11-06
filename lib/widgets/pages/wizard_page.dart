import 'package:duszamobile2021/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// useful video: https://www.youtube.com/watch?v=2aJZzRMziJc

class WizardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).new_title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(child: Text(S.of(context).continueButton),
              onPressed: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
