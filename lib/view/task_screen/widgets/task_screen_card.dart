import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/color_constants/color_constants.dart';

class TaskScreenCard extends StatefulWidget {
  const TaskScreenCard({
    super.key,
    required this.taskName,
    required this.date,
    required this.time,
    this.onDelete,
    this.onEdit,
    required this.isCompleted,
  });

  final String taskName;
  final String date;
  final String time;
  final bool isCompleted;
  final void Function()? onDelete;
  final void Function()? onEdit;

  @override
  State<TaskScreenCard> createState() => _TaskScreenCardState();
}

class _TaskScreenCardState extends State<TaskScreenCard> {
  bool onChecked = false;
  @override
  void initState() {
    super.initState();
    onChecked = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: ColorConstants.mainGrey.withOpacity(.05),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: onChecked,
              onChanged: (value) {
                setState(() {
                  onChecked = value!;
                });
              },
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskName,
                  maxLines: 1,
                  style: TextStyle(
                    decoration: onChecked == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: ColorConstants.mainBlack,
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(color: ColorConstants.mainRed),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.time,
                      style: TextStyle(color: ColorConstants.mainRed),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.notifications,
                      color: ColorConstants.mainGrey,
                      size: 20,
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                IconButton(onPressed: widget.onEdit, icon: Icon(Icons.edit)),
                IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete))
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
