import 'dart:convert';

class UjianResponseModel {
  UjianResponseModel({
    required this.message,
    required this.data,
    required this.timer,
  });

  factory UjianResponseModel.fromJson(String str) =>
      UjianResponseModel.fromMap(json.decode(str));

  factory UjianResponseModel.fromMap(Map<String, dynamic> json) =>
      UjianResponseModel(
        message: json["message"],
        timer: json["timer"] ?? 0,
        data: List<Soal>.from(json["data"].map((x) => Soal.fromMap(x))),
      );

  final List<Soal> data;
  final String message;
  //timer
  final int timer;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Soal {
  Soal({
    required this.id,
    required this.pertanyaan,
    required this.kategori,
    required this.jawabanA,
    required this.jawabanB,
    required this.jawabanC,
    required this.jawabanD,
  });

  factory Soal.fromJson(String str) => Soal.fromMap(json.decode(str));

  factory Soal.fromMap(Map<String, dynamic> json) => Soal(
        id: json["id"],
        pertanyaan: json["pertanyaan"],
        kategori: json["kategori"],
        jawabanA: json["jawaban_a"],
        jawabanB: json["jawaban_b"],
        jawabanC: json["jawaban_c"],
        jawabanD: json["jawaban_d"],
      );

  final int id;
  final String jawabanA;
  final String jawabanB;
  final String jawabanC;
  final String jawabanD;
  final String kategori;
  final String pertanyaan;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "pertanyaan": pertanyaan,
        "kategori": kategori,
        "jawaban_a": jawabanA,
        "jawaban_b": jawabanB,
        "jawaban_c": jawabanC,
        "jawaban_d": jawabanD,
      };
}
