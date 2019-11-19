import 'package:flutter/material.dart';
import 'package:test_animations/come_from_sides_screen.dart';
import 'package:test_animations/screen_with_scale.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Curve> possibleCurves = {
    "bounceIn": Curves.bounceIn,
    "bounceInOut": Curves.bounceInOut,
    "bounceOut": Curves.bounceOut,
    "decelerate": Curves.decelerate,
    "ease": Curves.ease,
    "easeIn": Curves.easeIn,
    "easeInBack": Curves.easeInBack,
    "easeInCirc": Curves.easeInCirc,
    "easeInCubic": Curves.easeInCubic,
    "easeInExpo": Curves.easeInExpo,
    "easeInOut": Curves.easeInOut,
    "easeInOutBack": Curves.easeInOutBack,
    "easeInOutCirc": Curves.easeInOutCirc,
    "easeInOutCubic": Curves.easeInOutCubic,
    "easeInOutExpo": Curves.easeInOutExpo,
    "easeInOutQuad": Curves.easeInOutQuad,
    "easeInOutQuart": Curves.easeInOutQuart,
    "easeInOutQuint": Curves.easeInOutQuint,
    "easeInOutSine": Curves.easeInOutSine,
    "easeInQuad": Curves.easeInQuad,
    "easeInQuart": Curves.easeInQuart,
    "easeInQuint": Curves.easeInQuint,
    "easeInSine": Curves.easeInSine,
    "easeInToLinear": Curves.easeInToLinear,
    "easeOut": Curves.easeOut,
    "easeOutBack": Curves.easeOutBack,
    "easeOutCirc": Curves.easeOutCirc,
    "easeOutCubic": Curves.easeOutCubic,
    "easeOutExpo": Curves.easeOutExpo,
    "easeOutQuad": Curves.easeOutQuad,
    "easeOutQuart": Curves.easeOutQuart,
    "easeOutQuint": Curves.easeOutQuint,
    "easeOutSine": Curves.easeOutSine,
    "elasticIn": Curves.elasticIn,
    "elasticInOut": Curves.elasticInOut,
    "elasticOut": Curves.elasticOut,
    "fastLinearToSlowEaseIn": Curves.fastLinearToSlowEaseIn,
    "fastOutSlowIn": Curves.fastOutSlowIn,
    "linear": Curves.linear,
    "linearToEaseOut": Curves.linearToEaseOut,
    "slowMiddle": Curves.slowMiddle,
  };
  Curve selectedCurve;
  List<int> possibleDuration;
  int selectedDuration = 1000;
  final PageController pageController = new PageController(initialPage: 1);

  @override
  void initState() {
    selectedCurve = possibleCurves["linear"];
    possibleDuration = List.generate(100, (int index) => index * 100);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: pageController,
        children: <Widget>[
          _leftPage(),
          _mainPage(),
          _rightPage(),
        ],
      ),
    );
  }

  void _openSecond() {
    Navigator.push(context,
        InvisibleRoute(page: ScreenWithScale(selectedDuration, selectedCurve)));
  }

  void _saveTransitionType(Curve value) {
    setState(() {
      selectedCurve = value;
    });
  }

  void _saveTransitionDuration(int value) {
    setState(() {
      selectedDuration = value;
    });
  }

  Widget _mainPage() {
    return Container(
      color: Colors.green,
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: _showPrevScreen,
                  icon: Icon(Icons.chevron_left),
                ),
                IconButton(
                  onPressed: _showNextScreen,
                  icon: Icon(Icons.chevron_right),
                )
              ],
            ),
            Text(
                "Please select the duration of the transition in milliseconds"),
            DropdownButton<int>(
              value: selectedDuration,
              onChanged: _saveTransitionDuration,
              items: possibleDuration.map((int value) {
                return DropdownMenuItem<int>(
                  child: Text("$value ms"),
                  value: value,
                );
              }).toList(),
            ),
            SizedBox(
              height: 16,
            ),
            Text("Please select the type of transition"),
            DropdownButton<Curve>(
              value: selectedCurve,
              onChanged: _saveTransitionType,
              items: possibleCurves.entries
                  .map((MapEntry<String, Curve> curveItem) {
                return new DropdownMenuItem<Curve>(
                  child: new Text(
                    curveItem.key,
                  ),
                  value: curveItem.value,
                );
              }).toList(),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Please tap the blue box to see the transition for the new page',
            ),
            GestureDetector(
              onTap: _openSecond,
              child: Container(
                color: Colors.blue,
                constraints: BoxConstraints.expand(height: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPrevScreen() {
    pageController.previousPage(
      duration: Duration(milliseconds: selectedDuration),
      curve: selectedCurve,
    );
  }

  void _showNextScreen() {
    pageController.nextPage(
      duration: Duration(milliseconds: selectedDuration),
      curve: selectedCurve,
    );
  }

  Widget _leftPage() {
    return Container(
      color: Colors.lightGreen,
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Left page"),
          IconButton(
            onPressed: _showNextScreen,
            icon: Icon(Icons.chevron_right),
          ),
          SizedBox(
            height: 24,
          ),
          RaisedButton(
            child: Text("OPEN CHAT"),
            onPressed: _openChat,
          )
        ],
      ),
    );
  }

  Widget _rightPage() {
    return Container(
      color: Colors.lightGreen,
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Right page"),
          IconButton(
            onPressed: _showPrevScreen,
            icon: Icon(Icons.chevron_left),
          ),
        ],
      ),
    );
  }

  void _openChat() {
    Navigator.push(
        context,
        InvisibleRoute(
            page: ComeFromSidesScreen(selectedDuration, selectedCurve)));
  }
}

class InvisibleRoute extends PageRouteBuilder {
  @override
  Duration get transitionDuration => Duration.zero;

  final Widget page;
  InvisibleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
        );
}
