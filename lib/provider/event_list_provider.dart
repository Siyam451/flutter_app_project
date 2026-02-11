import 'package:flutter/material.dart';
import 'package:local_event_finder_app/models/event_model.dart';
import 'package:local_event_finder_app/services/event_service.dart';
import 'package:provider/provider.dart';

class EventListProvider extends ChangeNotifier{
  EventListProvider(this._eventService);
  final EventService _eventService;

  bool _eventListInprogress = false;
  bool get eventListinprogress => _eventListInprogress;

  String? _errormassage;
  String? get errormassage => _errormassage;

  List<EventModel> _events =[];
  List<EventModel> get events => _events;


  Future<void> loadEvent() async{
    _eventListInprogress = true;
    _errormassage = null;
    notifyListeners();
    try {
      _events = await _eventService.getAllEvents();
      _eventListInprogress = false;

      notifyListeners();
    }catch(e){
      _errormassage = 'Failed to load Events ${e.toString()}';
      _eventListInprogress = false;
      notifyListeners();
    }
}
  EventModel getEventById(String id) {
    return _events.firstWhere((event) => event.id == id);
  }

  Future<void> refreshEvents() async {
    await loadEvent();
  }
}