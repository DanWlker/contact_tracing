class IndvCloseContact {
  String? closeContactIdentifier;
  String? dateOfContact;
  String? distanceOfContactMetres;
  List<String>? mediumOfDetection;
  String? estimatedDurationOfContact;

  IndvCloseContact(
      {this.closeContactIdentifier,
        this.dateOfContact,
        this.distanceOfContactMetres,
        this.mediumOfDetection,
        this.estimatedDurationOfContact});

  IndvCloseContact.fromJson(Map<String, dynamic> json) {
    closeContactIdentifier = json['closeContactIdentifier'];
    dateOfContact = json['dateOfContact'];
    distanceOfContactMetres = json['distanceOfContactMetres'];
    mediumOfDetection = json['mediumOfDetection'].cast<String>();
    estimatedDurationOfContact = json['estimatedDurationOfContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['closeContactIdentifier'] = this.closeContactIdentifier;
    data['dateOfContact'] = this.dateOfContact;
    data['distanceOfContactMetres'] = this.distanceOfContactMetres;
    data['mediumOfDetection'] = this.mediumOfDetection;
    data['estimatedDurationOfContact'] = this.estimatedDurationOfContact;
    return data;
  }
}