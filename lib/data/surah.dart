class Surah {
  String translationId;
  String translationEn;
  String asma;
  int numberOfAyahs;
  String name;
  int number;
  String typeId;
  String typeEn;
  int orderNumber;

  Surah({
    required this.translationId,
    required this.translationEn,
    required this.asma,
    required this.numberOfAyahs,
    required this.name,
    required this.number,
    required this.typeId,
    required this.typeEn,
    required this.orderNumber,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        translationId: json["translationId"],
        translationEn: json["translationEn"],
        asma: json["asma"],
        numberOfAyahs: json["numberOfAyahs"],
        name: json["name"],
        number: json["number"],
        typeId: json["typeId"],
        typeEn: json["typeEn"],
        orderNumber: json["orderNumber"],
      );

  Map<String, dynamic> toJson() => {
        "translationId": translationId,
        "translationEn": translationEn,
        "asma": asma,
        "numberOfAyahs": numberOfAyahs,
        "name": name,
        "number": number,
        "typeId": typeId,
        "typeEn": typeEn,
        "orderNumber": orderNumber,
      };
}
