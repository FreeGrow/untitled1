import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class LotteryDraw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('Lotto 추첨!!!'),
        ),
        body: SlotMachine(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyan,
          onPressed: () {
            SlotMachineState.spinSlots();
          },
          child: Image.asset('assets/abd.png', color: Colors.white),
        ),
      ),
    );
  }
}

class SlotMachine extends StatefulWidget {
  static final List<_SlotState> _slots = [];
  static final List<int> _selectedNumbers = [];

  static void spinSlots() {
    _selectedNumbers.clear();
    for (var slot in _slots) {
      slot.startSpinning();
    }
    for (var i = 0; i < _slots.length; i++) {
      Future.delayed(Duration(seconds: 10 + i)).then((_) {
        _slots[i].stopSpinning();
      });
    }
  }

  @override
  SlotMachineState createState() => SlotMachineState();
}

class SlotMachineState extends State<SlotMachine> {
  static void spinSlots() {
    SlotMachine.spinSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _Slot()),
        Expanded(child: _Slot()),
        Expanded(child: _Slot()),
        Expanded(child: _Slot()),
        Expanded(child: _Slot()),
        Expanded(child: _Slot()),
      ],
    );
  }
}

class _Slot extends StatefulWidget {
  @override
  _SlotState createState() => _SlotState();
}

class _SlotState extends State<_Slot> {
  late PageController _controller;
  Timer? _timer;
  int? _selectedNumber;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    SlotMachine._slots.add(this);
  }

  void startSpinning() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _controller.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    });
  }

  void stopSpinning() {
    _timer?.cancel();
    _timer = null;
    int selectedNumber;
    do {
      selectedNumber = Random().nextInt(20) + 1;
    } while (SlotMachine._selectedNumbers.contains(selectedNumber));
    SlotMachine._selectedNumbers.add(selectedNumber);
    _selectedNumber = selectedNumber;
    _controller.jumpToPage(
      5000 + _selectedNumber! - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            '${index % 20 + 1}',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
