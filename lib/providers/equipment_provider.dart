import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../services/database_service.dart';
import '../models/equipment_model.dart';

class EquipmentProvider extends ChangeNotifier {

  List<Equipment> equipments = [];

  Future<void> loadEquipments() async {

    Database db = await DatabaseService().database;

    final data = await db.query("equipments");

    equipments = data.map((e) => Equipment.fromMap(e)).toList();

    notifyListeners();
  }

  Future<void> addEquipment(Equipment e) async {

    Database db = await DatabaseService().database;

    await db.insert("equipments", e.toMap());

    await loadEquipments();
  }
   
  Future<void> deleteEquipment(int id) async {

    Database db = await DatabaseService().database;

    await db.delete(
      "equipments",
      where: "id=?",
      whereArgs: [id],
    );

    await loadEquipments();
  }

  Future<void> updateEquipment(Equipment e) async {

    Database db = await DatabaseService().database;

    await db.update(
      "equipments",
      e.toMap(),
      where: "id=?",
      whereArgs: [e.id],
    );

    await loadEquipments();
  }
}