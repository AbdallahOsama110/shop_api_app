class LocationData {
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;
  int? id;

  LocationData({
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
    this.latitude,
    this.longitude,
    this.id,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
        name: json['name'] as String?,
        city: json['city'] as String?,
        region: json['region'] as String?,
        details: json['details'] as String?,
        notes: json['notes'] as String?,
        latitude: json['latitude'],
        longitude: json['longitude'],
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  String toString() {
    return name ?? '';
  }
}
