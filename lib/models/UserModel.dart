class User {
  String userID;
  String fullName;
  String faculty;
  String department;
  String tel;
  String address;
  String person;
  String username;
  String email;
  String picture;
  String status;

  User({this.userID, this.fullName, this.faculty, this.department, this.tel, this.address, this.person, this.username, this.email, this.picture, this.status});

  User.fromJson(Map<String, dynamic> json, String data){
    userID = json["user_studentID"] == null ? null : json["user_studentID"];
    fullName = json["user_fullname"] == null ? null : json["user_fullname"];
    faculty = json["user_faculty"] == null ? null : json["user_faculty"];
    department = json["user_department"] == null ? null : json["user_department"];
    tel = json["user_tel"] == null ? null : json["user_tel"];
    address = json["user_address"] == null ? null : json["user_address"];
    person = json["user_person"] == null ? null : json["user_person"];
    username = json["user_username"] == null ? null : json["user_username"];
    email = json["user_email"] == null ? null : json["user_email"];
    picture = json["user_img"] == null ? null : json["user_img"];
    status = data == null ? null : data;
  }

}