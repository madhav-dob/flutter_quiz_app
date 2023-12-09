import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.indigo,
            onPrimary: Colors.white,
            textStyle: TextStyle(fontSize: 18),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            child: Image.asset(
              'assets/1.png',
              width: 220,
              height: 220,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to this Quiz App!',
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
          Positioned(
            bottom: 10,
            child: Image.asset(
              'assets/logo_big.png',
              width: 220,
              height: 80,
            ),
          ),
        ],
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
      'questionText': 'What does HTML stand for?',
      'answers': [
        'Hyper Text Markup Language',
        'Hyperlinks and Text Markup Language',
        'Home Tool Markup Language',
        'Hyperlink Transfer Markup Language'
      ],
      'correctAnswer': 'Hyper Text Markup Language',
    },
    {
      'questionText':
          'Which programming language is often used for artificial intelligence?',
      'answers': ['Python', 'Java', 'C++', 'Ruby'],
      'correctAnswer': 'Python',
    },
    {
      'questionText':
          'What is the name of the algorithm that sorts items in an array by repeatedly stepping through the list to be sorted?',
      'answers': ['QuickSort', 'MergeSort', 'BubbleSort', 'InsertionSort'],
      'correctAnswer': 'BubbleSort',
    },
    {
      'questionText': 'Who is known as the father of modern computer science?',
      'answers': [
        'Ada Lovelace',
        'Charles Babbage',
        'Alan Turing',
        'Bill Gates'
      ],
      'correctAnswer': 'Alan Turing',
    },
    {
      'questionText': 'What does VPN stand for?',
      'answers': [
        'Virtual Private Network',
        'Visual Personal Network',
        'Very Protected Network',
        'Virtual Personal Network'
      ],
      'correctAnswer': 'Virtual Private Network',
    },
    {
      'questionText':
          'Which company developed the programming language "Java"?',
      'answers': ['Microsoft', 'IBM', 'Sun Microsystems', 'Apple'],
      'correctAnswer': 'Sun Microsystems',
    },
    {
      'questionText':
          'What is the main purpose of a firewall in a computer system?',
      'answers': [
        'To block unauthorized access',
        'To speed up internet browsing',
        'To store files securely',
        'To play games'
      ],
      'correctAnswer': 'To block unauthorized access',
    },
    {
      'questionText': 'What does HTTP stand for?',
      'answers': [
        'Hyper Transfer Text Protocol',
        'Hyperlink Transfer Text Protocol',
        'Hyper Text Transfer Protocol',
        'Home Text Transfer Protocol'
      ],
      'correctAnswer': 'Hyper Text Transfer Protocol',
    },
    {
      'questionText':
          'Which data structure uses the Last In, First Out (LIFO) method?',
      'answers': ['Queue', 'Stack', 'Tree', 'Array'],
      'correctAnswer': 'Stack',
    },
    {
      'questionText':
          'Which search algorithm is considered more efficient for searching large lists?',
      'answers': [
        'Linear Search',
        'Binary Search',
        'Hash Search',
        'Depth-First Search'
      ],
      'correctAnswer': 'Binary Search',
    },
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
        title: Text('My Quiz App'),
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
                color: Colors.orange,
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
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 25,
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
          'This app is developed by : \n Madhav Agarwal \n Roll No. 20221426 \n       22020570003\n BSc. Hons Computer Science',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
