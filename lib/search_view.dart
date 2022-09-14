import 'package:flutter/material.dart';
import 'package:hive_cache_memory/hive/hive_services.dart';

import 'hive/model/user_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.cacheManager});
  final ICacheManager<User> cacheManager;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<User>? userList;

  @override
  void initState() {
    super.initState();
    userList = widget.cacheManager.getValues();
  }

  void findUser(String key) {
    userList = widget.cacheManager
        .getValues()
        ?.where((element) => element.name?.contains(key) ?? false)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextFormField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
              focusColor: Colors.black,
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            onChanged: (value) => findUser(value),
          ),
        ),
      ),
      body: userList == null
          ? const SizedBox()
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
    );
  }
}
