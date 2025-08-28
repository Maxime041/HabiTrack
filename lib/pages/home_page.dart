import 'package:flutter/material.dart';
import 'package:habitrack/model/habit.dart';
import 'package:habitrack/pages/add_habit_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Habit> habits = [
    Habit(
      name: 'Boire 8 verres d\'eau',
      isCompleted: false,
      streak: 5,
      totalCompletions: 15,
      lastCompleted: DateTime.now().subtract(Duration(days: 1)),
    ),
    Habit(
      name: 'Faire 30 minutes de sport',
      isCompleted: true,
      streak: 3,
      totalCompletions: 8,
      lastCompleted: DateTime.now(),
    ),
    Habit(
      name: 'Lire 20 pages',
      isCompleted: false,
      streak: 2,
      totalCompletions: 12,
      lastCompleted: DateTime.now().subtract(Duration(days: 2)),
    ),
    Habit(
      name: 'Méditer 10 minutes',
      isCompleted: true,
      streak: 7,
      totalCompletions: 20,
      lastCompleted: DateTime.now(),
    ),

  ];

  // ia
  @override
  void initState() {
    super.initState();
    resetHabitsIfNewDay();
  }

 // ia
 void resetHabitsIfNewDay() {
    DateTime today = DateTime.now();
    
    for (int i = 0; i < habits.length; i++) {
      DateTime lastDay = habits[i].lastCompleted;
      
      int differenceInDays = today.difference(lastDay).inDays;
      
      if (today.day != lastDay.day || today.month != lastDay.month || today.year != lastDay.year) {
        habits[i].isCompleted = false;
        
        if (differenceInDays > 1) {
          habits[i].streak = 0;
        }
      }
    }
    setState(() {});
  }

  // ia
  void toggleHabit(int index) {
    setState(() {
      if (habits[index].isCompleted == false) {
        DateTime today = DateTime.now();
        DateTime lastDay = habits[index].lastCompleted;
        int differenceInDays = today.difference(lastDay).inDays;
        
        habits[index].isCompleted = true;
        habits[index].totalCompletions = habits[index].totalCompletions + 1;
        habits[index].lastCompleted = today;
        
        if (differenceInDays == 1 || differenceInDays == 0) {
          habits[index].streak += 1;
        } 
        else {
          habits[index].streak = 1;
        }
      } 
      else 
      {
        habits[index].isCompleted = false;
        habits[index].totalCompletions = habits[index].totalCompletions - 1;
        habits[index].streak = habits[index].streak - 1;
        
        if (habits[index].totalCompletions < 0) {
          habits[index].totalCompletions = 0;
        }
        if (habits[index].streak < 0) {
          habits[index].streak = 0;
        }
      }
    });
  }
  

  int getMaxStreak() {
    int max = 0;
    int i = 0;
    for (i = 0; i < habits.length; i++) {
      if (habits[i].streak > max) {
        max = habits[i].streak;
      }
    }
    return max;
  }

  int getCompletedToday() {
    int completed = 0;
    int i = 0;
    for (i = 0; i < habits.length; i++) {
      if (habits[i].isCompleted == true) {
        completed++;
      }
    }
    return completed;
  }

  void addHabit(String habitName) {
    setState(() {
      habits.add(Habit(
        name: habitName,
        lastCompleted: DateTime.now(),
      ));
    });
  }

  void removeHabit(String habitName) {
    setState(() {
      int i = 0;
      for (i = 0; i < habits.length; i++) {
        if (habits[i].name == habitName) {
          habits.removeAt(i);
          break; 
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bonjour',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 40),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 41, 45, 58),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue[300]!.withOpacity(0.1),
                            child: Icon(
                              Icons.list,
                              color: Colors.blue[300],
                              size: 20,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Habitudes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${habits.length}",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 41, 45, 58),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.green[300]!.withOpacity(0.1),
                            child: Icon(
                              Icons.whatshot,
                              color: Colors.green[300],
                              size: 20,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Max Streak",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${getMaxStreak()} jours",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 41, 45, 58),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                Colors.orange[300]!.withOpacity(0.1),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.orange[300],
                              size: 20,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Aujourd'hui",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${getCompletedToday()}/${habits.length}",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              Text(
                "Mes habitudes",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    Habit habit = habits[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 41, 45, 58),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  habit.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    decoration: habit.isCompleted ? TextDecoration.lineThrough : null,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Streak: ${habit.streak} jours - Total: ${habit.totalCompletions}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Checkbox(
                            value: habit.isCompleted,
                            onChanged: (value) {
                              toggleHabit(index);
                            },
                          ),
                          IconButton(onPressed: () => removeHabit(habit.name), icon: Icon(Icons.delete, color: Colors.red)),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AddHabitPage(
                        onAddHabit: addHabit,
                      ),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Ajouter une habitude',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
