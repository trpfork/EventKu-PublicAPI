class EventModel {
  final String id;
  final String name;
  final String? description;
  final String imageUrl;
  final String date;
  final String venueName;
  final String city;
  final String ticketUrl;

  EventModel({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.date,
    required this.venueName,
    required this.city,
    required this.ticketUrl,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    // Helper to get high-res image
    String getImg() {
      try {
        List images = json['images'];
        // Prefer 16:9 ratio or fall back to first
        var img = images.firstWhere(
          (i) => i['ratio'] == '16_9',
          orElse: () => images[0],
        );
        return img['url'];
      } catch (e) {
        return 'https://via.placeholder.com/300';
      }
    }

    // Helper to get Venue
    String getVenue() {
      try {
        return json['_embedded']['venues'][0]['name'] ?? 'Unknown Venue';
      } catch (e) {
        return 'Unknown Venue';
      }
    }

    // Helper to get City
    String getCity() {
      try {
        return json['_embedded']['venues'][0]['city']['name'] ?? 'Unknown City';
      } catch (e) {
        return 'Unknown City';
      }
    }

    return EventModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'No Name',
      description:
          json['info'] ?? json['pleaseNote'] ?? 'No description available.',
      imageUrl: getImg(),
      date: json['dates']['start']['localDate'] ?? 'TBA',
      venueName: getVenue(),
      city: getCity(),
      ticketUrl: json['url'] ?? '',
    );
  }
}
