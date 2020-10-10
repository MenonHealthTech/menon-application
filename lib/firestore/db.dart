


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menon/modals/Doctor.dart';
import 'package:menon/modals/ListItem.dart';
import 'package:menon/modals/Patient.dart';

class DB {
  final _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> _phone;

  Future<String> isWho(String email) async {
    print(email);
    QuerySnapshot data =
        await _db.collection("Doctor").where("email", isEqualTo: email).get();
    if (data.docs.length > 0) {
      print("iswho:doctor");
      return "Doctor";
    }
    data =
        await _db.collection("Patients").where("email", isEqualTo: email).get();
    if (data.docs.length > 0) {
      print("isWho: Patient");
      return "Patient";
    }
    print("New user");
    return "new";
  }

  Future<bool> createPatient(Patient patient, String pass) async {
    bool rt = false;

    // Auth().createUser(patient.phone, pass);
    try {
      await _db.collection("Patients").doc(patient.email).set({
        "firstName": patient.firstName[0].toUpperCase() +
            patient.firstName.substring(1).toLowerCase(),
        "lastName": patient.lastName[0].toUpperCase() +
            patient.lastName.substring(1).toLowerCase(),
        "phone": patient.phone,
        "email": patient.email,
        "height": patient.height,
        "weight": patient.weight,
        "Age": patient.age,
        "Date of Birth": patient.dob,
        "covidStatus": patient.covidStatus,
        "pass": pass,
        "fcmToken": patient.fcmToken
      });
      rt = true;
      print(rt);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString('Number', patient.phone);
    } catch (e) {
      print(e.message);
    }
    return rt;
  }

  Future<bool> createDoctor(Doctor doctor, String pass) async {
    bool rt = false;
    try {
      await _db.collection("Doctor").doc(doctor.email).set({
        "firstName": doctor.firstName[0].toUpperCase() +
            doctor.firstName.substring(1).toLowerCase(),
        "lastName": doctor.lastName[0].toUpperCase() +
            doctor.lastName.substring(1).toLowerCase(),
        "phone": doctor.phone,
        "email": doctor.email,
        "degree": doctor.degree,
        "verifed": false,
        "upiid": doctor.upiid,
        "accountNo": doctor.accountNo,
        "ifsc": doctor.ifsc,
        "consultationFee": doctor.consultationFee,
        "pass": pass,
        "regNo": doctor.regNo,
        "address": doctor.address,
        "experience": doctor.experience,
        "followUpFee": doctor.followUpFee,
        "packageFee": doctor.packageFee,
        "fcmToken": doctor.fcmToken
      });

      /*try {
        //print(doctor.document.name);

        fb.storage()
            .refFromURL("gs://menonhealthtech.appspot.com")
            .child(
            doctor.firstName + "_" + doctor.lastName + "_" + doctor.phone)
            .put(doctor.document)
            .future;

        fb
            .storage()
            .refFromURL("gs://menonhealthtech.appspot.com")
            .child(doctor.phone)
            .put(doctor.profile)
            .future;
      } catch (e) {
        print("Cannot Upload Document");
        print(e);
      }*/

      //Auth().createUser(doctor.phone, pass);
      rt = true;
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString('Number', doctor.phone);
    } catch (e) {
      print("Cannot Register");
      print(e);
      rt = false;
    }
    return rt;
  }

