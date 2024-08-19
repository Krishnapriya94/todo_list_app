import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/utils/app_sessions.dart';
import 'package:todo_list_app/utils/color_constants/color_constants.dart';
import 'package:todo_list_app/utils/image_constants/image_constants.dart';
import 'package:todo_list_app/view/login_screen/login_screen.dart';
import 'package:todo_list_app/view/task_detailed_screen/task_detailed_screen.dart';

import 'package:todo_list_app/view/task_screen/widgets/task_screen_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  var toDoBox = Hive.box(AppSessions.TODOBOX);
  List toDoKeys = [];

  int selectedIndex = 0;

  @override
  void initState() {
    toDoKeys = toDoBox.keys.toList();
    setState(() {});
    super.initState();
  }

  Future<void> _selectTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Format the time to a readable string
      final formattedTime = selectedTime.format(context);
      // Update the text field with the selected time
      setState(() {
        timeController.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ));
          },
        ),
        actions: [
          PopupMenuButton(
            iconSize: 30,
            itemBuilder: (context) => [_appBarMenu()],
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      drawer: _customDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  var currentTodo = toDoBox.get(toDoKeys[index]);
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    onDismissed: (_) {
                      toDoBox.delete(toDoKeys[index]);
                      print(toDoKeys);
                      toDoKeys = toDoBox.keys.toList();
                      setState(() {});
                    },
                    background: Row(
                      children: [
                        Icon(Icons.delete),
                        Text("Task has been deleted")
                      ],
                    ),
                    key: Key(index.toString()),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailedScreen(
                                taskName: currentTodo["taskName"],
                                date: currentTodo["date"],
                                time: currentTodo["time"],
                              ),
                            ));
                      },
                      child: TaskScreenCard(
                        taskName: currentTodo["taskName"],
                        date: currentTodo["date"],
                        time: currentTodo["time"],
                        //task delete
                        onDelete: () async {
                          await toDoBox.delete(toDoKeys[index]);
                          toDoKeys = toDoBox.keys.toList();
                          setState(() {});
                        },
                        //task edit
                        onEdit: () {
                          taskNameController.text = currentTodo["taskName"];
                          dateController.text = currentTodo["date"];
                          timeController.text = currentTodo["time"];

                          _customBottomSheet(context,
                              isEdit: true, itemIndex: index);
                        },
                        isCompleted: false,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: toDoKeys.length),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: ColorConstants.paleAmber,
        child: Icon(Icons.add),
        onPressed: () {
          taskNameController.clear();
          dateController.clear();
          timeController.clear();
          _customBottomSheet(context);
          setState(() {});
        },
      ),
    );
  }

  Drawer _customDrawer() {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(ImageConstants.blueBackground))),
                ),
                Positioned(
                  left: 60,
                  bottom: 40,
                  child: Text(
                    "taskDo",
                    style: TextStyle(
                        color: ColorConstants.mainWhite,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      //crown icon
                      Icon(
                        FontAwesomeIcons.crown,
                        color: ColorConstants.paleAmber,
                        size: 25.0,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Upgrade to PRO",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //star icon
                  Row(
                    children: [
                      //crown icon
                      Icon(
                        Icons.star,
                        size: 30,
                        color: ColorConstants.paleBlue,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Star Tasks",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      //crown icon
                      Icon(
                        Icons.favorite,
                        size: 30,
                        color: ColorConstants.paleBlue,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Donate",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      //crown icon
                      Icon(
                        Icons.edit_note_outlined,
                        size: 30,
                        color: ColorConstants.paleBlue,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Feedback",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      //crown icon
                      Icon(
                        Icons.now_widgets_outlined,
                        size: 30,
                        color: ColorConstants.paleBlue,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      //crown icon
                      Icon(
                        Icons.settings,
                        size: 30,
                        color: ColorConstants.paleBlue,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        //crown icon

                        Icon(
                          Icons.logout,
                          color: ColorConstants.paleBlue,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _customBottomSheet(BuildContext context,
      {bool isEdit = false, int? itemIndex}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: taskNameController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                filled: true,
                                fillColor:
                                    ColorConstants.mainGrey.withOpacity(.5),
                                hintText: "Input new task here"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            readOnly: true,
                            controller: dateController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      var selectedDate = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2101));

                                      if (selectedDate != null) {
                                        dateController.text =
                                            DateFormat("dd-MMM-yyyy")
                                                .format(selectedDate);
                                      }
                                    },
                                    icon: Icon(Icons.calendar_month_rounded)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                filled: true,
                                fillColor:
                                    ColorConstants.mainGrey.withOpacity(.5),
                                hintText: "Date"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            readOnly: true,
                            controller: timeController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                filled: true,
                                fillColor:
                                    ColorConstants.mainGrey.withOpacity(.5),
                                hintText: "Time",
                                suffixIcon: IconButton(
                                    onPressed: _selectTime,
                                    icon: Icon(
                                        Icons.access_time_filled_rounded))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          ColorConstants.mainGrey
                                              .withOpacity(.05))),
                                  onPressed: () {},
                                  child: Text("No Category")),
                              InkWell(
                                onTap: () {
                                  if (isEdit == true) {
                                    toDoBox.put(toDoKeys[itemIndex!], {
                                      "taskName": taskNameController.text,
                                      "date": dateController.text,
                                      "time": timeController.text
                                    });
                                  } else {
                                    toDoBox.add({
                                      "taskName": taskNameController.text,
                                      "date": dateController.text,
                                      "time": timeController.text
                                    });
                                  }
                                  toDoKeys = toDoBox.keys.toList();
                                  Navigator.pop(context);
                                  setState(() {});
                                  print(toDoKeys);
                                },
                                child: CircleAvatar(
                                    radius: 25,
                                    child: isEdit == true
                                        ? Icon(Icons.edit)
                                        : Icon(Icons.add)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

PopupMenuItem<dynamic> _appBarMenu() {
  return PopupMenuItem(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Manage Categories"),
      SizedBox(
        height: 20,
      ),
      Text("Search"),
      SizedBox(
        height: 20,
      ),
      Text("Sort by"),
      SizedBox(
        height: 20,
      ),
      Text("Print"),
      SizedBox(
        height: 20,
      ),
      Text("Upgrade to pro"),
      SizedBox(
        height: 20,
      ),
      Text("Logout"),
    ],
  ));
}
