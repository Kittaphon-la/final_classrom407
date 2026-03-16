import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/equipment_provider.dart';
import '../models/equipment_model.dart';

class FormScreen extends StatefulWidget {

  final Equipment? item;

  const FormScreen({super.key, this.item});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  final noteController = TextEditingController();

  String status = "ปกติ";

  @override
  void initState() {
    super.initState();

    if(widget.item != null){

      nameController.text = widget.item!.name;
      typeController.text = widget.item!.type;
      quantityController.text = widget.item!.quantity.toString();
      unitController.text = widget.item!.unit;
      noteController.text = widget.item!.note;
      status = widget.item!.status;

    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<EquipmentProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.item == null
          ? "เพิ่มอุปกรณ์"
          : "แก้ไขอุปกรณ์"
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Form(

          key: formKey,

          child: ListView(

            children: [

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "ชื่ออุปกรณ์",
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "กรอกชื่อ";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(
                  labelText: "ประเภท",
                ),
              ),

              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "จำนวน",
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "กรอกจำนวน";
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: unitController,
                decoration: const InputDecoration(
                  labelText: "หน่วย",
                ),
              ),

              const SizedBox(height:10),

              DropdownButtonFormField(

                value: status,

                items: const [

                  DropdownMenuItem(
                    value: "ปกติ",
                    child: Text("ปกติ"),
                  ),

                  DropdownMenuItem(
                    value: "ใกล้หมด",
                    child: Text("ใกล้หมด"),
                  ),

                ],

                onChanged: (value){
                  setState(() {
                    status = value!;
                  });
                },

                decoration: const InputDecoration(
                  labelText: "สถานะ",
                ),

              ),

              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: "หมายเหตุ",
                ),
              ),

              const SizedBox(height:30),

              ElevatedButton(

                child: Text(
                  widget.item == null
                  ? "บันทึก"
                  : "อัปเดต"
                ),

                onPressed: (){

                  if(!formKey.currentState!.validate()){
                    return;
                  }

                  Equipment data = Equipment(

                    id: widget.item?.id,

                    name: nameController.text,
                    type: typeController.text,
                    quantity: int.tryParse(quantityController.text) ?? 0,
                    unit: unitController.text,
                    status: status,
                    note: noteController.text,
                    date: DateTime.now().toString(),

                  );

                  if(widget.item == null){

                    provider.addEquipment(data);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("เพิ่มข้อมูลแล้ว")),
                    );

                  }else{

                    provider.updateEquipment(data);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("อัปเดตข้อมูลแล้ว")),
                    );

                  }

                  Navigator.pop(context);

                },

              )

            ],

          ),

        ),

      ),

    );

  }

}