import 'package:finalproject/data/surah.dart';
import 'package:finalproject/model/detail_surah_model.dart';
import 'package:finalproject/service/base_network.dart';
import 'package:flutter/material.dart';

class DetailSurah extends StatefulWidget {
  final int id;
  final String name;
  const DetailSurah({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<DetailSurah> createState() => _DetailSurahState();
}

class _DetailSurahState extends State<DetailSurah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail ${widget.name}'),
      ),
      body: FutureBuilder(
        future: BaseNetwork().fetchDetailSurah(widget.id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: Text('No Surahs'),
              ),
            );
          } else {
            print(snapshot.data.toString());
            DetailSurahModel _detailSurah = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Text(_detailSurah.name!),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _detailSurah.ayahs!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(_detailSurah.ayahs![index].ayahText!),
                            subtitle:
                                Text(_detailSurah.ayahs![index].indoText!),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
