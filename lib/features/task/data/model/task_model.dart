




class TaskModel
{
  final int? id;
  final String? title;
  final String? note;
  final String? startTime;
  final String? endTime;
  final String? date;
  final int? isCompleted;
  final int color;



  TaskModel({
    required this.title,
    required this.color,
    required this.date,
    required this.endTime,
     this.id,
    required this.note,
     required this.startTime,
    required this.isCompleted,
  });

factory TaskModel.formjason(Map<String, dynamic> jsonData){
  return TaskModel(
    id:jsonData['id'],
    date: jsonData['date'],
    title: jsonData['title'],
    note: jsonData['note'],
    startTime: jsonData['startTime'],
    endTime: jsonData['endTime'],
    isCompleted: jsonData['isCompleted'],
    color: jsonData['color'],

  );
}


}