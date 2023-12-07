import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/privacy_policy_link.dart';
import 'home_screen.dart';

class HomeScreenView extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  HomeScreenView({Key? key});

  @override
  Widget build(BuildContext context) {
    var informationList = Provider.of<InformationList>(context);

    _loadSavedData(informationList);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Digite as informações',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitInformation(
                    context,
                    informationList,
                    _textController.text.trim(),
                  );
                },
                child: const Text('Salvar'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    itemCount: informationList.infoList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(informationList.infoList[index].text),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditDialog(
                                      context, informationList, index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _confirmDelete(
                                      context, informationList, index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
          const Positioned(
            top: 0,
            bottom: 40,
            left: 0,
            right: 0,
            child: PrivacyPolicyLink(),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, InformationList informationList, int index) {
    TextEditingController editTextController =
        TextEditingController(text: informationList.infoList[index].text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Informação'),
          content: TextField(
            controller: editTextController,
            decoration: const InputDecoration(
              labelText: 'Editar informação',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                informationList.editInformation(index, editTextController.text);
                _saveData(informationList);
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadSavedData(InformationList informationList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedData = prefs.getStringList('informationList');

    if (savedData != null) {
      informationList.infoList.clear();
      for (String info in savedData) {
        informationList.addInformation(info);
      }
    }
  }

  Future<void> _saveData(InformationList informationList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataToSave =
        informationList.infoList.map((info) => info.text).toList();
    await prefs.setStringList('informationList', dataToSave);
  }

  void _submitInformation(
      BuildContext context, InformationList informationList, String value) {
    if (value.trim().isNotEmpty) {
      informationList.addInformation(value);
      _saveData(informationList);
      _textController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira alguma informação.'),
        ),
      );
    }
  }

  void _confirmDelete(
      BuildContext context, InformationList informationList, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content:
              const Text('Tem certeza de que deseja excluir esta informação?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                informationList.deleteInformation(index);
                _saveData(informationList);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}