  Future getUser(String phone) async {
    Patient p = Patient();
    Doctor d = Doctor();
    try {
      var ss = await _db
          .collection("Patients")
          .where("email", isEqualTo: phone)
          .get();

      if (ss.docs.isNotEmpty) {
        var data = ss.docs[0].data();
        if (data != null) {
          p.firstName = data["firstName"];
          p.lastName = data["lastName"];
          p.gender = data["gender"];
          p.covidStatus = data["covidStatus"];
          p.weight = data["weight"];
          p.height = data["height"];
          p.age = data["age"];
          p.email = data["email"];
          p.phone = phone;
          return p;
        }
      }
      var dd =
          await _db.collection("Doctor").where("phone", isEqualTo: phone).get();
      if (dd.docs.isNotEmpty) {
        var data = dd.docs[0].data();
        if (data != null) {
          d.firstName = data["firstName"];
          d.lastName = data["lastName"];
          d.consultationFee = data["consultationFee"];
          d.degree = data["degree"];
          d.verified = data["verified"];
          d.email = data["email"];
          d.phone = phone;
          return d;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future getMyDoctor(String phone) async {
    List<Doctor> doctors = List<Doctor>();
    print(phone);
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(phone)
          .collection("Doctors")
          .get();
      var doc = data.docs;

      for (var i = 0; i < doc.length; i++) {
        String p = doc[i].data()["DoctorNumber"];
        print(p);
        t = await _db.collection("Doctor").doc(p).get();
        Doctor da = Doctor();
        da.consultationFee = t.data()["consultationFee"];
        da.dateOfBirth = t.data()["dateOfBirth"];
        da.degree = t.data()["degree"];
        da.email = t.data()["email"];
        da.firstName = t.data()["firstName"];
        da.lastName = t.data()["lastName"];
        da.licenceNo = t.data()["licenceNo"];
        da.phone = t.data()["phone"];
        da.verified = t.data()["verifed"];
        doctors.add(da);
      }
    } catch (e) {
      print(e);
    }
    return doctors;
  }

  Future<List<Doctor>> getAllDoctors() async {
    List<Doctor> doctors = [];
    try {
      QuerySnapshot data = await _db.collection("Doctor").get();

      data.docs.forEach((element) {
        var d = element.data();
        // print(d);
        Doctor da = Doctor();
        da.consultationFee = d["consultationFee"];
        da.dateOfBirth = d["dateOfBirth"];
        da.degree = d["degree"];
        da.email = d["email"];
        da.firstName = d["firstName"];
        da.lastName = d["lastName"];
        da.licenceNo = d["licenceNo"];
        da.phone = d["phone"];
        da.verified = d["verifed"];
        doctors.add(da);
        print(d["verifed"]);
      });
    } catch (e) {
      print(e.message);
    }

    return doctors;
  }

  Future sendNotification(Doctor d, String input) async {
    print("sendNotification gets input gets called");
    print(d.email);
    _db.collection("Doctor").doc(d.email).collection("notification").add({
      "message": input,
      "title": d.email,
      "date": FieldValue.serverTimestamp()
    });
  }

  Future<List<Doctor>> getDoctors(String phone) async {
    List<Doctor> all = List<Doctor>();
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(phone)
          .collection("Doctors")
          .get();
      var doc = data.docs;
      all = await getAllDoctors();
      print(all.length);
      if (doc.length == 0) return all;

      for (var i = 0; i < doc.length; i++) {
        print(all[i].phone);
        for (var j = 0; j < all.length; j++) {
          if (all[j].phone == doc[i].data()["DoctorNumber"]) all.remove(all[j]);
        }
      }
    } catch (e) {
      print(e.message);
    }

    return all;
  }

  Future<List<Patient>> getPatient(String docNumber) async {
    List<Patient> patients = [];
    DocumentSnapshot t;
    try {
      QuerySnapshot data = await _db
          .collection("Doctor")
          .doc(docNumber)
          .collection("Patient")
          .get();
      var doc = data.docs;

      for (var i = 0; i < doc.length; i++) {
        String d = doc[i].data()["PatientNumber"];
        t = await _db.collection("Patients").doc(d).get();
        Patient p = Patient();
        p.firstName = t.data()["firstName"];
        p.lastName = t.data()["lastName"];
        p.email = t.data()["email"];
        p.phone = t.data()["phone"];
        p.weight = t.data()["weight"];
        p.height = t.data()["height"];
        patients.add(p);
      }
    } catch (e) {
      print(e.message);
    }
    return patients;
  }

  Future<bool> sendRequest(Doctor d, String pN) async {
    try {
      await _db
          .collection("Doctor")
          .doc(d.email)
          .collection("Request")
          .doc(pN)
          .set({
        "PatientNumber": pN,
        "Date Added": Timestamp.now().toDate().toString(),
      });
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Requested")
          .doc(d.phone)
          .set({
        "DoctorNumber": d.phone,
        "Date Added": Timestamp.now().toDate().toString(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future acceptPatient(String dN, String pN) async {
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("PaymentRequest")
          .doc(pN)
          .set({
        "PatientNumber": pN,
        "Date Added": Timestamp.now().toDate().toString(),
      });

      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Request")
          .doc(pN)
          .delete();
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("PaymentRequest")
          .doc(dN)
          .set({
        "DoctorNumber": dN,
        "Date Added": Timestamp.now().toDate().toString(),
      });
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Requested")
          .doc(dN)
          .delete();
    } catch (e) {
      return false;
    }
    return true;
  }

  Future rejectPatient(String dN, String pN) async {
    try {
      await _db
          .collection("Doctor")
          .doc(dN)
          .collection("Request")
          .doc(pN)
          .delete();
      await _db
          .collection("Patients")
          .doc(pN)
          .collection("Requested")
          .doc(dN)
          .delete();
      return true;
    } catch (e) {
      print(e);
    }
    return;
  }

  Future<bool> isRequested(String pN, String dN) async {
    print(pN);
    print(dN);
    try {
      QuerySnapshot data = await _db
          .collection("Patients")
          .doc(pN)
          .collection("Requested")
          .where("DoctorNumber", isEqualTo: dN)
          .get();

      if (data.docs.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Patient>> allRequested(String dN) async {
    List<Patient> patients = [];
    DocumentSnapshot t;
    try {
      QuerySnapshot data =
          await _db.collection("Doctor").doc(dN).collection("Request").get();
      var doc = data.docs;

      for (var i = 0; i < doc.length; i++) {
        String ph = doc[i].data()["PatientNumber"];
        print(ph);
        t = await _db.collection("Patients").doc(ph).get();
        Patient p = Patient();
        p.firstName = t.data()["firstName"];
        p.lastName = t.data()["lastName"];
        p.email = t.data()["email"];
        p.phone = t.data()["phone"];
        p.weight = t.data()["weight"];
        p.height = t.data()["height"];
        patients.add(p);
      }

      return patients;
    } catch (e) {
      return null;
    }
  }

  Future getCount() async {}

  getNotify(String phone) {}

  Future<bool> storeLink(
      String phone, String imageLink, ListItem selectedItem) async {
    String time = Timestamp.now().toDate().toString();
    try {
      await _db
          .collection("Patients")
          .doc(phone)
          .collection("otherReports")
          .doc(phone)
          .set({"link": imageLink, "type": selectedItem.name});
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  // Future<String> getLink(String phone) async {
  //   DataSnapshot tl;
  //   try{
  //     QuerySnapshot data  = await _db.collection("Patients").doc(phone).collection("otherReports").get();
  //
  //   }catch(e){
  //     print(e);
  //   }
  // }

// Future<String> deleteUser(String verificationID,String code)async{
//   try{
//     User _user = _auth.currentUser;
//     print("User Deleted");
//     //AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: null, smsCode: null);
//     AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: code);
//      UserCredential result = await _user.reauthenticateWithCredential(credential);
//      await result.user.delete();
//       print("User deleted finaly");
//   }catch(e){
//     print("Error: Delete");
//     print(e);
//   }
// }
}
