import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app_clone/controller/todo_controller.dart';
import 'package:todo_app_clone/model/student_model.dart';
import 'package:todo_app_clone/view/home_screen/widgets/to_do_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    TodoController.initData();
    super.initState();
  }

  TextEditingController taskController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.keyboard_arrow_left_outlined),
                Icon(Icons.search),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, bottom: 10, top: 10),
            child: Row(
              children: [
                Text(
                  "Today",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 5),
                Icon(Icons.sunny),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: TodoController.todoKeyList.length,
              itemBuilder: (context, index) {
                var item =
                    TodoController.getData(TodoController.todoKeyList[index])!;
                return ToDoTile(
                  item: item,
                  onCheckStateChanged: (value) async {
                    item.isCompleted = value!;
                    await TodoController.updateData(
                        TodoController.todoKeyList[index], item);
                    setState(() {});
                  },
                  onDeletePressed: () async {
                    await TodoController.deleteData(
                        TodoController.todoKeyList[index]);
                    setState(() {});
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ),
          InkWell(
            onTap: () {
              taskController.clear();
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Column(
                    children: [
                      TextField(
                        controller: taskController,
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.withOpacity(.4),
                            filled: true,
                            hintText: "Add a new task",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: InkWell(
                          onTap: () async {
                            await TodoController.addData(TaskModel(
                                text: taskController.text, isCompleted: false));
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                      )
                    ],
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "Add New Task",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.add),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
