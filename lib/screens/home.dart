import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../widgets/list_item.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final items = TODO.todoList();

  // TODO: For dynamic item addition, use CONTROLLER
  final _textController = TextEditingController();

  // TODO: Search Items
  List<TODO> _availableItems = [];

  @override
  void initState() {
    _availableItems = items;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    // Headline
                    Container(
                      padding:
                          const EdgeInsets.only(top: 40, left: 30, bottom: 30),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "ToDo Items",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                    // List Items,
                    // TODO: [just provide the function name, no parameter IS NEEDED]
                    for (TODO item in _availableItems.reversed)
                      List_Item(
                          todo: item,
                          onItemStateChanged: _markItem,
                          onItemDeletion: _deleteItem),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                // Add task input
                // Expanded(
                //   child: Container(
                //     height: 45,
                //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 00),
                //     margin: EdgeInsets.only(bottom: 10, left: 20),
                //     decoration: BoxDecoration(
                //       color: Colors.black12,
                //       boxShadow: const [
                //         BoxShadow(
                //           color: Colors.white,
                //           offset: Offset(-5.0, 5.0),
                //           blurRadius: 10.0,
                //           spreadRadius: 0.0,
                //         )
                //       ],
                //       borderRadius: BorderRadius.circular(20.0),
                //     ),
                //     child: TextFormField(
                //       // TODO: Always remember to add the CONTROLLER value
                //       controller: _textController,
                //       decoration: InputDecoration(
                //         contentPadding: EdgeInsets.symmetric(horizontal: 20),
                //         border: InputBorder.none,
                //         hintText: "Add Tasks",
                //       ),
                //     ),
                //   ),
                // ),
                // Add Plus Button
                Expanded(
                  child: Container(
                    transformAlignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    height: 45,
                    width: 65,
                    child: OutlinedButton(
                      onPressed: () {
                        Container();
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                          builder: (context) => Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-5.0, 5.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.0,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: TextFormField(
                                  // TODO: Always remember to add the CONTROLLER value
                                  controller: _textController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    border: InputBorder.none,
                                    hintText: "Add Tasks",
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  if (_textController.text.isNotEmpty) {
                                    _addNewItem(_textController.text);
                                  }
                                  return Navigator.pop(context);
                                },
                                child: const Text(
                                  "Done",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        side: BorderSide(color: Colors.blue, width: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // elevation: 10,
                      ),
                      child: const Text(
                        "Add Item",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _allItems(String keyword) {
    List<TODO> results = [];
    if (keyword.isEmpty) {
      results = items;
    } else {
      results = items
          .where((element) =>
              element.todoText!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      // TODO: This is a must step, otherwise nothing will show up
      _availableItems = results;
    });
  }

  void _markItem(TODO todo) {
    // TODO: You have to use setState() method only in Stateful Widgets
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _addNewItem(String text) {
    setState(() {
      print("Adding Items $text");
      items.add(TODO(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: text));
    });
    print("Clearing Items");
    _textController.clear();
  }

  void _deleteItem(String id) {
    setState(() {
      items.removeWhere((element) => element.id == id);
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          const Text(
            "TODO",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('images/human.jpg'),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.black12),
      child: TextFormField(
        onChanged: (value) => _allItems(value),
        decoration: const InputDecoration(
          prefixIconConstraints: BoxConstraints(
            maxHeight: 25,
            minHeight: 20,
          ),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
