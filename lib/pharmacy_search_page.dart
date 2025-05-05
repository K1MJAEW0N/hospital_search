import 'package:flutter/material.dart';

class PharmacySearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoritePharmacies; // 즐겨찾기 약국 목록 전달

  const PharmacySearchPage({Key? key, required this.favoritePharmacies}) : super(key: key);

  @override
  _PharmacySearchPageState createState() => _PharmacySearchPageState();
}

class _PharmacySearchPageState extends State<PharmacySearchPage> {
  final List<Map<String, dynamic>> pharmacies = [
    {
      'name': '서울 중앙 약국',
      'address': '서울특별시 강남구 테헤란로 123',
      'distance': '350m',
      'distanceValue': 350,
      'rating': 4.5,
    },
    {
      'name': '강남 약국',
      'address': '서울특별시 강남구 삼성로 456',
      'distance': '450m',
      'distanceValue': 450,
      'rating': 4.0,
    },
    {
      'name': '미소 약국',
      'address': '서울특별시 서초구 서초대로 789',
      'distance': '520m',
      'distanceValue': 520,
      'rating': 4.8,
    },
    {
      'name': '연세 약국',
      'address': '서울특별시 송파구 올림픽로 101',
      'distance': '650m',
      'distanceValue': 650,
      'rating': 4.2,
    },
    {
      'name': '한마음 약국',
      'address': '서울특별시 강동구 천호대로 202',
      'distance': '700m',
      'distanceValue': 700,
      'rating': 4.7,
    },
    {
      'name': '서울대 약국',
      'address': '서울특별시 종로구 대학로 123',
      'distance': '800m',
      'distanceValue': 800,
      'rating': 4.3,
    },
    {
      'name': '강북 약국',
      'address': '서울특별시 강북구 도봉로 456',
      'distance': '900m',
      'distanceValue': 900,
      'rating': 4.1,
    },
    {
      'name': '피부과 전문 약국',
      'address': '서울특별시 강남구 논현로 789',
      'distance': '1.2km',
      'distanceValue': 1200,
      'rating': 4.6,
    },
  ];

  String sortOption = 'distance'; // 기본 정렬 옵션

  void toggleFavorite(Map<String, dynamic> pharmacy) {
    setState(() {
      // 중복 추가 방지
      if (widget.favoritePharmacies.any((fav) => fav['name'] == pharmacy['name'])) {
        widget.favoritePharmacies.removeWhere((fav) => fav['name'] == pharmacy['name']); // 제거
      } else {
        widget.favoritePharmacies.add(pharmacy); // 추가
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 정렬된 약국 목록
    List<Map<String, dynamic>> sortedPharmacies = List.from(pharmacies);

    // 정렬
    if (sortOption == 'distance') {
      sortedPharmacies.sort((a, b) => a['distanceValue'].compareTo(b['distanceValue']));
    } else if (sortOption == 'rating') {
      sortedPharmacies.sort((a, b) => b['rating'].compareTo(a['rating']));
    } else if (sortOption == 'recommendation') {
      // 추천순 정렬 (예: 별점 높은 순)
      sortedPharmacies.sort((a, b) => b['rating'].compareTo(a['rating']));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("약국 찾기", style: TextStyle(color: Colors.blue)),
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
                value: 'recommendation',
                child: Text('추천순'),
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
          itemCount: sortedPharmacies.length,
          // itemExtent 제거: 카드 높이를 동적으로 조정
          itemBuilder: (context, index) {
            final pharmacy = sortedPharmacies[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.only(bottom: 16), // 카드 간 간격
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // 내부 여백 조정
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 약국 이름과 거리
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pharmacy['name'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          pharmacy['distance'],
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // 약국 주소
                    Text(
                      pharmacy['address'],
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
                              '${pharmacy['rating']}',
                              style: const TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            widget.favoritePharmacies.any((fav) => fav['name'] == pharmacy['name'])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.favoritePharmacies.any((fav) => fav['name'] == pharmacy['name'])
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            toggleFavorite(pharmacy); // 즐겨찾기 추가/제거
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