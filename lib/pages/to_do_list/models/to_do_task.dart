class ToDoTask {
  const ToDoTask({required this.task, required this.completed});

  final String task;

  final bool completed;

  ToDoTask.fromJson(Map<String, dynamic> json):
    task = json["task"],
    completed = json["completed"];

  Map toJson() => {
    "task": task,
    "completed": completed
  };
}