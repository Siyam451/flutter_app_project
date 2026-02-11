class EventModel {
  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.category,
  });

  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String category;

  /// Create Event from JSON
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      location: json['location'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  /// Convert Event to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}