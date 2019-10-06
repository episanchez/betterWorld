import "package:better_world/logic/model/Address.dart";

class UserForm {
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String phone;
  final String email;
  final Address address;

  UserForm({this.firstName, this.lastName, this.birthDate, this.phone, this.email, this.address});

  factory UserForm.fromJson(Map<String, dynamic> json) {
    return UserForm(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      phone: json['phone'],
      email: json['email'],
      address: Address.fromJson(json['address'])
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'firstName': firstName,
        'lastName': lastName,
        'birthDate': "22-04-1992",
        'phone': phone,
        'email': email,
        'address': address.toJson()
      };
}