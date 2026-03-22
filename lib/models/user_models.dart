class ExperienceModel {
  final String role;
  final String company;
  final String duration;
  final String? linkText;
  final String? linkUrl;
  final List<String> descriptions;

  ExperienceModel({
    required this.role,
    required this.company,
    required this.duration,
    this.linkText,
    this.linkUrl,
    required this.descriptions,
  });
}

class EducationModel {
  final String degree;
  final String institution;
  final String completedDate;

  EducationModel({
    required this.degree,
    required this.institution,
    required this.completedDate,
  });
}

class SkillModel {
  final String category;
  final List<String> skills;

  SkillModel({
    required this.category,
    required this.skills,
  });
}

class WorkModel {
  final String title;
  final String subtitle;
  final List<String> tools;
  final String description;
  final String? projectUrl;
  final String? githubUrl;
  final List<String> screenshots;

  WorkModel({
    required this.title,
    required this.subtitle,
    required this.tools,
    required this.description,
    this.projectUrl,
    this.githubUrl,
    required this.screenshots,
  });
}
