import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/controller.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    final providerData = Provider.of<UserProvider>(context, listen: false);
    providerData.getMyData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
        body: userProvider.isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : DefaultTabController(
          length: userProvider.userList.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text('User Details'),centerTitle: true,
              bottom: TabBar(
                isScrollable: true,
                tabs: userProvider.userList
                    .map((user) =>
                    Tab(text: '${user.firstName} ${user.lastName}'))
                    .toList(),
              ),
            ),
            body: TabBarView(
              children: userProvider.userList
                  .map((user) => UserDetails(user, userProvider))
                  .toList(),
            ),
          ),
        ),
      );
    });
  }
}

class UserDetails extends StatelessWidget {
  final User user;
  final UserProvider userProvider;

  UserDetails(this.user, this.userProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Open a dialog or navigate to an edit screen
                    _showEditDialog(context, userProvider, user);
                  },
                  child: Text('Edit'),
                ),SizedBox(width: 5,),
                ElevatedButton(
                  onPressed: () {
                    // Remove the user
                    userProvider.removeUser(user.id);
                  },
                  child: Text('Remove'),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Center(
              child: CircleAvatar(radius:70,
                  child: Image.network(user.avatar, height: 90, width: 90
                  )),
            ),
            SizedBox(height: 16),
            Text(
              'First Name: ${user.firstName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            Text(
              'Last Name: ${user.lastName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8),
            Text('Email: ${user.email}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
  void _showEditDialog(
      BuildContext context, UserProvider userProvider, User user) {
    TextEditingController firstNameController =
    TextEditingController(text: user.firstName);
    TextEditingController lastNameController =
    TextEditingController(text: user.lastName);
    TextEditingController emailController =
    TextEditingController(text: user.email);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update user information
                userProvider.editUserInfo(
                  user.id,
                  firstNameController.text,
                  lastNameController.text,
                  emailController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}




