import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list_app/utils/animation_constants/animation_constants.dart';
import 'package:todo_list_app/utils/color_constants/color_constants.dart';
import 'package:todo_list_app/utils/image_constants/image_constants.dart';
import 'package:todo_list_app/view/home_screen/home_screen.dart';
import 'package:todo_list_app/view/login_screen/login_screen.dart';
import 'package:todo_list_app/view/task_screen/task_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text("TaskDo",
              style: TextStyle(
                  color: ColorConstants.mainWhite,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Manage your ",
                    style: TextStyle(
                        color: ColorConstants.mainWhite, fontSize: 25)),
                Text("team & everything ",
                    style: TextStyle(
                        color: ColorConstants.mainWhite, fontSize: 25)),
                Row(
                  children: [
                    Text("with ",
                        style: TextStyle(
                            color: ColorConstants.mainWhite, fontSize: 25)),
                    Text("taskDo",
                        style: TextStyle(
                            color: ColorConstants.mainRed, fontSize: 25)),
                  ],
                ),
              ],
            ),
            Center(child: Lottie.asset(AnimationConstants.get_started_anim2)),
            Text("When you're overwhelmed by the",
                style: TextStyle(color: ColorConstants.mainWhite)),
            Text("amount of work you have on your",
                style: TextStyle(color: ColorConstants.mainWhite)),
            Text("plate, stop and rethink.",
                style: TextStyle(color: ColorConstants.mainWhite)),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(ColorConstants.paleAmber)),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Text("Let's Start",
                      style: TextStyle(color: ColorConstants.mainBlack))),
            )
          ],
        ),
      ),
    );
  }
}
