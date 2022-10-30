part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

int parcentPositif, parcentSembuh, parcentMeninggal;
List<dynamic> feedData;
getDataAPi() async {
  feedData = await Provinsi().connectToAPiprovinsi();
  parcentPositif = feedData[incramentIndexApiProvince].attributes.kasusPosi;
  parcentSembuh = feedData[incramentIndexApiProvince].attributes.kasusSemb;
  parcentMeninggal = feedData[incramentIndexApiProvince].attributes.kasusMeni;
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List listOfText = [
    HomePage(),
    DetailPage(),
    InfoPage(),
  ];

  getLocation() async {
    province = await LocationServices().getCoordinate();
    while (province != provinceApi[incramentIndexApiProvince]) {
      incramentIndexApiProvince++;
    }
  }

  @override
  initState() {
    super.initState();
    getLocation();
    getDataAPi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          SafeArea(
              child: Container(
            color: Color(0xFFF7F9FA),
          )),
          PageView(
            children: <Widget>[listOfText[currentIndex]],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.coronavirus),
            title: Text('Kasus'),
            activeColor: mainColor,
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.assessment_rounded,
            ),
            title: Text('Detail'),
            activeColor: mainColor,
            inactiveColor: Colors.grey,
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.info_rounded,
            ),
            title: Text('Info'),
            activeColor: mainColor,
            inactiveColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
