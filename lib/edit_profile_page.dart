import 'package:flutter/material.dart';
import 'dart:io'; // 파일 처리를 위해 필요
import 'package:image_picker/image_picker.dart'; // 이미지 선택을 위해 필요

class EditProfilePage extends StatefulWidget {
  final String name; // 현재 이름
  final Function(String) onNameChanged; // 이름 변경 콜백
  final Function(File?) onProfileImageChanged; // 프로필 이미지 변경 콜백

  const EditProfilePage({
    Key? key,
    required this.name,
    required this.onNameChanged,
    required this.onProfileImageChanged,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _gender = '남성'; // 기본 성별
  File? _profileImage; // 프로필 이미지 파일

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name); // 초기 이름 설정
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // 선택한 이미지 파일 설정
      });
      widget.onProfileImageChanged(_profileImage); // 콜백 호출
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("프로필 수정", style: TextStyle(color: Colors.blue)),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 사진 업로드
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) // 선택한 이미지 표시
                          : const AssetImage('assets/default_profile.png') as ImageProvider, // 기본 이미지
                      backgroundColor: Colors.grey[300],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.blue),
                        onPressed: _pickImage, // 이미지 선택
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 이름 입력
              const Text("이름", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "이름을 입력하세요",
                ),
              ),
              const SizedBox(height: 16),

              // 전화번호 입력
              const Text("전화번호", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "전화번호를 입력하세요",
                ),
              ),
              const SizedBox(height: 16),

              // 이메일 입력
              const Text("이메일", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "이메일을 입력하세요",
                ),
              ),
              const SizedBox(height: 16),

              // 성별 선택
              const Text("성별", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(value: '남성', child: Text("남성")),
                  DropdownMenuItem(value: '여성', child: Text("여성")),
                ],
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // 저장 버튼
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onNameChanged(_nameController.text); // 이름 변경 콜백 호출
                    widget.onProfileImageChanged(_profileImage); // 프로필 이미지 변경 콜백 호출
                    Navigator.pop(context); // 저장 후 이전 화면으로 이동
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("저장"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}