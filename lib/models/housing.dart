class HousingModel {
  final String? id;
  final String description;
  final bool isPetsAllowed;
  final bool isVisible;
  final bool isVisitorsAllowed;
  final String name;
  final int pricing;
  final int contactMobile;
  final String contactEmail;
  final List<String> housePhotoUrl;

  HousingModel({
    this.id,
    required this.description,
    required this.isPetsAllowed,
    required this.isVisible,
    required this.isVisitorsAllowed,
    required this.name,
    required this.pricing,
    required this.contactEmail,
    required this.contactMobile,
    required this.housePhotoUrl,
  });

  factory HousingModel.fromMap(Map<String, dynamic> map) {
    var photoUrls = List<String>.from(map['housePhotoUrl'] ?? []);

    return HousingModel(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      isPetsAllowed: map['isPetsAllowed'] ?? false,
      isVisible: map['isVisible'] ?? false,
      isVisitorsAllowed: map['isVisitorsAllowed'] ?? false,
      name: map['name'] ?? '',
      pricing: map['pricing'] ?? 0,
      contactEmail: map['contactEmail'] ?? '',
      contactMobile: map['contactMobile'] ?? 0,
      housePhotoUrl: photoUrls,
    );
  }
}
