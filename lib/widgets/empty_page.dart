import 'package:flutter/cupertino.dart';

class EmptyPage extends StatelessWidget {
  final String text;
  const EmptyPage({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.circle_bottomthird_split,
                size: 50.0, color: CupertinoColors.systemGrey),
            Spacer(),
            Flexible(
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                    child: Text(
                      text,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ))
              ]),
            )
          ],
        ));
  }
}