//model for housing
class HousingModel {
  final String? id;
  final String description;
  final bool isPetsAllowed;
  final bool isVisible;
  final bool isVisitorsAllowed;
  final String name;
  final int pricing;
  final List<ContactModel> contacts;
  final List<RoomModel> rooms;

  HousingModel({
    this.id,
    required this.description,
    required this.isPetsAllowed,
    required this.isVisible,
    required this.isVisitorsAllowed,
    required this.name,
    required this.pricing,
    required this.rooms,
    required this.contacts,
  });
}

//model for Rooms
// for room information
class RoomModel {
  final String roomId;
  final String roomType;
  final int maxCapacity;
  final int pricing;
  final bool isVacant;
  final bool hasOwnBathroom;
  final String? roomPhotoUrl;

  RoomModel({
    required this.roomId,
    required this.roomType,
    required this.maxCapacity,
    required this.pricing,
    required this.isVacant,
    required this.hasOwnBathroom,
    this.roomPhotoUrl,
  });

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'],
      roomType: map['roomType'],
      maxCapacity: map['maxCapacity'],
      pricing: map['pricing'],
      isVacant: map['isVacant'],
      hasOwnBathroom: map['hasOwnBathroom'],
      roomPhotoUrl: map['roomPhotoUrl'],
    );
  }
}

//models for contact details
// this is for the housing information
class ContactModel {
  final String email;
  final int mobile;

  ContactModel({
    required this.email,
    required this.mobile,
  });

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      email: map['email'],
      mobile: map['mobile'],
    );
  }
}
