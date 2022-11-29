import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_app/model/team.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //empty list to use
  List<Team> teams = [];

  // get teams
  Future getTeams() async {
    var response = await http.get(
      Uri.https('balldontlie.io', '/api/v1/teams'),
    );
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']) {
      final team = Team(
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city'],
        full_Name: eachTeam['full_name'],
      );
      teams.add(
        team,
      );
    }
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text('NBA TEAM'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getTeams(),
        builder: (context, snapshot) {
          //is it done loading? then show team data.
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                  ),
                  child: ListTile(
                    title: Text(teams[index].abbreviation),
                    subtitle: Text(teams[index].city),
                  ),
                );
              },
            );
          }
          // if it's still loading, show loading circle
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
