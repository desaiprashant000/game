import 'package:flutter/material.dart';
import 'package:game/game-1.dart';

void main() {
  runApp(MaterialApp(
    home: game  (),
    debugShowCheckedModeBanner: false,
  ));
}

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  List imagelist = [
    "bubble-tea.png",
    "burger.png",
    "fish.png",
    "jelly.png",
    "sandwich.png",
    "vegetables.png",
    "bubble-tea.png",
    "burger.png",
    "fish.png",
    "jelly.png",
    "sandwich.png",
    "vegetables.png"
  ];
  List visiblelist = List.filled(12, true);
  int t = 1;
  int? pos1, pos2;
  String s1 = "", s2 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagelist.shuffle();
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        visiblelist = List.filled(12, false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (visiblelist[index] == false && t == 1) {
                  print("t=$t");
                  visiblelist[index] = true;
                  s1 = imagelist[index];
                  pos1 = index;
                  t = 3;
                  Future.delayed(Duration(milliseconds: 20)).then((value) {
                    t = 2;
                  });
                }
                if (visiblelist[index] == false && t == 2) {
                  print("t=$t");
                  visiblelist[index] = true;
                  s2 = imagelist[index];
                  pos2 = index;
                  t = 3;
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    if (s1 != "" && s2 != "") {
                      if (s1 == s2) {
                        print("match");
                      } else {
                        print("not match");
                        setState(() {
                          visiblelist[pos1!] = false;
                          visiblelist[pos2!] = false;
                        });
                      }
                      t = 1;
                      if (!visiblelist.contains(false)) {
                        print("win");
                      }
                    }
                  });
                }
              });
            },
            child: Visibility(
              visible: visiblelist[index],
              replacement: Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image/images.jpg"),
                  ),
                  border: Border.all(width: 5, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  //color: Colors.red
                ),
              ),
              child: Image.asset(
                "image/${imagelist[index]}",
                width: 100,
                height: 100,
              ),
            ),
          );
        },
        itemCount: imagelist.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
      ),
    );
  }
}
