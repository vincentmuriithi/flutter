import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  int _currentIndex = 3;

  void _selector(int index){
    setState(() {
      _currentIndex = index;
    });
    if (index == 3) Navigator.pushReplacementNamed(context, "/account");
    if (index == 0) Navigator.pushReplacementNamed(context, "/");
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: ListView(
            children: const [
              Text("Account"),
            ],
          ),
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
