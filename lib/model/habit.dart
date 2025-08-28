class Habit {
  String name;
  DateTime lastCompleted;
  bool isCompleted;
  int streak;
  int totalCompletions;

  Habit({
    required this.name,
    required this.lastCompleted,
    this.isCompleted = false,
    this.streak = 0,
    this.totalCompletions = 0,
  });
}