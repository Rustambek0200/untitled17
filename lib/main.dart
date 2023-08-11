import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
late Box box;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box =await Hive.openBox("flutter_box");
  runApp(MaterialApp(home: MyApp(),));
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
TextEditingController txtController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: txtController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Textni kiriting...")
              ),
            ),
          ),
          MaterialButton(onPressed: (){
              box.add(txtController.text);
          },
          child: Text("Saqlash"),
          color: Colors.greenAccent),
          ValueListenableBuilder(valueListenable: box.listenable(), builder: (context, value,child){
    return Expanded(child: ListView.builder(itemCount: box.length,
    itemBuilder: (BuildContext context, int index) {
    return Container(
    margin:EdgeInsets.all(8),
    color:Colors.blue,
    alignment: Alignment.center,
    width:MediaQuery.of(context).size.width,
    height: 75,
    child: Text(box.getAt(index)),
    );
    }),

    );
    }
      ),
    ],
      )
    );
  }
}
