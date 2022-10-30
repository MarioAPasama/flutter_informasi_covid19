part of 'pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return ListView(
      children: <Widget>[
        //note: HEADER
        Container(
          height: 280,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    color: Color(0xFFFB7B7B7)),
              ]),
          child: WebView(
            initialUrl:
                'https://gis.dukcapil.kemendagri.go.id/arcgis/apps/MapSeries/index.html?appid=c98c430a86c64d5889106b2fe3a2909f',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 8),
          child: Text(
            "Update Kasus Corona",
            style: blackTextFont.copyWith(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 12),
          child: Text(
            DateFormat('dd MMM yyy').format(DateTime.now()),
            style: contentTextFont.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 30,
                    color: Color(0xFFFB7B7B7))
              ]),
          child: Row(
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
                    future: connectToAPi(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data[0].infected,
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
                  )
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
                    future: connectToAPi(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data[0].recovered,
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
                  )
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
                    future: connectToAPi(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data[0].deaths,
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
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
