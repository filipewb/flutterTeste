// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InformationList on _InformationListBase, Store {
  late final _$infoListAtom =
      Atom(name: '_InformationListBase.infoList', context: context);

  @override
  ObservableList<Information> get infoList {
    _$infoListAtom.reportRead();
    return super.infoList;
  }

  @override
  set infoList(ObservableList<Information> value) {
    _$infoListAtom.reportWrite(value, super.infoList, () {
      super.infoList = value;
    });
  }

  late final _$_InformationListBaseActionController =
      ActionController(name: '_InformationListBase', context: context);

  @override
  void addInformation(String text) {
    final _$actionInfo = _$_InformationListBaseActionController.startAction(
        name: '_InformationListBase.addInformation');
    try {
      return super.addInformation(text);
    } finally {
      _$_InformationListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editInformation(int index, String newText) {
    final _$actionInfo = _$_InformationListBaseActionController.startAction(
        name: '_InformationListBase.editInformation');
    try {
      return super.editInformation(index, newText);
    } finally {
      _$_InformationListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteInformation(int index) {
    final _$actionInfo = _$_InformationListBaseActionController.startAction(
        name: '_InformationListBase.deleteInformation');
    try {
      return super.deleteInformation(index);
    } finally {
      _$_InformationListBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
infoList: ${infoList}
    ''';
  }
}
