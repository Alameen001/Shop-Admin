import 'package:flutter/material.dart';

class DashBoardMainDetails extends StatelessWidget {
  const DashBoardMainDetails({
    Key? key,
    required this.colors,
    required this.texts,
    // required this.contents,
  }) : super(key: key);

  final List<Color> colors;
  final List<String> texts;
  // final List contents;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 3,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
         crossAxisSpacing: 10,
         childAspectRatio: 4 / 2,
      ),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: colors[index],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              texts[index],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "1010",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
