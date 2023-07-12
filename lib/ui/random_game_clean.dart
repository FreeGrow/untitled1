import 'dart:math';

import 'package:flutter/material.dart';

class RandomGameClean extends StatefulWidget {
  const RandomGameClean({Key? key}) : super(key: key);

  @override
  State<RandomGameClean> createState() => _RandomGameCleanState();
}

class _RandomGameCleanState extends State<RandomGameClean> {
  List<String> names = [
    '영식',
    '큰별',
    '완식',
    '성균',
    '혜원',
    '창준',
    '민지',
    '재성',
    '예나',
    '원우',
    '호영',
    '보민'
  ];

  List<String> areas = [
    '청소기',
    '설거지',
    '밀대',
    '설거지2',
    '먼지',
    '먼지2',
    '이것저것',
    '이것저것2',
    '쓸기',
    '닦기',
    '필터',
    '먼지3'
  ];

  List<String> randomData = [];
  String newName = '';
  String newArea = '';

  // void addData() {
  //   setState(() {
  //     names.add(newName);
  //     areas.add(newArea);
  //     newName = '';
  //     newArea = '';
  //   });
  // }

  void removeData(int index) {
    setState(() {
      names.removeAt(index);
      areas.removeAt(index);
    });
  }

  void generateRandomData() {
    Random random = Random();
    List<String> availableNames = List.from(names);
    List<String> availableAreas = List.from(areas);
    List<String> tempData = [];
    while (availableNames.isNotEmpty && availableAreas.isNotEmpty) {
      String name = availableNames[random.nextInt(availableNames.length)];
      String area = availableAreas[random.nextInt(availableAreas.length)];
      String data = '$name => $area';
      tempData.add(data);
      availableNames.remove(name);
      availableAreas.remove(area);
    }
    setState(() {
      randomData = tempData;
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  void addData() {
    setState(() {
      String newName = nameController.text;
      String newArea = areaController.text;

      if (newName.isNotEmpty && newArea.isNotEmpty) {
        names.add(newName);
        areas.add(newArea);
        nameController.clear();
        areaController.clear();
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Random Game Clean'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Data',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: areaController,
                  decoration: const InputDecoration(
                    labelText: 'Cleaning Area',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addData,
                  child: const Text('Add'),
                ),
                SizedBox(height: 20),
                const Text(
                  'Data List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(names.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              names[index],
                              style: const TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                areas[index],
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      generateRandomData();
                    },
                    child: Text('랜덤으로 돌리기')),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: randomData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        randomData[index],
                        style: TextStyle(fontSize: 24),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
