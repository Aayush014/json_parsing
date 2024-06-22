import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'data_modal.dart';
import 'data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> jsonPars() async {
    await Provider.of<DataProvider>(context, listen: false)
        .convertJsonToString();
    Provider.of<DataProvider>(context, listen: false).convertToDataModel();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider provider = Provider.of<DataProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Post Data '),
          elevation: 4,
          shadowColor: Colors.grey.withOpacity(0.5),
        ),
        body: FutureBuilder(
          future: rootBundle.loadString('Assets/data.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map? m1 = jsonDecode(snapshot.data!);
              DataModel dataModel = DataModel.fromJson(m1!);
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: Text(dataModel.postList[index].title),
                ),
                itemCount: dataModel.postList.length,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
