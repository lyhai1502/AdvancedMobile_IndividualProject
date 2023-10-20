import 'package:flutter/material.dart';

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                    width: 80,
                    height: 80,
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset('lib/assets/icons/facebook.png'),
                    )),
                const Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset('lib/assets/icons/vietnam.png'),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 5),
                    ),
                    const Text('Vietnam')
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 5; i++)
                      const Icon(Icons.star,
                          size: 20, color: Colors.amberAccent),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                Wrap(
                  children: [
                    for (var i = 6; i < 16; i++)
                      Container(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.lightBlue),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {},
                              child: Text(i.toString())))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                const Text(
                  "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.monitor_heart_sharp),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {},
                        child: const Text('Reset filter'))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
