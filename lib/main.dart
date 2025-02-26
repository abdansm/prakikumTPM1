import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 86, 170, 253),
        ),
      ),
      home: const MyHomePage(title: 'Quiz yang Iya-Iyalah'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int kuncijawab = 0;
  String jawab = "0";
  int angkaA = 0;
  int angkaB = 0;
  bool finish = false;
  bool sukses = false;
  String btnText = "Mulai";
  String soal = "ini adalah soal";
  String img = "assets/images/kucing_berdiri+gun.jpg";
  String msg =
      "Jawab 5 Pertanyaan ini atau kau akan menanggung akibatnya (0/5)";

  void _reset() {
    setState(() {
      _counter = 0;
      finish = false;
      sukses = false;
      btnText = "Mulai";
      img = "assets/images/kucing_berdiri+gun.jpg";
      msg = "Jawab 5 Pertanyaan ini atau kau akan menanggung akibatnya (0/5)";
    });
  }

  void _jalankanquiz() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (jawab == "") {
        msg = "jawab dengan benar ya";
      } else {
        if (_counter == 0) {
          img = "assets/images/kucing_berdiri+gun.jpg";
          btnText = "Submit";
          jawab = "";

          //membuat soal
          angkaA = random(1, 10);
          angkaB = random(1, 10);
          if (angkaA % 2 == 0) {
            soal = "$angkaA - $angkaB = ";
            kuncijawab = angkaA - angkaB;
          } else if (angkaB % 4 == 0) {
            soal = "$angkaA * $angkaB = ";
            kuncijawab = angkaA * angkaB;
          } else {
            soal = "$angkaA + $angkaB = ";
            kuncijawab = angkaA + angkaB;
          }
        } else {
          //koreksi soal
          int jawaban = int.parse(jawab);
          if (jawaban != kuncijawab) {
            finish = true;

            sukses = false;
          } else if (_counter > 4) {
            finish = true;
            sukses = true;
          }

          angkaA = random(1, 10);
          angkaB = random(1, 10);
          if (angkaA % 2 == 0) {
            soal = "$angkaA - $angkaB = ";
            kuncijawab = angkaA - angkaB;
          } else if (angkaB % 4 == 0) {
            soal = "$angkaA * $angkaB = ";
            kuncijawab = angkaA * angkaB;
          } else {
            soal = "$angkaA + $angkaB = ";
            kuncijawab = angkaA + angkaB;
          }
        }
        _counter++;
        msg =
            "Jawab 5 Pertanyaan ini atau kau akan menanggung akibatnya ($_counter/5)";

        if (_counter > 0 && !finish) {
          img = "assets/images/cat_mikir.gif";
        } else if (!sukses && finish) {
          img = "assets/images/kucing_nangis.jpg";
          msg = "Segini saja kah kemampuanmu?!?!";
          soal = "Jawaban Salah";
        } else if (sukses && finish) {
          img = "assets/images/happi2.gif";
          msg = "Selamat sudah menamatkan quiz ini?!?!";
        }
      }
    });
  }

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  //bool koreksi(String jawab) {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Reset Icon',
            onPressed: _reset,
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // const Text('Tombol sudah diteakan sebanyak'),
            Image.asset(img, height: 200.0, width: 200.0),
            Text(msg, style: Theme.of(context).textTheme.bodyMedium),
            if (_counter > 0 && !sukses)
              Text(soal, style: Theme.of(context).textTheme.headlineSmall),
            if (_counter > 0 && !finish)
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Jawabanmu'),
                  keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (value) => jawab = value,
                ),
              ),
            if (!finish)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: _jalankanquiz,
                  child: Text(btnText),
                ),
              ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
