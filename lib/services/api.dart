import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/commits.dart';
import '../models/repos.dart';
import 'package:http/http.dart' as http;

//TODO: Add your git auth token for higher rate limit
String _gitAuthToken = 'YOUR_GIT_AUTH_TOKEN';

Future<List<Repos>> getUserRepos(String userName) async {
  try {
    Response response = await http
        .get(Uri.parse('https://api.github.com/users/$userName/repos'),
        headers: {
          'Authorization': _gitAuthToken,
        }
    );
    if (kDebugMode) {
      print("-----------------getUserRepos-----------------");
      print("status code : ${response.statusCode}");
    }
    if (response.statusCode == 200) {
      dynamic res = jsonDecode(response.body);
      List<Repos> repos = [];
      for (var element in res) {
        repos.add(Repos(element['id'], element['name'], element['private'],
            element['owner']['avatar_url'], element['html_url']));
      }
      return repos;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  return [];
}

Future<List<Commits>> getRepoCommits(String userName, String repoName) async {
  try {
    Response response = await http
        .get(Uri.parse('https://api.github.com/repos/$userName/$repoName/commits'),
        headers: {
          'Authorization': _gitAuthToken,
        }
    );
    if (kDebugMode) {
      print("-----------------getRepoCommits-----------------");
      print("status code : ${response.statusCode}");
    }
    if (response.statusCode == 200) {
      dynamic res = jsonDecode(response.body);
      List<Commits> commits = [];
      for (var element in res) {
        commits.add(Commits(element['commit']['author']['name'], DateTime.parse(element['commit']['author']['date']), element['commit']['author']['email'], element['commit']['url']));
      }
      return commits;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  return [];
}
