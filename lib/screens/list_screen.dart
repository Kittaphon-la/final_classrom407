import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/equipment_provider.dart';
import '../models/equipment_model.dart';
import 'form_screen.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  String search = "";
  String filter = "ทั้งหมด";
  String sortType = "name";

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<EquipmentProvider>(context);

    var list = provider.equipments.where((e){

      bool matchSearch =
          e.name.toLowerCase().contains(search.toLowerCase());

      bool matchFilter =
          filter == "ทั้งหมด" || e.status == filter;

      return matchSearch && matchFilter;

    }).toList();

    // SORT

    if(sortType == "name"){
      list.sort((a,b)=>a.name.compareTo(b.name));
    }else{
      list.sort((a,b)=>a.quantity.compareTo(b.quantity));
    }

    return Scaffold(

      appBar: AppBar(
        title: const Text("Equipment List"),
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FormScreen(),
            ),
          );
        },
      ),

      body: Column(

        children: [

          // SEARCH

          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(

              decoration: const InputDecoration(
                labelText: "Search equipment",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),

              onChanged: (value){
                setState(() {
                  search = value;
                });
              },

            ),
          ),

          // FILTER + SORT

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              DropdownButton(

                value: filter,

                items: const [

                  DropdownMenuItem(
                    value: "ทั้งหมด",
                    child: Text("ทั้งหมด"),
                  ),

                  DropdownMenuItem(
                    value: "ปกติ",
                    child: Text("ปกติ"),
                  ),

                  DropdownMenuItem(
                    value: "ใกล้หมด",
                    child: Text("ใกล้หมด"),
                  ),

                ],

                onChanged: (v){
                  setState(() {
                    filter = v!;
                  });
                },

              ),

              DropdownButton(

                value: sortType,

                items: const [

                  DropdownMenuItem(
                    value: "name",
                    child: Text("เรียงตามชื่อ"),
                  ),

                  DropdownMenuItem(
                    value: "qty",
                    child: Text("เรียงตามจำนวน"),
                  ),

                ],

                onChanged: (v){
                  setState(() {
                    sortType = v!;
                  });
                },

              ),

            ],
          ),

          const SizedBox(height: 10),

          // LIST

          Expanded(

            child: ListView.builder(

              itemCount: list.length,

              itemBuilder: (context,i){

                final item = list[i];

                return Dismissible(

                  key: Key(item.id.toString()),
                  direction: DismissDirection.endToStart,

                  background: Container(

                    decoration: const BoxDecoration(

                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFF6B6B),
                          Color(0xFFFF0000),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),

                    ),

                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 25),

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.end,

                      children: const [

                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 32,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],

                    ),

                  ),

                  confirmDismiss: (direction) async {

                    return await showDialog(

                      context: context,

                      builder: (context){

                        return AlertDialog(

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          title: const Text("ยืนยันการลบ"),

                          content: Text(
                            "ต้องการลบ ${item.name} หรือไม่?"
                          ),

                          actions: [

                            TextButton(
                              onPressed: (){
                                Navigator.pop(context,false);
                              },
                              child: const Text("ยกเลิก"),
                            ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: (){
                                Navigator.pop(context,true);
                              },
                              child: const Text("ลบ"),
                            ),

                          ],

                        );

                      }

                    );

                  },

                  onDismissed: (direction){

                    provider.deleteEquipment(item.id!);

                    ScaffoldMessenger.of(context).showSnackBar(

                      SnackBar(
                        content: Text("${item.name} ถูกลบแล้ว"),
                      ),

                    );

                  },

                  child: AnimatedContainer(

                    duration: const Duration(milliseconds: 200),

                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    child: Container(

                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(18),

                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0xFFF3F6FF),
                          ],
                        ),

                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0,6),
                          )
                        ],

                      ),

                      child: ListTile(

                        leading: const Icon(
                          Icons.devices,
                          color: Colors.indigo,
                          size: 30,
                        ),

                        title: Text(
                          item.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          "${item.quantity} ${item.unit} • ${item.status}",
                        ),

                        trailing: const Icon(Icons.arrow_forward_ios),

                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FormScreen(
  item: item,
)
                            ),
                          );
                        },

                      ),

                    ),

                  ),

                );

              },

            ),

          )

        ],

      ),

    );

  }

}