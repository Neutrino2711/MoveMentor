import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

int timerdur = 0;

class Meditation extends StatelessWidget {
  Meditation({super.key});

  List<DurationTab> duration = [
    DurationTab(dur: 3),
    DurationTab(dur: 5),
    DurationTab(dur: 10),
  ];

  final assetsAudioPlayer = AssetsAudioPlayer();

  void playMusic() {
    assetsAudioPlayer.open(
      Audio("assets/audios/song1.mp3"),
      autoStart: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    playMusic();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/login1.jpg'),
              fit: BoxFit.fill,
            ),
            // color: Colors.white
            // gradient: LinearGradient(
            //   colors: [
            //     Theme.of(context).colorScheme.primary,
            //     Theme.of(context).colorScheme.onPrimaryContainer,
            //   ],
            //   // begin: Alignment.bottomRight,
            //   // end: Alignment.topLeft,
            // ),
          ),
          // color: Theme.of(context).colorScheme.inverseSurface),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 15.0,
              // ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  assetsAudioPlayer.stop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white70,
                ),
              ),
              Center(
                child: Text("Meditation",
                    style: TextStyle(
                        fontSize: 45.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold)),
              ),
              // SizedBox(
              //   height: 250.0,
              // ),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text("PICK A DURATION",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    )),
              ),

              // Row(children: [
              //   Container()
              // ],)
              Container(
                // color: Colors.black54,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.onPrimaryContainer,
                      Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.9),
                      Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.5),
                      // Theme.of(context).colorScheme.onPrimary,
                      // Theme.of(context).colorScheme.primary,
                      // Theme.of(context).colorScheme.onPrimaryContainer,
                      // color.withOpacity(0.66),
                      // color.withOpacity(0.55),
                    ],
                    // begin: Alignment.bottomRight,
                    // end: Alignment.topLeft,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                height: MediaQuery.sizeOf(context).height * 0.10,
                width: double.infinity,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // scrollDirection: Axis.horizontal,
                    children: duration,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 250.0,
              // ),
              Center(
                child: Container(
                  // color: Colors.black38,
                  height: 70.0,
                  width: 200.0,
                  padding: EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      assetsAudioPlayer.play();
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.sizeOf(context).height * 1,
                              // color: Colors.grey,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.orangeAccent.shade100,
                                  Colors.orangeAccent.shade200,
                                  Colors.orangeAccent.shade400,
                                  Colors.orangeAccent.withOpacity(0.5),
                                ]),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Countdown(
                                seconds: timerdur * 60,
                                build: (BuildContext context, double time) {
                                  return Center(
                                    child: Text(
                                      time.toString() + ' sec left',
                                      style: TextStyle(
                                        fontSize: 40.0,
                                      ),
                                    ),
                                  );
                                },
                                interval: Duration(milliseconds: 100),
                                onFinished: () {
                                  Navigator.pop(context);
                                  assetsAudioPlayer.stop();
                                },
                              ),
                              // height: 200.0,
                            );
                          });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white30),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)))),
                    child: Text(
                      'Begin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class DurationTab extends StatefulWidget {
  const DurationTab({this.dur});

  final int? dur;

  @override
  State<DurationTab> createState() => _DurationTabState();
}

class _DurationTabState extends State<DurationTab> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        onPressed: () {
          setState(() {
            timerdur = widget.dur!;
            if (!clicked)
              clicked = true;
            else
              clicked = false;
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white30),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)))),
        child: Text(
          widget.dur!.toString() + ' min',
          style: TextStyle(
            color: clicked ? Colors.black : Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
