import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/color_constants/color_constants.dart';

class TaskDetailedScreen extends StatefulWidget {
  const TaskDetailedScreen(
      {super.key,
      required this.taskName,
      required this.date,
      required this.time});

  final String taskName;
  final String date;
  final String time;

  @override
  State<TaskDetailedScreen> createState() => _TaskDetailedScreenState();
}

class _TaskDetailedScreenState extends State<TaskDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController taskNameController = TextEditingController();
    taskNameController.text = widget.taskName;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(widget.taskName),
              // Text(widget.date),
              // Text(widget.time),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: TextField(
                  controller: taskNameController,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                ),
              ),
              Divider(),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month_outlined,
                          color: ColorConstants.mainGrey),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Due Date",
                        style: TextStyle(
                            color: ColorConstants.mainGrey, fontSize: 18),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: ColorConstants.mainGrey.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(widget.date),
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Icon(Icons.access_time_filled_outlined,
                      color: ColorConstants.mainGrey),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Time",
                    style:
                        TextStyle(color: ColorConstants.mainGrey, fontSize: 18),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: ColorConstants.mainGrey.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(widget.time),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //-----
              Row(
                children: [
                  Icon(Icons.repeat, color: ColorConstants.mainGrey),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Repeat Task",
                    style:
                        TextStyle(color: ColorConstants.mainGrey, fontSize: 18),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: ColorConstants.mainGrey.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("No"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
