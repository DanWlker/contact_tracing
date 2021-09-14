import 'package:json_annotation/json_annotation.dart';

part 'IndvCloseContact.g.dart';

@JsonSerializable(explicitToJson: true)
class IndvCloseContact {
  String closeContactIdentifier;
  String dateOfContact;
  String distanceOfContactMetres;
  List<String> mediumOfDetection;
  String estimatedDurationOfContact;

  IndvCloseContact(
      this.closeContactIdentifier,
      this.dateOfContact,
      this.distanceOfContactMetres,
      this.mediumOfDetection,
      this.estimatedDurationOfContact);

  factory IndvCloseContact.fromJson(Map<String, dynamic> json) => _$IndvCloseContactFromJson(json);

  Map<String, dynamic> toJson() => _$IndvCloseContactToJson(this);
}