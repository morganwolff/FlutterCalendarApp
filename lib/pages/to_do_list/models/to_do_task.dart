class ToDoTask {
  ToDoTask({required this.task, required this.completed});

  String task = "";

  bool completed = false;

  ToDoTask.fromJson(Map<String, dynamic> json)
      : task = json["task"],
        completed = json["completed"];

  Map toJson() => {"task": task, "completed": completed};
}
