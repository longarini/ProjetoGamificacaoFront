class TaskData {
  final String id;
  final String nomeTask;

  const TaskData({
    required this.id,
    required this.nomeTask,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      id: json['_id'] as String,
      nomeTask: json['nomeTask'] as String,
    );
  }
}
