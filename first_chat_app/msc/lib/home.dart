import "package:flutter/material.dart";
import "package:like_button/like_button.dart";

import "account.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void _selector(int index){
   setState(() {
     _currentIndex = index;
   });
   if (index == 3) Navigator.push(context, MaterialPageRoute(builder: (context) => const Account()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(56, 78,125, 1),
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            "T Chats",
            style: TextStyle(
              color: Colors.amber,

            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.grey[200],
            child: ListView(
              children: const [
                DrawerHeader(
                    child: Center(
                        child: Icon(Icons.rocket, size: 64)
                    ),
                ),
                Text("Home"),
              ],
            ),
          ),
        ),
        body:  Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),
               const CircleAvatar(
                backgroundImage: AssetImage("assets/queen.jpg"),
                 radius: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LikeButton(
                    size: 40,
                    likeCountAnimationDuration: Duration(seconds: 3),
                  ),
                  IconButton(
                    onPressed: () {},
                      icon: const Icon(
                          Icons.message_rounded,
                        size: 40,
                      ),
                      color: Colors.amber,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone_enabled,
                      size: 40,
                    ),
                    color: Colors.greenAccent,
                  ),
                ],
              ),
              const Text(
                 "Bio",
               style: TextStyle(
                 fontSize: 35,
               ),
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Be You",
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        "Name: claire",
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text(
                        "Career: medicine",
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text(
                        "School: TUM",
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.pinkAccent,
        unselectedItemColor: Colors.red[100],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _selector,
        backgroundColor: const Color.fromRGBO(56, 78,125, 1),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),

        ],
      ),
      );
  }
}
