import 'package:flutter/material.dart';
import 'dart:io'; // 파일 처리를 위해 필요
import 'edit_profile_page.dart'; // 프로필 수정 페이지 import

class MyPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoritePharmacies; // 즐겨찾기 약국 목록 전달
  final List<Map<String, dynamic>> favoriteHospitals; // 즐겨찾기 병원 목록 전달

  const MyPage({
    Key? key,
    required this.favoritePharmacies,
    required this.favoriteHospitals,
  }) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String selectedCategory = '병원'; // 기본 선택된 카테고리
  bool isNotificationEnabled = true; // 알림 설정 상태
  String userName = "박민수"; // 기본 사용자 이름
  File? _profileImage; // 프로필 이미지 파일

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("마이페이지", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context); // 뒤로가기
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 정보 카드
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // 프로필 사진
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) // 선택한 이미지 표시
                          : const AssetImage('assets/default_profile.png') as ImageProvider, // 기본 이미지
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const Text("산재 치료 중 (3개월째)", style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                  name: userName,
                                  onNameChanged: (newName) {
                                    setState(() {
                                      userName = newName; // 이름 업데이트
                                    });
                                  },
                                  onProfileImageChanged: (newImage) {
                                    setState(() {
                                      _profileImage = newImage; // 프로필 이미지 업데이트
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("프로필 수정", style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 즐겨찾기 카테고리 버튼
            const Text("즐겨찾기 목록", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryButton("병원", selectedCategory == '병원'),
                _buildCategoryButton("약국", selectedCategory == '약국'),
                _buildCategoryButton("재활기관", selectedCategory == '재활기관'),
              ],
            ),
            const SizedBox(height: 16),

            // 선택된 카테고리의 즐겨찾기 목록 표시
            if (selectedCategory == '병원') ...[
              const SizedBox(height: 8),
              if (widget.favoriteHospitals.isEmpty)
                const Center(
                  child: Text(
                    "즐겨찾기된 병원이 없습니다.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                )
              else
                ...widget.favoriteHospitals.map((hospital) {
                  return ListTile(
                    leading: const Icon(Icons.local_hospital, color: Colors.blue),
                    title: Text(hospital['name']),
                    subtitle: Text(hospital['address']),
                    trailing: const Icon(Icons.favorite, color: Colors.red),
                  );
                }).toList(),
            ] else if (selectedCategory == '약국') ...[
              const SizedBox(height: 8),
              if (widget.favoritePharmacies.isEmpty)
                const Center(
                  child: Text(
                    "즐겨찾기된 약국이 없습니다.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                )
              else
                ...widget.favoritePharmacies.map((pharmacy) {
                  return ListTile(
                    leading: const Icon(Icons.local_pharmacy, color: Colors.green),
                    title: Text(pharmacy['name']),
                    subtitle: Text(pharmacy['address']),
                    trailing: const Icon(Icons.favorite, color: Colors.red),
                  );
                }).toList(),
            ] else if (selectedCategory == '재활기관') ...[
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.accessibility_new, color: Colors.orange),
                title: const Text("서울 재활센터"),
                subtitle: const Text("서울시 강남구 테헤란로 789"),
                trailing: const Icon(Icons.favorite, color: Colors.blue),
              ),
              ListTile(
                leading: const Icon(Icons.accessibility_new, color: Colors.orange),
                title: const Text("강남 재활의학과"),
                subtitle: const Text("서울시 강남구 삼성로 101"),
                trailing: const Icon(Icons.favorite_border, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 24),

            // 알림 설정
            const Divider(),
            const Text(
              "알림 설정",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "알림 받기",
                  style: TextStyle(fontSize: 14),
                ),
                Switch(
                  value: isNotificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      isNotificationEnabled = value; // 알림 설정 상태 업데이트
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String label, bool isSelected) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = label;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label),
    );
  }
}