// ignore: file_names
class DaySlotCreateModel {
  String dayName;
  int dayIndex;
  String openTime;
  String closeTime;
  bool isClosed;

  DaySlotCreateModel({required this.dayName, required this.dayIndex, required this.openTime, required this.closeTime, required this.isClosed});

  Map<String, dynamic> toJson() {
    return {
      'dayName': dayName,
      'dayIndex': dayIndex,
      'openTime': openTime,
      'closeTime': closeTime,
      'isClosed': isClosed,
    };
  }
}

class PostData {
  String outlet;
  List<DaySlotCreateModel> daySlot;
  List<String> timeSlot;
  int capacityOnTime;

  PostData({required this.outlet, required this.daySlot, required this.timeSlot, required this.capacityOnTime});

  Map<String, dynamic> toJson() {
    return {
      'outlet': outlet,
      'daySlot': daySlot.map((e) => e.toJson()).toList(),
      'timeSlot': timeSlot,
      'capacityOnTime': capacityOnTime,
    };
  }
}
