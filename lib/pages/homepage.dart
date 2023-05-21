import 'package:finalproject/pages/detailsurah.dart';
import 'package:finalproject/service/base_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late SharedPreferences prefs;
  late int totalQuote;
  String name = "";
  String search = "";

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final BaseNetwork baseNetwork = BaseNetwork();
    return Scaffold(
      appBar: appBarHomepage(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: TextFormField(
                onFieldSubmitted: (value) => {
                  print(value),
                  setState(() {
                    search = value.toLowerCase();
                  })
                },
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_outlined),
                  hintText: 'Search Surah',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                // initialData: [],
                future: baseNetwork.fetchSurah(),
                builder: (context, AsyncSnapshot snapshot) {
                  print(snapshot.data.toString());
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text('No Surahs'),
                    );
                  } else if (snapshot.data.length == 0) {
                    return Center(
                      child: Text('No Surahs'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(search);
                        if (search != "") {
                          print(snapshot.data![index].name
                              .toLowerCase()
                              .contains(search));
                          if (snapshot.data![index].name
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailSurah(
                                              id: snapshot.data![index].number,
                                              name: snapshot.data![index].name,
                                            )));
                              },
                              child: Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data![index].name +
                                                " (" +
                                                snapshot.data![index]
                                                    .translationId +
                                                ")"),
                                            SizedBox(height: 5),
                                            Text("Jumlah ayat : " +
                                                (snapshot.data![index]
                                                        .numberOfAyahs)
                                                    .toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        } else {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailSurah(
                                            id: snapshot.data![index].number,
                                            name: snapshot.data![index].name,
                                          )));
                            },
                            child: Card(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data![index].name +
                                              " (" +
                                              snapshot
                                                  .data![index].translationId +
                                              ")"),
                                          SizedBox(height: 5),
                                          Text("Jumlah ayat : " +
                                              (snapshot.data![index]
                                                      .numberOfAyahs)
                                                  .toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Text("");
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBarHomepage() {
    return AppBar(
      title: Text("List of Surah"),
    );
  }

  Container searchContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: TextFormField(
        onFieldSubmitted: (value) => {
          setState(() {
            name = value;
          })
        },
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search_outlined),
          hintText: 'Search Surah',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
