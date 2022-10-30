part of 'pages.dart';

class InfoPage extends StatefulWidget {
  InfoPage() : super();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  InfoPageState createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> {
  static const String FEED_URL = 'https://covid19.go.id/feed/berita';
  RssFeed _feed;
  String _title;
  static const String loadingFeedMsg = 'Loading Feed...';
  static const String feedLoadErrorMsg = 'Error Loading Feed.';
  static const String feedOpenErrorMsg = 'Error Open Feed.';
  static const String placeholderImg = 'assets/images/no_img.png';

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: false);
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SymptomCard(
                          image: "assets/images/Demam.png", title: "Demam"),
                      SymptomCard(
                          image: "assets/images/Batuk.png",
                          title: "Batuk Kering"),
                      SymptomCard(
                          image: "assets/images/Kelelahan.png",
                          title: "Kelelahan")
                    ],
                  ),
                  SizedBox(height: 20),
                  isFeedEmpty()
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 180.0,
                            aspectRatio: 16 / 9,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                          itemCount: _feed.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = _feed.items[index];
                            return InkWell(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                          color: Colors.grey)
                                    ]),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 135,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  item.enclosure.url),
                                              fit: BoxFit.cover),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 4),
                                                blurRadius: 8,
                                                color: Color(0xFFFB7B7B7)),
                                          ]),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 4),
                                      width: MediaQuery.of(context).size.width -
                                          262,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            item.title.toString(),
                                            style: blackTextFont.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          // Text(item.pubDate ?? "".toString(),
                                          //     maxLines: 1,
                                          //     style: contentTextFont.copyWith(
                                          //         fontSize: 10,
                                          //         fontWeight:
                                          //             FontWeight.normal)),

                                          Container(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              (item.description).replaceAll(
                                                  RegExp(r"<[^>]*>"), ''),
                                              maxLines: 4,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => openFeed(item.link),
                            );
                          },
                        ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 8),
                              blurRadius: 24,
                              color: Colors.grey)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        Text("Pencegahan",
                            style: blackTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        PreventCard(
                          image: "assets/images/undraw_wash_hands.svg",
                          content:
                              "Cuci tangan Anda secara rutin setelah melakukan beberapa aktivitas. Gunakan sabun dan air, atau cairan pembersih tangan berbahan alkohol minimal 60 persen .",
                        ),
                        SizedBox(height: 20),
                        PreventCard(
                          image: "assets/images/undraw_use_a_mask.svg",
                          content:
                              "Kenakan masker jika pembatasan fisik tidak dimungkinkan. ",
                        ),
                        SizedBox(height: 20),
                        PreventCard(
                          image: "assets/images/undraw_social_distancing.svg",
                          content:
                              "Selalu jaga jarak aman dengan orang yang batuk atau bersin",
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 8),
                              blurRadius: 24,
                              color: Colors.grey)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        Text("Gejala Yang Tidak Umum",
                            style: blackTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('gejalatidakumum')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot documentSnapshot =
                                          snapshot.data.docs[index];
                                      return Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                                  documentSnapshot["gejala"],
                                                  style:
                                                      contentTextFont.copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.black))),
                                          SizedBox(
                                            height: 25,
                                          )
                                        ],
                                      );
                                    });
                              } else {
                                return Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 8),
                              blurRadius: 24,
                              color: Colors.grey)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        Text("Perawatan",
                            style: blackTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        Text(
                            "Setelah terpapar ke orang yang terinfeksi COVID-19, lakukan tindakan berikut:",
                            style: contentTextFont.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('perawatan')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot documentSnapshot =
                                          snapshot.data.docs[index];
                                      return Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                                  documentSnapshot[
                                                      "perawatan "],
                                                  style:
                                                      contentTextFont.copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Colors.black))),
                                          SizedBox(
                                            height: 50,
                                          )
                                        ],
                                      );
                                    });
                              } else {
                                return Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String content;
  const PreventCard({
    Key key,
    this.image,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          image,
          width: 100,
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 10),
          width: MediaQuery.of(context).size.width - 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(content,
                  style: contentTextFont.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ))
            ],
          ),
        )
      ],
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(offset: Offset(0, 3), blurRadius: 6, color: Colors.grey)
          ]),
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 90,
          ),
          Text(
            title,
            style: blackTextFont.copyWith(
                fontSize: 14, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
