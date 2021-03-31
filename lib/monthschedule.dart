import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.maliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  TextEditingController _startController;
  TextEditingController _stopController;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _startController = TextEditingController();
    _stopController = TextEditingController();
    _events = {};
    _selectedEvents = [];
  }

  @override
  void dispose() {
    _controller.dispose();
    _eventController.dispose();
    _startController.dispose();
    _stopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hexColor(String colorhexcode) {
      String colornew = '0xff' + colorhexcode;
      colornew = colornew.replaceAll('#', '');
      int colorint = int.parse(colornew);
      return colorint;
    }

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(40.0),
      topRight: Radius.circular(40.0),
    ); //for bottom part

    var logo = [
      Text('I',
          style: GoogleFonts.mali(
            textStyle: TextStyle(
              color: Color(hexColor('#BED4DF')),
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          )),
      Text('o',
          style: GoogleFonts.mali(
            textStyle: TextStyle(
              color: Color(hexColor('#CCADA5')),
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          )),
      Text('T',
          style: GoogleFonts.mali(
            textStyle: TextStyle(
              color: Color(hexColor('#FFB9A3')),
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          )),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.dehaze_rounded),
              color: Color(hexColor('#30415E')),
              onPressed: () {},
            ),
            Row(
              children: logo,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Planning',
                      style: GoogleFonts.mali(
                        textStyle: TextStyle(
                          color: Color(hexColor('#30415E')),
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                        ),
                      )),
                  Text('Your Event',
                      style: GoogleFonts.mali(
                        textStyle: TextStyle(
                          color: Color(hexColor('#30415E')),
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                        ),
                      )),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              color: Color(hexColor('#EFF4FF')),
              margin: const EdgeInsets.all(25.0),
              child: TableCalendar(
                events: _events,
                weekendDays: [],
                initialCalendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: '',
                },
                calendarStyle: CalendarStyle(
                    unavailableStyle: TextStyle(fontWeight: FontWeight.w700),
                    weekdayStyle: TextStyle(
                        color: Color(hexColor('#153970')),
                        fontWeight: FontWeight.w700),
                    canEventMarkersOverflow: true,
                    todayColor: Colors.orange,
                    selectedColor: Theme.of(context).primaryColor,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white)),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                      color: Color(hexColor('#153970')),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20.0)),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                ),
                startingDayOfWeek: StartingDayOfWeek.sunday,
                onDaySelected: (date, events, event2) {
                  setState(() {
                    _selectedEvents = events;
                    print(events.toString());
                  });
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          // borderRadius: BorderRadius.circular(10.0),
                          shape: BoxShape.circle),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          // borderRadius: BorderRadius.circular(10.0),
                          shape: BoxShape.circle),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                calendarController: _controller,
              ),
            ),
          ],
        ),
        SlidingUpPanel(
          isDraggable: false,
          minHeight: 210,
          maxHeight: 210,
          panel: Center(
            child: Text("This is the sliding Widget"),
          ),
          collapsed: Container(
              decoration: BoxDecoration(
                  color: Color(hexColor('#153970')), borderRadius: radius),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 7.5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 60, right: 60),
                          child: Text("Today's tasks",
                              style: GoogleFonts.mali(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                  ..._selectedEvents.map((value) => ListTile(
                        title: Text(
                            "${value.event} @${value.start}-${value.stop}"),
                      )),
                ],
              )),
          borderRadius: radius,
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    TextField(
                        controller: _eventController,
                        decoration: InputDecoration(
                            labelText: "Activity",
                            hintText: "Enter activity name")),
                    TextField(
                        controller: _startController,
                        decoration: InputDecoration(
                            labelText: "Start time",
                            hintText: "Enter start time")),
                    TextField(
                        controller: _stopController,
                        decoration: InputDecoration(
                            labelText: "Stop time",
                            hintText: "Enter stop time"))
                  ])),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    if (_events[_controller.selectedDay] != null) {
                      _events[_controller.selectedDay].add('temporary fix');
                      _events[_controller.selectedDay].removeLast();
                    } else {
                      _events[_controller.selectedDay] = ['temporary fix'];
                      _events[_controller.selectedDay].removeLast();
                    }
                    Navigator.pop(context, false);
                    // Navigator.pop(null);
                  },
                ),
                TextButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    if (_startController.text.isEmpty)
                      _startController.text = '12.00';
                    if (_stopController.text.isEmpty)
                      _stopController.text = '13.00';
                    if (_events[_controller.selectedDay] != null) {
                      _events[_controller.selectedDay].add(Event(
                          _eventController.text,
                          _startController.text,
                          _stopController.text));
                    } else {
                      _events[_controller.selectedDay] = [
                        Event(_eventController.text, _startController.text,
                            _stopController.text)
                      ];
                    }
                    _eventController.clear();
                    _startController.clear();
                    _stopController.clear();
                    Navigator.pop(context, true);
                    // Navigator.pop(context);
                  },
                )
              ],
            )).then((event) {
      if (event == null) return;
      if (event) {
      } else {}
    });
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
  }
}

class Event {
  String event;
  String start;
  String stop;

  Event(String x, String y, String z) {
    this.event = x;
    this.start = y;
    this.stop = z;
  }
}
