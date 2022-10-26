import 'package:bloc_app/user_bloc.dart';
import 'package:flutter/material.dart';

import 'User.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  UserBLoC userBLoC = new UserBLoC();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Dynamic data"),
        actions: [
          Chip(
            label: StreamBuilder<int>(
                stream: userBLoC.userCounter,
                builder: (context, snapshot) {
                  return Text(
                    (snapshot.data ?? 0).toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  );
                }),
            backgroundColor: Colors.red,
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
          )
        ],
      ),
      body: StreamBuilder(
          stream: userBLoC.usersList,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasError)
                  return Text('There was an error : ${snapshot.error}');
                List<User> users = snapshot.data!;

                return ListView.separated(
                  itemCount: users?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    User _user = users[index];
                    return ListTile(
                      title: Text(_user.userId.toString()),
                      subtitle: Text(_user.title),
                      leading: Text(_user.body),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                );
            }
          }),
    );
  }
}
