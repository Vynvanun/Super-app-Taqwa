import 'dart:async';//timer countdown
import 'package:flutter/material.dart';//
import 'package:carousel_slider/carousel_slider.dart' ;// caroseal slider
import 'package:http/http.dart'as http;// ambil data json
import 'dart:convert';//decode json
import 'package:geolocator/geolocator.dart';//gps
import 'package:geocoding/geocoding.dart';//konversi gps
import 'package:intl/intl.dart';//formater number
import 'package:permission_handler/permission_handler.dart';// izin handler
import 'package:shared_preferences/shared_preferences.dart';// cache lokal
import 'package:string_similarity/string_similarity.dart';//fuzzy match string  

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  
  final posterList = const <String> [
    'assets/images/ramadhan-kareem.png',
    'assets/images/idl-adh.png',
    'assets/images/idl-fitr.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            //======================================
            // [MENU SECTION]
            //======================================
            Widget_buildmenuGridSection(),
            //======================================
            // [CAROUSELSECTION]
            //======================================
            _buildCarouselSection(),
          ],
        ),
      ),
    );
  }
//===========================
// [MENU ITEM WIDGET]
//===========================
Widget _buildMenuItem(
  String iconPath, 
  String title, 
  String routName,
  ) {
  return InkWell(
    onTap: () {
      
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 35,),
          const SizedBox(height: 6,),
          Text(
            title, 
            style: TextStyle(
            fontFamily: 
            'PoppinsRegular', 
            fontSize: 13,
            ),)
        ],
      ),
    ),
  );
}
//===========================
// [MENU GRID SECTION WIDGET]
//===========================
Widget_buildmenuGridSection(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildMenuItem(
          'assets/images/ic_menu_doa.png',
          'Doa Harian',
          '/doa'
        ),
        _buildMenuItem(
          'assets/images/ic_menu_zakat.png',
          'Menu Zakat',
          '/Zakat'
        ),
        _buildMenuItem(
          'assets/images/ic_menu_video_kajian.png',
          'Video Kajian',
          '/kajian'
        ),
        _buildMenuItem(
          'assets/images/ic_menu_jadwal_sholat.png',
          'Jadwal Sholat',
          '/sholat'
        ),
      ],
    ),
  );
}
//===========================
// [CAROUSEL SECTION WIDGET]
//===========================
  Widget _buildCarouselSection(){
    return Column(
      children: [
        const SizedBox(height: 20,),
        CarouselSlider.builder(itemCount: posterList.length, 
        itemBuilder: (context, index, realIndex){
          final poster = posterList[index];
          return Container(
            margin: EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.asset(
                poster,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        }, 
        options: CarouselOptions(
          autoPlay: true,
          height: 270,
          enlargeCenterPage: true,
          viewportFraction: 0.7,
          onPageChanged: (index, reason) {
            setState(() => _currentIndex =index);
          },
          ),
        ),

        // DOR INDIKATOR CAROUSEL
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  posterList.asMap().entries.map((entry){
            return GestureDetector(
              onTap: () =>  _currentIndex.animatedToPage(entry.key),
              child: Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key ?
                  Colors.amberAccent :
                  Colors.grey[400],
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
  
}

extension on int {
  void animatedToPage(int key) {}
}
