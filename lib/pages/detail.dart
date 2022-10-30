part of 'pages.dart';

class DetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

int incramentIndexApiProvince = 0;

getdataApi() {
  parcentPositif = feedData[incramentIndexApiProvince].attributes.kasusPosi;
  parcentSembuh = feedData[incramentIndexApiProvince].attributes.kasusSemb;
  parcentMeninggal = feedData[incramentIndexApiProvince].attributes.kasusMeni;
}

String province;
List provinceApi = [
  "Daerah Khusus Ibukota Jakarta",
  "Jawa Barat",
  "Jawa Tengah",
  "Jawa Timur",
  "Kalimantan Timur",
  "Sulawesi Selatan",
  "Banten",
  "Bali",
  "Riau",
  "Daerah Istimewa Yogyakarta",
  "Sumatera Barat",
  "Kalimantan Selatan",
  "Sumatera Utara",
  "Papua",
  "Sumatera Selatan",
  "Kalimantan Tengah",
  "Sulawesi Utara",
  "Lampung",
  "Nusa Tenggara Timur",
  "Sulawesi Tengah",
  "Kalimantan Utara",
  "Sulawesi Tenggara",
  "Aceh",
  "Bangka Belitung",
  "Nusa Tenggara Barat",
  "Kepulauan Riau",
  "Papua Barat",
  "Maluku",
  "Jambi",
  "Kalimantan Barat",
  "Bengkulu",
  "Sulawesi Barat",
  "Gorontalo",
  "Maluku Utara"
];
double valueSembuh = (parcentSembuh.toDouble() /
        (parcentSembuh + parcentMeninggal + parcentPositif).toDouble()) *
    100;
double valueMeninggal = (parcentMeninggal.toDouble() /
        (parcentSembuh + parcentMeninggal + parcentPositif).toDouble()) *
    100;
double valuePositif = 100 - (valueSembuh + valueMeninggal);

class LineChartSample1State extends State<DetailPage> {
  List<PieChartSectionData> _sections = List<PieChartSectionData>();
  pie() {
    PieChartSectionData _item1 = PieChartSectionData(
        title: '${valuePositif.round()}%',
        value: valuePositif,
        color: yellowColor,
        radius: 100,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white));

