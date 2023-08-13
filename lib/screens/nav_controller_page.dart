import 'package:flutter/material.dart';
import 'package:status_code0/models/networking.dart';
import 'package:status_code0/models/pedometer.dart';
import 'package:status_code0/screens/news.dart';
import 'package:status_code0/screens/meditation.dart';
import 'package:status_code0/screens/activity.dart';
import 'package:status_code0/screens/add_details.dart';
import 'package:status_code0/screens/profile.dart';
import 'package:status_code0/models/api_integrate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:status_code0/screens/rewards.dart';

final _firestore = FirebaseFirestore.instance;

const url =
    'https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=7ed5969f1fff48ea8d72286502cd2a33';

class HomePage extends StatefulWidget {
  HomePage(
      {super.key,
      required this.sleep_,
      required this.steps_,
      required this.water_,
      required this.weight_});

  final String steps_;
  final int weight_;
  final String sleep_;
  final String water_;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PedoMeter _pedoMeter = PedoMeter();

  late Widget activePage;
  String response = '';

  @override
  void initState() {
    activePage = OverViewScreen(
        steps: widget.steps_,
        sleep: widget.sleep_,
        water: widget.water_,
        weight: widget.weight_);
    // ApiIntegrate _apiIntegrate =
    //     ApiIntegrate(Sleep: widget.sleep_, Steps: widget.steps_);
    // _apiIntegrate.api_inte();
    response =
        '''Steps walked : ${widget.steps_} stept:${widget.sleep_}hrs what changes to make to improve health in single line .''';
    // TODO: implement initState
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _setPage(int index) async {
    setState(() {
      _selectedPageIndex = index;
    });
    //provider can be used

    if (index == 0) {
      await _pedoMeter.initPlatformState();

      setState(() {
        activePage = OverViewScreen(
          steps: _pedoMeter.steps,
          water: widget.water_,
          sleep: widget.sleep_,
          weight: widget.weight_,
        );
      });
    } else if (index == 1) {
      await getNewsData();
      setState(() {
        activePage = NewsPage(healthdata: healthdata!);
      });
    } else if (index == 2) {
      setState(() {
        activePage = AddDatapage();
      });
    } else if (index == 3) {
      setState(() {
        activePage = Meditation();
      });
    } else if (index == 4) {
      setState(() {
        activePage = UserProfile(
          steps: widget.steps_,
          sleep: widget.sleep_,
          weight: widget.weight_,
          prompt: response,
          height: "70",
        );
      });
    } else if (index == 5) {
      activePage = RewardPage();
    }
  }

  NetworkHelper networkHelper = NetworkHelper();

  Map<String, dynamic>? healthdata;

  Future<dynamic> getNewsData() async {
    NetworkHelper network = NetworkHelper(url: url);
    var newsdata = await network.getdata();
    healthdata = newsdata;
    return newsdata;
  }

  void _naviagate(int index) async {
    if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => NewsPage(
                    healthdata: healthdata!,
                  )));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => Meditation()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _setPage(index);
          // _naviagate(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.analytics,
              color: Colors.white,
              size: 30.0,
            ),
            label: "Analysis",
            backgroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.newspaper,
              color: Colors.white,
              size: 30.0,
            ),
            label: "Journal",
            backgroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 30.0,
            ),
            label: "Add",
            backgroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.self_improvement,
              color: Colors.white,
              size: 30.0,
            ),
            label: "Meditation",
            backgroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: 30.0,
            ),
            label: "Profile",
            backgroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              color: Colors.white,
              size: 30.0,
            ),
            label: "Reward",
            backgroundColor: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      ),
      body: activePage,
    );
  }
}
