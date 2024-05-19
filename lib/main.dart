import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:malawisos/classes/contact.dart';
import 'package:malawisos/widgets/loading.dart';
import 'package:malawisos/widgets/searchmenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Malawi SOS',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MW SOS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _contacts = <Contact>[];

  @override
  void initState() {
    super.initState();

    rootBundle.loadString("assets/contacts.json").then((data) {
      var list = json.decode(data);
      var contacts = <Contact>[];

      // get list
      for (var item in list) {
        var name = item['name'];
        var description = item['description'];
        var image = item['image'];
        var call = item['call'];
        var industry = item['industry'];
        var email = item['email'];

        //add contacts
        contacts.add(Contact(
            name: name,
            description: description,
            image: image,
            call: call,
            industry: industry,
            email: email));
      }

      // sort contact name alphabetically
      contacts.sort((a, b) => a.name.compareTo(b.name));

      // set contacts
      setState(() => _contacts = contacts);
    });
  }

  void _onSearch() {
    showSearch(
      context: context,
      delegate: WidgetSearchMenu(_contacts.map((e) => e.name).toList()),
    );
  }

  void _onHelp() {
    showBottomSheet(
        context: context,
        builder: (context) {
          return const Column(
            children: [Text("Help")],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: _onSearch,
              tooltip: "Search",
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          // IconButton(
          //     onPressed: _onSync,
          //     tooltip: "Refresh",
          //     icon: const Icon(
          //       Icons.sync,
          //       color: Colors.white,
          //     )),
          IconButton(
              onPressed: _onHelp,
              tooltip: "Help",
              icon: const Icon(
                Icons.help,
                color: Colors.white,
              ))
        ],
      ),
      body: _contacts.isEmpty
          ? const Loading()
          : ListView(children: _contacts.map((e) => e.getCell()).toList()),
    );
  }
}
