import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/ui/home_controller.dart';

import '../constants/assets.dart';
import '../constants/fonts.dart';
import '../constants/strings.dart';
import '../constants/text_styles.dart';
import '../widgets/responsive_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();

  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
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
  @override
  void initState() {
    super.initState();
    Get.put(controller);
    nameController = TextEditingController();
    areaController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    areaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 200),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: LayoutBuilder(builder: (context, constraints) {
          return _buildBody(context, constraints);
        }),
      ),
    );
  }

  //AppBar Methods:-------------------------------------------------------------
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: !ResponsiveWidget.isSmallScreen(context) ? _buildTitle() : null,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions:
          !ResponsiveWidget.isSmallScreen(context) ? _buildActions() : null,
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.portfoli,
            style: TextStyles.logo,
          ),
          TextSpan(
            text: Strings.o,
            style: TextStyles.logo.copyWith(
              color: Color(0xFF50AFC0),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      MaterialButton(
        child: Text(
          Strings.menu_home,
          style: TextStyles.menu_item.copyWith(
            color: Color(0xFF50AFC0),
          ),
        ),
        onPressed: () {},
      ),
      MaterialButton(
        child: Text(
          Strings.menu_about,
          style: TextStyles.menu_item,
        ),
        onPressed: () {},
      ),
      MaterialButton(
        child: Text(
          Strings.menu_contact,
          style: TextStyles.menu_item,
        ),
        onPressed: () {},
      ),
    ];
  }

  //Screen Methods:-------------------------------------------------------------
  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: ResponsiveWidget(
          largeScreen: _buildLargeScreen(context),
          mediumScreen: _buildMediumScreen(context),
          smallScreen: _buildSmallScreen(context),
        ),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
                _buildIllustration(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallScreen(BuildContext context) {
    return Center(
      child: Text('너무 줄이지마!!', style: TextStyle(fontSize: 40)),
    );
  }

  // Body Methods:--------------------------------------------------------------
  Widget _buildIllustration() {
    return Image.asset(Assets.programmer3, height: 450, fit: BoxFit.fitHeight);
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        _buildAboutMe(context),
        SizedBox(height: 4.0),
        _buildHeadline(context),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 24.0),
        _buildSummary(),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 48.0),
        ResponsiveWidget.isSmallScreen(context)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildEducation(),
                  SizedBox(height: 24.0),
                ],
              )
            : _buildSkillsAndEducation(context)
      ],
    );
  }

  Widget _buildAboutMe(BuildContext context) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.about,
            style: TextStyles.heading.copyWith(
              fontFamily: Fonts.nexa_light,
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
          TextSpan(
            text: Strings.me,
            style: TextStyles.heading.copyWith(
              color: Color(0xFF50AFC0),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          controller.randomScreenChange.value =
              !controller.randomScreenChange.value;
          generateRandomData();
        },
        child: Text(
          controller.randomScreenChange.value
              ? Strings.retry
              : Strings.headline,
          style: TextStyles.sub_heading,
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '이름',
            ),
            onSubmitted: (value) {
              if (names.length >= 12) {
                nameController.clear();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('안내'),
                        content: Text('참내!!'),
                        actions: [
                          TextButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      );
                    });
              } else {
                names.add(value);
                nameController.clear();
              }
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 300,
          child: TextField(
            controller: areaController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '청소구역',
            ),
            onSubmitted: (value) {
              areas.add(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsAndEducation(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _buildEducation(),
        ),
        SizedBox(width: 40.0),
      ],
    );
  }

  Widget _buildSkillChip(BuildContext context, String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyles.chip.copyWith(
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 11.0,
        ),
      ),
    );
  }

  Widget _buildEducation() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            controller.randomScreenChange.value
                ? _buildRandomScreenWidget()
                : _buildEducationContainerHeading(),
            SizedBox(height: 8.0),
          ],
        ));
  }

  Widget _buildRandomScreenWidget() {
    return Container(
      height: 300,
      child: ListView.builder(
          itemCount: randomData.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(randomData[index]);
          }),
    );
  }

  void removeNameData(int index) {
    setState(() {
      names.removeAt(index);
    });
  }

  void removeAreaData(int index) {
    setState(() {
      areas.removeAt(index);
    });
  }

  Widget _buildEducationContainerHeading() {
    return Container(
      width: 500,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 300,
              child: ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          removeNameData(index);
                        },
                        child: Text('${index + 1}  ${names[index]}'));
                  }),
            ),
          ),
          Expanded(
            child: Container(
              height: 300,
              child: ListView.builder(
                  itemCount: areas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          removeAreaData(index);
                        },
                        child: Text('${index + 1}  ${areas[index]}'));
                  }),
            ),
          ),
        ],
      ),
    );
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
}
