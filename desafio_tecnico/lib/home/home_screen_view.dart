import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/privacy_policy_link.dart';
import 'home_screen.dart';

class HomeScreenView extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    var informationList = Provider.of<InformationList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Digite as informações',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  informationList.addInformation(_textController.text);
                  _textController.clear();
                },
                child: const Text('Salvar'),
              ),
              Expanded(
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
                                informationList.deleteInformation(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
          const Positioned(
            top: 10,
            bottom: 30,
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
}