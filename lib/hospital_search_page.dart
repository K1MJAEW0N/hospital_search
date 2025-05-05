import 'package:flutter/material.dart';

class HospitalSearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteHospitals; // 즐겨찾기 병원 목록 전달

  const HospitalSearchPage({Key? key, required this.favoriteHospitals}) : super(key: key);

  @override
  _HospitalSearchPageState createState() => _HospitalSearchPageState();
}

class _HospitalSearchPageState extends State<HospitalSearchPage> {
  final List<Map<String, dynamic>> hospitals = [
    {
      'name': '서울 정형외과',
      'address': '서울특별시 강남구 테헤란로 123',
      'distance': '350m',
      'distanceValue': 350,
      'rating': 4.5,
    },
    {
      'name': '강남 산재의원',
      'address': '서울특별시 강남구 삼성로 456',
      'distance': '450m',
      'distanceValue': 450,
      'rating': 4.0,
    },
    {
      'name': '미소 병원',
      'address': '서울특별시 서초구 서초대로 789',
      'distance': '520m',
      'distanceValue': 520,
      'rating': 4.8,
    },
    {
      'name': '연세 병원',
      'address': '서울특별시 송파구 올림픽로 101',
      'distance': '650m',
      'distanceValue': 650,
      'rating': 4.2,
    },
  ];

  String sortOption = 'distance'; // 기본 정렬 옵션

  void toggleFavorite(Map<String, dynamic> hospital) {
    setState(() {
      // 중복 추가 방지
      if (widget.favoriteHospitals.any((fav) => fav['name'] == hospital['name'])) {
        widget.favoriteHospitals.removeWhere((fav) => fav['name'] == hospital['name']); // 제거
      } else {
        widget.favoriteHospitals.add(hospital); // 추가
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 정렬된 병원 목록
    List<Map<String, dynamic>> sortedHospitals = List.from(hospitals);

    // 정렬
    if (sortOption == 'distance') {
      sortedHospitals.sort((a, b) => a['distanceValue'].compareTo(b['distanceValue']));
    } else if (sortOption == 'rating') {
      sortedHospitals.sort((a, b) => b['rating'].compareTo(a['rating']));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("병원 찾기", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: Colors.grey), // 정렬 필터 아이콘
            onSelected: (String value) {
              setState(() {
                sortOption = value; // 정렬 옵션 업데이트
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'distance',
                child: Text('거리순'),
              ),
              const PopupMenuItem(
                value: 'rating',
                child: Text('별점순'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: sortedHospitals.length,
          itemBuilder: (context, index) {
            final hospital = sortedHospitals[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.only(bottom: 16), // 카드 간 간격
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // 내부 여백 조정
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 병원 이름과 거리
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hospital['name'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          hospital['distance'],
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // 병원 주소
                    Text(
                      hospital['address'],
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 4),
                    // 별점과 즐겨찾기 아이콘
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${hospital['rating']}',
                              style: const TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            widget.favoriteHospitals.any((fav) => fav['name'] == hospital['name'])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.favoriteHospitals.any((fav) => fav['name'] == hospital['name'])
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            toggleFavorite(hospital); // 즐겨찾기 추가/제거
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}