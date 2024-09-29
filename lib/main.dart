import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Map> allQuestions = [
    {
      "question": "Who is the founder of Microsoft?",
      "option": ["Steve Jobs", "Bill Gates", "Larry Page", "Elon Musk"],
      "correctAns": 1
    },
    {
      "question": "Who is the founder of Google?",
      "option": ["Steve Jobs", "Bill Gates", "Larry Page", "Elon Musk"],
      "correctAns": 2
    },
    {
      "question": "Who is the founder of SpaceX?",
      "option": ["Steve Jobs", "Bill Gates", "Larry Page", "Elon Musk"],
      "correctAns": 3
    },
    {
      "question": "Who is the founder of Apple?",
      "option": ["Steve Jobs", "Bill Gates", "Larry Page", "Elon Musk"],
      "correctAns": 0
    },
    {
      "question": "Who is the founder of Facebook?",
      "option": ["Steve Jobs", "Mark Zuckerberg", "Larry Page", "Elon Musk"],
      "correctAns": 1
    },
  ];

  int currentQuestionIndex = 0;
  int selectedAnswerIndex = -1;
  bool questionPage = true;
  int score = 0;

  WidgetStateProperty<Color?> checkAnswer(int answerIndex) {
    if (selectedAnswerIndex != -1) {
      if (answerIndex == allQuestions[currentQuestionIndex]["correctAns"]) {
        return const WidgetStatePropertyAll(Colors.green);
      } else if (selectedAnswerIndex == answerIndex) {
        return const WidgetStatePropertyAll(Colors.red);
      } else {
        return const WidgetStatePropertyAll(null);
      }
    } else {
      return const WidgetStatePropertyAll(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isQuestionScreen();
  }

  Scaffold isQuestionScreen() {
    if (questionPage) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz App",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 177, 33, 243),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.redAccent], 
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 420),
                  Text(
                    "Question: ${currentQuestionIndex + 1}/${allQuestions.length}",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 380,
                height: 50,
                child: Text(
                  allQuestions[currentQuestionIndex]["question"],
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 54, 24, 59),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              buildOptionButton(0, "A."),
              const SizedBox(height: 25),
              buildOptionButton(1, "B."),
              const SizedBox(height: 25),
              buildOptionButton(2, "C."),
              const SizedBox(height: 25),
              buildOptionButton(3, "D."),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedAnswerIndex != -1) {
              if (selectedAnswerIndex == allQuestions[currentQuestionIndex]["correctAns"]) {
                score++;
              }
              if (currentQuestionIndex < allQuestions.length - 1) {
                currentQuestionIndex++;
              } else {
                questionPage = false;
              }
              selectedAnswerIndex = -1;
              setState(() {});
            }
          },
          backgroundColor: const Color.fromARGB(255, 46, 82, 111),
          child: const Icon(
            Icons.forward,
            color: Color.fromARGB(255, 226, 178, 178),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz Result",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.red], 
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://media.istockphoto.com/id/1182465245/photo/gold-winners-trophy-champion-cup-with-falling-confetti.jpg?s=612x612&w=0&k=20&c=oL7XQ2GgDptAOYAZY_63kYjRrAnb_Zhn0GUdNLy4rpY=",
                  height: 300,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 159, 27, 203),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Score: $score/${allQuestions.length}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  width: 380,
                  child: ElevatedButton(
                    onPressed: () {
                      currentQuestionIndex = 0;
                      score = 0;
                      questionPage = true;
                      setState(() {});
                    },
                    child: const Text("Reset Test",
                    style: TextStyle(
                      color: Colors.pink,
                      
                    ),
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

  Widget buildOptionButton(int index, String label) {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: checkAnswer(index),
        ),
        onPressed: () {
          if (selectedAnswerIndex == -1) {
            selectedAnswerIndex = index;
            setState(() {});
          }
        },
        child: Text(
          "$label ${allQuestions[currentQuestionIndex]["option"][index]}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
