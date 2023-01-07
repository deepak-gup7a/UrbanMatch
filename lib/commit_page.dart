import 'package:flutter/material.dart';
import 'models/commits.dart';
import 'package:url_launcher/url_launcher.dart';

class CommitPage extends StatelessWidget {

  List<Commits> commits = [];
  String repoName = '';
  CommitPage({super.key, required this.commits, required this.repoName});

  _launchUrl(String url)async{
    if(! await launchUrl(Uri.parse(url))){
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    commits.sort(
      (a, b) => a.date.isAfter(b.date) ? 1 : 0,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('$repoName'),
      ),
      body: ListView.builder(
          itemCount: commits.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(commits[index].name),
              subtitle: Text(commits[index].email),
              trailing: GestureDetector(
                onTap: () {
                  _launchUrl(commits[index].url);
                },
                child: const Text(
                  "Link",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
              // subtitle: Text(DateFormat('yyyy-mm-dd').format(commits[index].date)),
            );
          }),
    );
  }
}
