import 'package:flutter/material.dart';

class ExpandOverPage extends StatefulWidget {
  @override
  State<ExpandOverPage> createState() => _ExpandOverPageState();
}

class _ExpandOverPageState extends State<ExpandOverPage> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // 👇 Main Page Content
          Column(
            children: [
              SizedBox(height: 120),
              Center(child: Text("Main Content Here")),
            ],
          ),

          // 👇 Button
          Positioned(
            top: 50,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
              child: Text("Open"),
            ),
          ),

          // 👇 Expanding Container (OVERLAY)
          if (isOpen)
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Expanded Content"),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isOpen = false;
                        });
                      },
                      child: Text("Close"),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}