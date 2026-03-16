class Equipment {

  int? id;
  String name;
  String type;
  int quantity;
  String unit;
  String status;
  String note;
  String date;

  Equipment({
    this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.unit,
    required this.status,
    required this.note,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'unit': unit,
      'status': status,
      'note': note,
      'date': date,
    };
  }

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      quantity: map['quantity'],
      unit: map['unit'],
      status: map['status'],
      note: map['note'],
      date: map['date'],
    );
  }
}