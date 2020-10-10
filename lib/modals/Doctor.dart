import 'dart:io';

class Doctor {
  String firstName,
      lastName,
      licenceNo,
      dateOfBirth,
      degree,
      phone,
      email,
      upiid,
      accountNo,
      ifsc,
      regNo,
      address,
      experience,
      consultationFee,
      packageFee,
      followUpFee,fcmToken;
  File document;
  File profile;
  bool verified;

  Doctor(
      {this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.licenceNo,
        this.consultationFee,
        this.dateOfBirth,
        this.degree,
        this.accountNo,
        this.upiid,
        this.ifsc,
        this.regNo,
        this.verified,
        this.address,
        this.experience,
        this.document,
        this.profile,
        this.followUpFee,
        this.packageFee,this.fcmToken});
}
