class Patient {
  String firstName,
      lastName,
      phone,
      email,
      height,
      weight,
      age,
      covidStatus,
      gender,Notes,date,Doctor,File_Name,fcmToken,link;
  DateTime dob;

  Patient(
      {this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.height,
        this.weight,
        this.age,
        this.dob,
        this.gender,
        this.covidStatus,this.Doctor,this.date,this.File_Name,this.Notes,this.fcmToken,this.link});

}
