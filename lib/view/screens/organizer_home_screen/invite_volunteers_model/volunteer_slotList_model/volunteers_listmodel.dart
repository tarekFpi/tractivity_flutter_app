// ignore: file_names
class VolunteersListModel {
  String volunteer;
  String workTitle;

  VolunteersListModel({required this.volunteer, required this.workTitle});

  Map<String, dynamic> toJson() {
    return {
      'volunteer': volunteer,
      'workTitle': workTitle,
    };
  }
}


