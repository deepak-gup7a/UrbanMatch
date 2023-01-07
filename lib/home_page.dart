import 'package:flutter/material.dart';
import 'package:urban_match/commit_page.dart';
import 'package:urban_match/services/api.dart';
import 'component/loder.dart';
import 'models/commits.dart';
import 'models/repos.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Repos> _repos = [];
  Map<int, List<Commits>> _commits = Map();

  _fetchCommits(String userName, String repoName, int id)async{
    List<Commits> repoCommits = await getRepoCommits(userName, repoName);
    setState(() {
      _commits[id] = repoCommits;
    });

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Loader(
          context: context,
          future: getUserRepos('freeCodeCamp'),
          onDone: (List<Repos> repos) async {
            if (repos.isNotEmpty) {
              _repos = repos;
              for (Repos repo in _repos) {
                if (_commits.containsKey(repo.id) == false) {
                  await _fetchCommits('freeCodeCamp', repo.name, repo.id);
                }
              }
            }
          }).showLoader();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _repos.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(_repos[index].avatarUrl)),
            title: Text(
              _repos[index].name ?? 'N/A',
            ),
            subtitle: Text("ID: ${_repos[index].id.toString()}"),
            trailing: _commits.containsKey(_repos[index].id) == true
                ? _commits[_repos[index].id]?.length != 0
                  ?TextButton(
              style: ButtonStyle(
                  enableFeedback: true,
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: MaterialStateProperty.all(Size(90, 30)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide()))),
              child: Text(
                "Show Last commit",
                style: TextStyle(fontSize: 10.0),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CommitPage(commits: _commits[_repos[index].id]??[],repoName: _repos[index].name,)));
              },
            )
                  :const Text("Error Occurred",style: TextStyle(color: Colors.red))
                :const Text("fetching commits .. ", style: TextStyle(color: Colors.green),),
          );
        });
  }
}
