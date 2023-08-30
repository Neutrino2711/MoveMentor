import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

int timerdur = 0;

class Meditation extends StatelessWidget {
  Meditation({super.key});

  List<DurationTab> duration = [
    const DurationTab(dur: 3),
    const DurationTab(dur: 5),
    const DurationTab(dur: 10),
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
          decoration: const BoxDecoration(
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
                icon: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white70,
                ),
              ),
              const Center(
                child: Text("Meditation",
                    style: TextStyle(
                        fontSize: 45.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold)),
              ),
              // SizedBox(
              //   height: 250.0,
              // ),
              const Padding(
                padding: EdgeInsets.all(11.0),
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
                    ],
                    // begin: Alignment.bottomRight,
                    // end: Alignment.topLeft,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                height: MediaQuery.sizeOf(context).height * 0.20,
                width: double.infinity,
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // scrollDirection: Axis.horizontal,
                  children: duration,
                ),
              ),
              // SizedBox(
              //   height: 250.0,
              // ),
              MediPop(assetsAudioPlayer: assetsAudioPlayer)
            ],
          )),
    );
  }
}

class MediPop extends StatelessWidget {
  const MediPop({
    super.key,
    required this.assetsAudioPlayer,
  });

  final AssetsAudioPlayer assetsAudioPlayer;

  @override
  Widget build(BuildContext context) {
    return Center(
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
                            '${time.toString()} sec left',
                            style: const TextStyle(
                              fontSize: 40.0,
                            ),
                          ),
                        );
                      },
                      interval: const Duration(milliseconds: 100),
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
              backgroundColor: MaterialStateProperty.all(Colors.white30),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)))),
          child: const Text(
            'Begin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
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
          '${widget.dur!.toString()} min',
          style: TextStyle(
            color: clicked ? Colors.black : Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
