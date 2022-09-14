import 'package:flutter/material.dart';
import 'package:hive_cache_memory/hive/hive_services.dart';
import 'package:hive_cache_memory/search_view.dart';
import 'package:hive_cache_memory/services/user_services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive/model/user_model.dart';

void main() async {
  await Hive.initFlutter("hiveDB");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Hive'),
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
  late final HTTPServices api;
  late final ICacheManager<User> cacheManager;

  List<User>? userList;

  @override
  void initState() {
    super.initState();
    api = HTTPServices();
    cacheManager = UserCacheManager(key: "userCache");
    fetchData();
  }

  fetchData() async {
    await cacheManager.init();
    if (cacheManager.getValues()?.isNotEmpty ?? false) {
      userList = cacheManager.getValues();
    } else {
      userList = await api.getData();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchView(
                            cacheManager: cacheManager,
                          ))),
              icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
        child: userList == null
            ? const CircularProgressIndicator()
            : ListView(
                children: List.generate(
                  userList!.length,
                  (index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(userList![index].name![0]),
                        ),
                        title: Text(userList?[index].name ?? ""),
                        subtitle: Text(userList?[index].email ?? ""),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward_ios)),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (userList?.isNotEmpty ?? false) {
            await cacheManager.addItems(userList!);
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
