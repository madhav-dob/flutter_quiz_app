import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //accentColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent, // Make button transparent
            shadowColor: Colors.transparent, // Remove button shadow
            textStyle: TextStyle(fontSize: 18),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ).copyWith(
            elevation: MaterialStateProperty.all(0), // Remove button elevation
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  // Apply gradient when button is pressed
                  return Colors.green; // Change to desired pressed color
                }
                // Normal button color
                return Colors.blue; // Change to desired normal color
              },
            ),
          ),
        ),
      ),
      home: WelcomeScreen(),
      routes: {
        '/quiz': (context) => QuizPage(),
        '/moreQuizzes': (context) => MoreQuizzesScreen(),
        '/aboutUs': (context) => AboutUsScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Quiz App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _questionIndex = 0;
  int _totalScore = 0;

  List<Map<String, dynamic>> _questions = [
    {
      'questionText': 'What is the capital of France?',
      'answers': ['London', 'Berlin', 'Paris', 'Madrid'],
      'correctAnswer': 'Paris',
    },
    {
      'questionText': 'Which planet is known as the Red Planet?',
      'answers': ['Jupiter', 'Mars', 'Saturn', 'Mercury'],
      'correctAnswer': 'Mars',
    },
    {
      'questionText': 'Who painted the Mona Lisa?',
      'answers': [
        'Vincent van Gogh',
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Michelangelo'
      ],
      'correctAnswer': 'Leonardo da Vinci',
    },
    // Add more questions here
  ];

  void _answerQuestion(String selectedAnswer) {
    if (selectedAnswer == _questions[_questionIndex]['correctAnswer']) {
      setState(() {
        _totalScore++;
      });
    }
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Quiz'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text(
                'Score: $_totalScore/${_questions.length}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              questionIndex: _questionIndex,
              questions: _questions,
              answerQuestion: _answerQuestion,
            )
          : Result(
              totalScore: _totalScore,
              resetQuiz: _resetQuiz,
              questionsLength: _questions.length,
            ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.green], // Gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                'Quiz App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('More Quizzes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/moreQuizzes');
              },
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/aboutUs');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, dynamic>> questions;
  final Function(String) answerQuestion;

  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          questions[questionIndex]['questionText'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        ...(questions[questionIndex]['answers'] as List<String>).map((answer) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ElevatedButton(
              onPressed: () => answerQuestion(answer),
              child: Text(answer),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetQuiz;
  final int questionsLength;

  Result(
      {required this.totalScore,
      required this.resetQuiz,
      required this.questionsLength});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You completed the quiz!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Your Score: $totalScore/$questionsLength',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => resetQuiz(),
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}

class MoreQuizzesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More Quizzes'),
      ),
      body: Center(
        child: Text(
          'More Quizzes will be available here.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Text(
          'Information about the app and its developers will be here.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
