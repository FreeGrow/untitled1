import 'package:get/get.dart';

class HomeController extends GetxController {
  RxDouble h = 200.0.obs;
  RxBool randomScreenChange = false.obs;
  Rx<List<String>> names = Rx<List<String>>([]);
  Rx<List<String>> areas = Rx<List<String>>([]);
  Rx<List<String>> randomData = Rx<List<String>>([]);
}
