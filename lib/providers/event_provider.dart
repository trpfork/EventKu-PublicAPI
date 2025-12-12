import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../services/event_service.dart';

class EventProvider with ChangeNotifier {
  final EventService _service = EventService();

  List<EventModel> _upcomingEvents = [];
  List<EventModel> _recommendedEvents = [];
  List<EventModel> _searchedEvents = [];
  List<EventModel> _categoryEvents = [];

  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  List<EventModel> get upcomingEvents => _upcomingEvents;
  List<EventModel> get recommendedEvents => _recommendedEvents;
  List<EventModel> get searchedEvents => _searchedEvents;
  List<EventModel> get categoryEvents => _categoryEvents;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch Home Data
  Future<void> fetchHomeData() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Fetch 5 upcoming music events
      _upcomingEvents = await _service.fetchEvents(
        classificationName: 'Music',
        size: 5,
      );

      // Fetch general events for recommendations
      _recommendedEvents = await _service.fetchEvents(sort: 'random', size: 10);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search Events
  Future<void> searchEvents(String keyword) async {
    if (keyword.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      _searchedEvents = await _service.fetchEvents(keyword: keyword);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch by Category
  Future<void> fetchByCategory(String category) async {
    _isLoading = true;
    _categoryEvents = []; // Clear previous
    notifyListeners();

    try {
      _categoryEvents = await _service.fetchEvents(
        classificationName: category,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
