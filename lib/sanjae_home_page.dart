import 'package:flutter/material.dart';
import 'my_page.dart'; // 마이페이지 import
import 'pharmacy_search_page.dart'; // 약국 찾기 페이지 import
import 'hospital_search_page.dart'; // 병원 찾기 페이지 import

class SanjaeHomePage extends StatefulWidget {
  @override
  _SanjaeHomePageState createState() => _SanjaeHomePageState();
}

class _SanjaeHomePageState extends State<SanjaeHomePage> {
  final List<Map<String, dynamic>> favoritePharmacies = []; // 즐겨찾기 약국 목록
  final List<Map<String, dynamic>> favoriteHospitals = []; // 즐겨찾기 병원 목록

  final List<Map<String, String>> newsSlides = [
    {
      'title': '산재보험 청구 방법 안내',
      'desc': '산업 재해 발생 시 보험 청구를 위한 단계별 안내와 필요 서류를 확인하세요.',
    },
    {
      'title': '산재 후 재활 치료 가이드',
      'desc': '효과적인 재활 치료를 통해 빠른 회복과 직장 복귀를 도와드립니다.',
    },
    {
      'title': '산재 관련 법률 상담 안내',
      'desc': '산재 보상에 관한 법률 문제, 전문가의 도움을 받아보세요.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("산재 병원 찾기", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyPage(
                    favoritePharmacies: favoritePharmacies, // 약국 즐겨찾기 전달
                    favoriteHospitals: favoriteHospitals, // 병원 즐겨찾기 전달
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 뉴스 슬라이더
          SizedBox(
            height: 220,
            child: PageView.builder(
              itemCount: newsSlides.length,
              controller: PageController(viewportFraction: 0.9),
              itemBuilder: (context, index) {
                final item = newsSlides[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          color: Colors.black, // 검은색 배경
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(item['desc']!, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // 기능 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FeatureButton(
                icon: Icons.local_hospital,
                label: '병원 찾기',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HospitalSearchPage(
                        favoriteHospitals: favoriteHospitals, // 병원 즐겨찾기 전달
                      ),
                    ),
                  );
                },
              ),
              FeatureButton(
                icon: Icons.medical_services,
                label: '약국 찾기',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PharmacySearchPage(
                        favoritePharmacies: favoritePharmacies, // 약국 즐겨찾기 전달
                      ),
                    ),
                  );
                },
              ),
              FeatureButton(icon: Icons.accessibility_new, label: '재활 기관'),
            ],
          ),

          const SizedBox(height: 24),

          // 임시 마이페이지 버튼
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPage(
                      favoritePharmacies: favoritePharmacies, // 약국 즐겨찾기 전달
                      favoriteHospitals: favoriteHospitals, // 병원 즐겨찾기 전달
                    ),
                  ),
                );
              },
              child: const Text("마이페이지로 이동"),
            ),
          ),

          const SizedBox(height: 24),

          // 커뮤니티 예시
          Text("인기 커뮤니티", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          CommunityPost(
            user: "김지훈",
            time: "2시간 전",
            title: "산재 치료 후 직장 복귀 경험 공유합니다",
            content: "3개월간의 재활 치료를 마치고 복귀했는데, 회사의 배려로 잘 적응하고 있어요.",
            likes: 28,
            comments: 12,
          ),
          const SizedBox(height: 12),
          CommunityPost(
            user: "이미영",
            time: "4시간 전",
            title: "산재 보험 청구 과정 후기",
            content: "노무사님의 도움으로 순조롭게 진행했어요. 도움이 되시길 바랍니다.",
            likes: 45,
            comments: 23,
          ),

          const SizedBox(height: 24),
          Text("주변 병원", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          HospitalGrid(
            items: [
              {'name': '서울 정형외과', 'distance': '350m'},
              {'name': '강남 산재의원', 'distance': '450m'},
            ],
          ),

          const SizedBox(height: 24),
          Text("주변 재활 기관", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          HospitalGrid(
            items: [
              {'name': '서울 재활센터', 'distance': '400m'},
              {'name': '강남 재활의학과', 'distance': '550m'},
            ],
          ),
        ],
      ),
    );
  }
}

// 기능 버튼 위젯
class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const FeatureButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// 커뮤니티 카드
class CommunityPost extends StatelessWidget {
  final String user;
  final String time;
  final String title;
  final String content;
  final int likes;
  final int comments;

  const CommunityPost({
    required this.user,
    required this.time,
    required this.title,
    required this.content,
    required this.likes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(user, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(time, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ]),
            SizedBox(height: 6),
            Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 6),
            Text(content, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.thumb_up_off_alt, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text('$likes'),
                SizedBox(width: 16),
                Icon(Icons.comment, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text('$comments'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 병원/재활센터 그리드
class HospitalGrid extends StatelessWidget {
  final List<Map<String, String>> items;

  const HospitalGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.8,
      children: items.map((item) {
        return Card(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.black, // 검은색 배경
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(item['name']!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Text(item['distance']!, style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}