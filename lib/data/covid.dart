part of 'data.dart';

class Covid {
  String infected;
  String deaths;
  String recovered;

  Covid({this.infected, this.deaths, this.recovered});

  factory Covid.fromJson(Map<String, dynamic> json) => Covid(
        infected: json["positif"],
        recovered: json["sembuh"],
        deaths: json["meninggal"],
      );
  Map<String, dynamic> toJson() => {
        "positif": infected,
        "sembuh": recovered,
        "meninggal": deaths,
      };
}

Future<List<Covid>> connectToAPi() async {
  final response =
      await http.get(Uri.https('api.kawalcorona.com', 'indonesia'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)
        .map<Covid>((e) => Covid.fromJson(e))
        .toList() as List<Covid>;
  } else {
    throw Exception('Failed to load Data');
  }
}

List<Provinsi> provinsiFromJson(String str) =>
    List<Provinsi>.from(json.decode(str).map((x) => Provinsi.fromJson(x)));

String provinsiToJson(List<Provinsi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Provinsi {
  Provinsi({
    this.attributes,
  });

  Attributes attributes;

  factory Provinsi.fromJson(Map<String, dynamic> json) => Provinsi(
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes.toJson(),
      };
  Future<List<dynamic>> connectToAPiprovinsi() async {
    final response =
        await http.get(Uri.https('api.kawalcorona.com', 'indonesia/provinsi'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<Provinsi>((e) => Provinsi.fromJson(e))
          .toList() as List<Provinsi>;
    } else {
      throw Exception('Failed to load Data');
    }
  }
}

class Attributes {
  Attributes({
    this.fid,
    this.kodeProvi,
    this.provinsi,
    this.kasusPosi,
    this.kasusSemb,
    this.kasusMeni,
  });

  int fid;
  int kodeProvi;
  String provinsi;
  int kasusPosi;
  int kasusSemb;
  int kasusMeni;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        fid: json["FID"],
        kodeProvi: json["Kode_Provi"],
        provinsi: json["Provinsi"],
        kasusPosi: json["Kasus_Posi"],
        kasusSemb: json["Kasus_Semb"],
        kasusMeni: json["Kasus_Meni"],
      );

  Map<String, dynamic> toJson() => {
        "FID": fid,
        "Kode_Provi": kodeProvi,
        "Provinsi": provinsi,
        "Kasus_Posi": kasusPosi,
        "Kasus_Semb": kasusSemb,
        "Kasus_Meni": kasusMeni,
      };
}
