class LeaderboardStudent {
  final int rank;
  final String name;
  final String schoolName;
  final int points;
  final String image;

  LeaderboardStudent({
    required this.rank,
    required this.name,
    required this.schoolName,
    required this.points,
    required this.image,
  });
}

class MyReward {
  final String studentName;

  final int rank;
  final String category;
  final String academicSession;
  final String status;

  final String certificateName;
  final String certificateAsset;

  final String profileBadgeName;
  final String profileBadgeAsset;

 MyReward({
  required this.studentName,
  required this.rank,
  required this.category,
  required this.academicSession,
  required this.status,
  required this.certificateName,
  required this.certificateAsset,
  required this.profileBadgeName,
  required this.profileBadgeAsset,
});
}


//--------------------------------------------------
// TOP 20 LEADERBOARD DATA
//--------------------------------------------------

final List<LeaderboardStudent> leaderboardStudents = [

  LeaderboardStudent(
    rank: 1,
    name: "Ayush Sharma",
    schoolName: "DPS Delhi",
    points: 9500,
    image: "",
  ),

  LeaderboardStudent(
    rank: 2,
    name: "Riya Sharma",
    schoolName: "Ryan International",
    points: 9300,
    image: "",
  ),

  LeaderboardStudent(
    rank: 3,
    name: "Arjun Singh",
    schoolName: "DAV Public School",
    points: 9100,
    image: "",
  ),

  LeaderboardStudent(
    rank: 4,
    name: "Rahul Kumar",
    schoolName: "Modern Public School",
    points: 8950,
    image: "",
  ),

  LeaderboardStudent(
    rank: 5,
    name: "Priya Verma",
    schoolName: "St. Xavier's School",
    points: 8850,
    image: "",
  ),

  LeaderboardStudent(
    rank: 6,
    name: "Aditya Singh",
    schoolName: "Ryan International",
    points: 8750,
    image: "",
  ),

  LeaderboardStudent(
    rank: 7,
    name: "Neha Gupta",
    schoolName: "Delhi Public School",
    points: 8650,
    image: "",
  ),

  LeaderboardStudent(
    rank: 8,
    name: "Rohan Mehta",
    schoolName: "DAV Public School",
    points: 8550,
    image: "",
  ),

  LeaderboardStudent(
    rank: 9,
    name: "Ananya Singh",
    schoolName: "Modern School",
    points: 8450,
    image: "",
  ),

  LeaderboardStudent(
    rank: 10,
    name: "Vansh Sharma",
    schoolName: "St. Xavier's School",
    points: 8350,
    image: "",
  ),

  LeaderboardStudent(
    rank: 11,
    name: "Kavya Jain",
    schoolName: "Delhi Public School",
    points: 8250,
    image: "",
  ),

  LeaderboardStudent(
    rank: 12,
    name: "Ishaan Gupta",
    schoolName: "Modern School",
    points: 8150,
    image: "",
  ),

  LeaderboardStudent(
    rank: 13,
    name: "Mohit Verma",
    schoolName: "DAV Public School",
    points: 8050,
    image: "",
  ),

  LeaderboardStudent(
    rank: 14,
    name: "Aarav Patel",
    schoolName: "Ryan International",
    points: 7950,
    image: "",
  ),

  LeaderboardStudent(
    rank: 15,
    name: "Simran Kaur",
    schoolName: "Delhi Public School",
    points: 7850,
    image: "",
  ),

  LeaderboardStudent(
    rank: 16,
    name: "Tanvi Sharma",
    schoolName: "St. Xavier's School",
    points: 7750,
    image: "",
  ),

  LeaderboardStudent(
    rank: 17,
    name: "Krishna Nair",
    schoolName: "DAV Public School",
    points: 7650,
    image: "",
  ),

  LeaderboardStudent(
    rank: 18,
    name: "Aditi Singh",
    schoolName: "Ryan International",
    points: 7550,
    image: "",
  ),

  LeaderboardStudent(
    rank: 19,
    name: "Harsh Gupta",
    schoolName: "Modern Public School",
    points: 7450,
    image: "",
  ),

  LeaderboardStudent(
    rank: 20,
    name: "Meera Kapoor",
    schoolName: "Delhi Public School",
    points: 7350,
    image: "",
  ),

];

//--------------------------------------------------
// MY REWARD DATA
//--------------------------------------------------

final MyReward myReward = MyReward(

  studentName: "Ayush Sharma",

  rank: 2,

  category: "Category 2",

  academicSession: "2026 - 2027",

  status: "Reward Announced",

  certificateName:
      "Platinum Achievement Certificate",

  certificateAsset:
      "assets/images/camnex_rewards/platinum_certificate_template.png",

  profileBadgeName:
      "CamNex Platinum Badge",

  profileBadgeAsset:
      "assets/images/camnex_rewards/profile_platinum_badge.png",
);
