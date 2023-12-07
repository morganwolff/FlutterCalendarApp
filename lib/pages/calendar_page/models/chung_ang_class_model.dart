class ChungAngClassModel {
  const ChungAngClassModel({
    required this.coursesName,
    required this.buildingNumber,
    required this.classNumber,
    required this.startTime,
    required this.endTime,
  });

  final String coursesName;
  final int buildingNumber;
  final int classNumber;
  final String startTime;
  final String endTime;

  ChungAngClassModel.fromMap(Map<String, dynamic> source):
      coursesName = source["coursesName"],
      buildingNumber = int.parse(source["buildingNumber"]),
      classNumber = int.parse(source["classNumber"]),
      startTime = source["startTime"],
      endTime = source["endTime"];
}