    PieChartSectionData _item2 = PieChartSectionData(
        title: '${valueSembuh.round()}%',
        value: valueSembuh,
        color: greenColor,
        radius: 80,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white));

    PieChartSectionData _item3 = PieChartSectionData(
        title: '${valueMeninggal.round()}%',
        value: valueMeninggal,
        color: redColor,
        radius: 60,
        titleStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white));
    _sections = [_item1, _item2, _item3];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pie();
  }

  @override
  String dropdownValue = incramentIndexApiProvince.toString();
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: PieChart(PieChartData(
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 0,
                          centerSpaceRadius: 34,
                          startDegreeOffset: 90,
                          sections: _sections)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(width: 70),
                        Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: greenColor,
                            )),
                        Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: yellowColor,
                            )),
                        Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: redColor)),
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(width: 70),
                          Text(
                            "Sembuh",
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Positif",
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Meninggal",
                            style: blackTextFont.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ])
                  ],
                )),
          ),
          Container(
              height: MediaQuery.of(context).size.height * .40,
              padding: EdgeInsets.fromLTRB(20, 30, 20, 80),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFB7B7B7),
                    blurRadius: 30,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Update Kasus Corona",
                            style: blackTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateFormat('dd MMM yyy').format(DateTime.now()),
                            style: contentTextFont.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: DropdownButtonFormField<String>(
                          hint: Text("Select Items "),
                          isExpanded: true,
                          value: dropdownValue,
                          items: [
                            DropdownMenuItem(
                              child: Text('DKI Jakarta'),
                              value: '0',
                              onTap: () {
                                incramentIndexApiProvince = 0;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Jawa Barat'),
                              value: '1',
                              onTap: () {
                                incramentIndexApiProvince = 1;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Jawa Tengah'),
                              value: '2',
                              onTap: () {
                                incramentIndexApiProvince = 2;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Jawa Timur'),
                              value: '3',
                              onTap: () {
                                incramentIndexApiProvince = 3;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Kalimantan Timur'),
                              value: '4',
                              onTap: () {
                                incramentIndexApiProvince = 4;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Sulawesi Selatan'),
                              value: '5',
                              onTap: () {
                                incramentIndexApiProvince = 5;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Banten'),
                              value: '6',
                              onTap: () {
                                incramentIndexApiProvince = 6;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Bali'),
                              value: '7',
                              onTap: () {
                                incramentIndexApiProvince = 7;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Riau'),
                              value: '8',
                              onTap: () {
                                incramentIndexApiProvince = 8;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Yogyakarta'),
                              value: '9',
                              onTap: () {
                                incramentIndexApiProvince = 9;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Sumatera Barat'),
                              value: '10',
                              onTap: () {
                                incramentIndexApiProvince = 10;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Kalimantan Selatan'),
                              value: '11',
                              onTap: () {
                                incramentIndexApiProvince = 11;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Sumatera Utara'),
                              value: '12',
                              onTap: () {
                                incramentIndexApiProvince = 12;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Papua'),
                              value: '13',
                              onTap: () {
                                incramentIndexApiProvince = 13;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Sumatera Selatan'),
                              value: '14',
                              onTap: () {
                                incramentIndexApiProvince = 14;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Kalimantan Tengah'),
                              value: '15',
                              onTap: () {
                                incramentIndexApiProvince = 15;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Sulawesi Utara'),
                              value: '16',
                              onTap: () {
                                incramentIndexApiProvince = 16;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Lampung'),
                              value: '17',
                              onTap: () {
                                incramentIndexApiProvince = 17;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Nusa Tenggara Timur'),
                              value: '18',
                              onTap: () {
                                incramentIndexApiProvince = 18;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Sulawesi Tengah'),
                              value: '19',
                              onTap: () {
                                incramentIndexApiProvince = 19;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Kalimantan Utara'),
                              value: '20',
                              onTap: () {
                                incramentIndexApiProvince = 20;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Sulawesi Tenggara'),
                              value: '21',
                              onTap: () {
                                incramentIndexApiProvince = 21;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Aceh'),
                              value: '22',
                              onTap: () {
                                incramentIndexApiProvince = 22;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Bangka Belitung'),
                              value: '23',
                              onTap: () {
                                incramentIndexApiProvince = 23;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Nusa Tenggara Barat'),
                              value: '24',
                              onTap: () {
                                incramentIndexApiProvince = 24;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Kepulauan Riau'),
                              value: '25',
                              onTap: () {
                                incramentIndexApiProvince = 25;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Papua Barat'),
                              value: '26',
                              onTap: () {
                                incramentIndexApiProvince = 26;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Maluku'),
                              value: '27',
                              onTap: () {
                                incramentIndexApiProvince = 27;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Jambi'),
                              value: '28',
                              onTap: () {
                                incramentIndexApiProvince = 28;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Kalimantan Barat'),
                              value: '29',
                              onTap: () {
                                incramentIndexApiProvince = 29;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Bengkulu'),
                              value: '30',
                              onTap: () {
                                incramentIndexApiProvince = 30;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Sulawesi Barat'),
                              value: '31',
                              onTap: () {
                                incramentIndexApiProvince = 31;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Gorontalo'),
                              value: '32',
                              onTap: () {
                                incramentIndexApiProvince = 32;
                              },
                            ),
                            DropdownMenuItem(
                              child: Text('Maluku Utara'),
                              value: '33',
                              onTap: () {
                                incramentIndexApiProvince = 33;
                              },
                            ),
                          ],
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              getdataApi();
                              valueSembuh = (parcentSembuh.toDouble() /
                                      (parcentSembuh +
                                              parcentMeninggal +
                                              parcentPositif)
                                          .toDouble()) *
                                  100;
                              valueMeninggal = (parcentMeninggal.toDouble() /
                                      (parcentSembuh +
                                              parcentMeninggal +
                                              parcentPositif)
                                          .toDouble()) *
                                  100;
                              valuePositif =
                                  100 - (valueSembuh + valueMeninggal);
                              pie();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset("assets/icon/virus.svg")),
                          SizedBox(
                            height: 8,
                          ),
                          FutureBuilder(
                            future: Provinsi().connectToAPiprovinsi(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  NumberFormat("#,##0", "en_US").format(snapshot
                                      .data[int.parse(dropdownValue)]
                                      .attributes
                                      .kasusPosi),
                                  style: numbertTextFont.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.normal,
                                      color: yellowColor),
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                          Text(
                            "Kasus Positif",
                            style: contentTextFont.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset("assets/icon/heart.svg")),
                          SizedBox(
                            height: 8,
                          ),
                          FutureBuilder(
                            future: Provinsi().connectToAPiprovinsi(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  NumberFormat("#,##0", "en_US").format(snapshot
                                      .data[int.parse(dropdownValue)]
                                      .attributes
                                      .kasusSemb),
                                  style: numbertTextFont.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.normal,
                                      color: greenColor),
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                          Text(
                            "Sembuh",
                            style: contentTextFont.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset("assets/icon/close.svg")),
                          SizedBox(
                            height: 8,
                          ),
                          FutureBuilder(
                            future: Provinsi().connectToAPiprovinsi(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  NumberFormat("#,##0", "en_US").format(snapshot
                                      .data[int.parse(dropdownValue)]
                                      .attributes
                                      .kasusMeni),
                                  style: numbertTextFont.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.normal,
                                      color: redColor),
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                          Text(
                            "Meninggal",
                            style: contentTextFont.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
