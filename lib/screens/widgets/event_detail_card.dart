import 'package:flutter/material.dart';
import 'package:local_event_finder_app/screens/ticket_booking_screen.dart';

import '../../models/event_model.dart';
class EventDetailCard extends StatelessWidget {
  final EventModel event;

  const EventDetailCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Title
          Text(
            event.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Date
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 6),
              Text(event.date),
            ],
          ),

          const SizedBox(height: 6),

          // Location
          Row(
            children: [
              const Icon(Icons.location_on, size: 16),
              const SizedBox(width: 6),
              Expanded(child: Text(event.location)),
            ],
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            event.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(color: Colors.grey),
          ),

           SizedBox(height: 32),

          // Button
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=> TicketBookingScreen()));
              },
              child:  Text("GET TICKETS"),
            ),
          ),
        ],
      ),
    );
  }
}
