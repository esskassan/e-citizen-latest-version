import 'package:e_citizen/helpers/screen_dimensions.dart';
import 'package:flutter/material.dart';

class PagePadding extends StatelessWidget {
  const PagePadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: fullHeight(context),
        width: fullWidth(context),
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      ),
    );
  }
}
