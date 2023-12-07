import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen_view.dart';

class Information {
  String text;

  Information(this.text);
}

class InformationList extends ChangeNotifier {
  final List<Information> _infoList = [];

  List<Information> get infoList => _infoList;

  void addInformation(String text) {
    _infoList.add(Information(text));
    notifyListeners();
  }

  void editInformation(int index, String newText) {
    _infoList[index].text = newText;
    notifyListeners();
  }

  void deleteInformation(int index) {
    _infoList.removeAt(index);
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => InformationList(),
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreenView(),
      ),
    );
  }
}
