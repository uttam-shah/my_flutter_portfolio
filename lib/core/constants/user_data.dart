import 'package:my_flutter_portfolio/models/user_models.dart';

class UserData {
  static const String name = "Uttam Shah";
  static const String email = "uttamshah921@gmail.com";
  static const String phone = "+91-8860406497";
  static const String github = "github.com/uttam-shah";
  static const String linkedin = "www.linkedin.com/in/uttam-shah-flutter";
  static const String twitter = "twitter.com/demo_url";
  static const String instagram = "instagram.com/demo_url";
  static const String roleTitle = "Mobile Application Developer";
  static const String summary =
      "Mobile Application Developer with 1.5+ year of experience building Android and cross-platform apps using Flutter, Kotlin, and Jetpack Compose, with backend development experience in Spring Boot, REST APIs, and Firebase, delivering production-ready applications published on Google Play Store and Apple App Store.";

  static List<SkillModel> skills = [
    SkillModel(
      category: "Programming Languages",
      skills: ["Dart", "Kotlin", "Java"],
    ),
    SkillModel(
      category: "Mobile Development",
      skills: ["Flutter", "Android SDK", "Jetpack Compose"],
    ),
    SkillModel(
      category: "Backend Development",
      skills: ["Spring Boot", "REST API Development", "JWT Authentication"],
    ),
    SkillModel(
      category: "Databases",
      skills: ["MySQL", "SQLite", "Firebase"],
    ),
    SkillModel(
      category: "Cloud & Services",
      skills: ["Firebase (FCM, Authentication)", "AWS"],
    ),
    SkillModel(
      category: "Tools",
      skills: ["Git", "Android Studio", "Postman"],
    ),
    SkillModel(
      category: "Other",
      skills: [
        "BLE Device Integration",
        "Third-Party SDK Integration",
        "AI Chat Integration"
      ],
    ),
  ];

  static List<ExperienceModel> experience = [
    ExperienceModel(
      role: "Junior Flutter Developer",
      company: "Thikedaar Dot Com",
      duration: "August 2025 – Present",
      linkText: "Play Store | App Store (Demo credentials available on request)",
      descriptions: [
        "Built and published a Flutter-based cross-platform task & project management app on Google Play Store and Apple App Store, enabling team collaboration and progress tracking.",
        "Implemented role-based access control, REST APIs integration, and modern responsive UI with smooth animations to deliver a scalable and user-friendly experience."
      ],
    ),
    ExperienceModel(
      role: "Android Developer",
      company: "Wiz Web IT Solutions",
      duration: "September 2024 – July 2025",
      descriptions: [
        "Integrated a third-party Loan SDK with secure authentication, REST APIs, Firebase Cloud Messaging (FCM), and Jetpack Compose UI to manage the complete loan application workflow in a production Android app.",
        "Developed an IoT-based Android monitoring system (Java + Kotlin) implementing BLE communication to receive device data, process it locally, and sync it to cloud servers for real-time analytics and client monitoring."
      ],
    ),
  ];

  static List<EducationModel> education = [
    EducationModel(
      degree: "Bachelor of Computer Applications (BCA)",
      institution: "IGNOU University, Delhi",
      completedDate: "Completed: Dec 2024",
    ),
    EducationModel(
      degree: "Diploma in Hardware and Networking",
      institution: "JTC, Yamuna Vihar",
      completedDate: "Completed: Aug 2022",
    ),
    EducationModel(
      degree: "XII (CBSE)",
      institution: "Govt Boys Sr. Secondary School, Sabhapur",
      completedDate: "Completed: May 2020",
    ),
    EducationModel(
      degree: "X (UP Board)",
      institution: "Saraswati Convent Public School, Nasib Vihar",
      completedDate: "Completed: May 2018",
    ),
  ];

  static List<WorkModel> works = [
    WorkModel(
      title: "Bldox",
      subtitle: "Task & Project Management App",
      tools: ["Flutter", "Kotlin", "REST APIs", "Provider"],
    ),
    WorkModel(
      title: "Smart Saloon Queue & Booking",
      subtitle: "AI Grooming & Appointment System",
      tools: ["Flutter", "Spring Boot", "PostgreSQL",],
    ),
    WorkModel(
      title: "Personal Portfolio Website",
      subtitle: "Interactive Web Resume",
      tools: ["Flutter Web", "Provider", "Responsive UI", "MVVM", "Provider", "Responsive UI", "MVVM"],
    ),
    WorkModel(
      title: "Loan Management SDK",
      subtitle: "Secure SDK Integration",
      tools: ["Kotlin", "Jetpack Compose", "Firebase", "REST APIs"],
    ),
    WorkModel(
      title: "IoT Monitoring System",
      subtitle: "Real-time Analytics App",
      tools: ["Java", "Kotlin", "BLE", "Firebase"],
    ),
  ];
}
