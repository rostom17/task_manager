class Urls{
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String loginUrl = '$_baseUrl/login';
  static const String addNewTask = '$_baseUrl/createTask';
  static const String allTask = '$_baseUrl/listTaskByStatus/New';
  static const String competedTask = '$_baseUrl/listTaskByStatus/Completed';
  static const String inProgress = '$_baseUrl/listTaskByStatus/Progress';
  static const String cancelled = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String status = '$_baseUrl/taskStatusCount';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
}