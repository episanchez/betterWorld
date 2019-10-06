
class Address {
  final String line1;
  final String line2;
  final String postalCode;
  final String city;
  final String country;

  Address({this.line1, this.line2, this.postalCode, this.city, this.country});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      line1: json['line1'],
      line2: json['line2'],
      postalCode: json['postalCode'],
      city: json['city'],
      country: json['country']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'line1': line1,
        'line2': "",
        'postalCode': postalCode,
        'city': city,
        'country': country
      };
}