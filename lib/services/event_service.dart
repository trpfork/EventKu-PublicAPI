import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventService {
  static const String apiKey = '7sqGfzMJ0xlBFF4787JeD4AIB06cJ5tD';
  static const String baseUrl =
      'https://app.ticketmaster.com/discovery/v2/events.json';

  Future<List<EventModel>> fetchEvents({
    String? keyword,
    String? classificationName,
    String sort = 'date,asc',
    int size = 20,
  }) async {
    final Uri uri = Uri.parse(baseUrl).replace(
      queryParameters: {
        'apikey': apiKey,
        'keyword': keyword,
        'classificationName': classificationName,
        'sort': sort,
        'size': size.toString(),
        // 'countryCode': 'US', // Optional: Filter by country
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['_embedded'] != null && data['_embedded']['events'] != null) {
          final List<dynamic> eventsJson = data['_embedded']['events'];
          return eventsJson.map((json) => EventModel.fromJson(json)).toList();
        } else {
          return []; // No events found
        }
      } else {
        throw Exception('Failed to load events: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
