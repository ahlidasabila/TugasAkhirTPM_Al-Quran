import 'dart:convert';
import 'package:finalproject/data/surah.dart';
import 'package:finalproject/model/detail_surah_model.dart';
import 'package:http/http.dart' as http;

class BaseNetwork {
  Future<List<Surah?>> fetchSurah() async {
    var url = Uri.parse("https://quranapi.idn.sch.id/surah");
    var response = await http.get(url);

    var data = await jsonDecode(utf8.decode(response.bodyBytes))["data"];

    print('data');
    List<Surah?> items = [];
    if (data != null) {
      // print(data);
      for (var i in data) {
        if (i != null) {
          items.add(Surah.fromJson(i));
        }
      }
    }

    print(response.toString());
    return items;
  }

  Future<DetailSurahModel> fetchDetailSurah(int id) async {
    var url = Uri.parse("https://quranapi.idn.sch.id/surah/$id");
    var response = await http.get(url);

    var data = await jsonDecode(utf8.decode(response.bodyBytes));

    DetailSurahModel items = DetailSurahModel();

    if (data != null) {
      items = DetailSurahModel.fromJson(data);
    }

    print(response);
    return items;
  }
}
