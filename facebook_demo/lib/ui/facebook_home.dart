import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Facebook extends StatefulWidget {
  @override
  _FacebookState createState() => _FacebookState();
}

class _FacebookState extends State<Facebook> with TickerProviderStateMixin {
  Future loadPosts() async {
    http.Response posts =
        await http.get("https://jsonplaceholder.typicode.com/posts");
    var body = posts.body;
    return jsonDecode(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            backgroundColor: const Color(0xFF4167AD),
            title: new Row(
              children: <Widget>[
                IconButton(
                  icon: new Icon(Icons.camera_alt),
                  color: Theme.of(context).iconTheme.color,
                  iconSize: 39.0,
                  onPressed: () => null,
                ),
                new Expanded(
                  child: new TextField(
                    decoration: new InputDecoration(
                        hintStyle:
                            TextStyle(color: Colors.white70, fontSize: 20.0),
                        hintText: "Search",
                        icon: new Icon(
                          Icons.search,
                          color: Theme.of(context).iconTheme.color,
                        )),
                  ),
                ),
                new IconButton(
                    icon: Icon(Icons.chat_bubble), onPressed: () => null),
              ],
            ),
            bottom: TabBar(
              controller: new TabController(length: 5, vsync: this),
              tabs: <Widget>[
                new Tab(icon: Icon(Icons.web_asset)),
                new Tab(
                  icon: Icon(Icons.live_tv),
                ),
                new Tab(
                  icon: Icon(Icons.store),
                ),
                new Tab(
                  icon: Icon(Icons.notifications),
                ),
                new Tab(
                  icon: Icon(Icons.menu),
                ),
              ],
            )),
        body: new FutureBuilder(
            future: loadPosts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return new ListTile(title: new Text("Waiting"));
                default:
                  if (snapshot.hasError) //breakpoint can be set currently
                    return new Text('Error: ${snapshot.error}');
                  else
                    return new ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                      Map jsonpost = snapshot.data[index];
                      return post("${jsonpost['id']}");
                    });
              }
            }));
  }
}

Widget post(String name, {Icon icon = const Icon(Icons.person)}) =>
    new ListTile(
      isThreeLine: true,
      title: new Text(name),
      subtitle: new Column(
        children: <Widget>[
          new Text("Subtitle Text"),
          new Row(
            children: <Widget>[
              new FlatButton.icon(
                  onPressed: () => null,
                  icon: new Icon(Icons.thumb_up),
                  label: new Text("Like"))
            ],
          )
        ],
      ),
    );
