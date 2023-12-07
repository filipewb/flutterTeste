import 'package:mobx/mobx.dart';

part 'information_list.g.dart';

class InformationList = _InformationListBase with _$InformationList;

abstract class _InformationListBase with Store {
  @observable
  ObservableList<Information> infoList = ObservableList<Information>();

  @action
  void addInformation(String text) {
    infoList.add(Information(text));
  }

  @action
  void editInformation(int index, String newText) {
    infoList[index] = Information(newText);
  }

  @action
  void deleteInformation(int index) {
    infoList.removeAt(index);
  }
}

class Information {
  String text;

  Information(this.text);
}
