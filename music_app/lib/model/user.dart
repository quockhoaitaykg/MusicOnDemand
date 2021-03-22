class UserProfile {
  final String id;
  final String uid;
  final String name;
  final String dob;
  final String role;
  final String phone;

  UserProfile({this.id, this.uid, this.name, this.dob,
      this.role, this.phone});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['data']['id'],
      uid: json['data']['uid'],
      name: json['data']['name'],
        dob: json['data']['dob'],
        role: json['data']['role'],
        phone: json['data']['phone']
    );
  }
}