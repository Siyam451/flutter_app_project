import 'package:flutter/material.dart';
import 'package:local_event_finder_app/screens/widgets/event_detail_card.dart';
import 'package:local_event_finder_app/screens/widgets/event_map_widget.dart';
import 'package:provider/provider.dart';

import '../models/event_model.dart';
import '../provider/event_list_provider.dart';
class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key, required this.eventId});
  final String eventId;
  static const name = '/EventDetailsScreen';

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final eventListProvider = context.watch<EventListProvider>();
    final EventModel event =
    eventListProvider.getEventById(widget.eventId);

    return Scaffold(
      body: Column(
        children: [

          //  Map Section
          Expanded(
            flex: 3, // adjust height
            child: EventMapWidget(
              latitude: event.latitude,
              longitude: event.longitude,
              location: event.location,
            ),
          ),

          // Detail Card
          Expanded(
            flex: 2,
            child: EventDetailCard(event: event),
          ),
        ],
      ),
    );
  }
}
