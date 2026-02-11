import 'package:flutter/material.dart';
import 'package:local_event_finder_app/models/event_model.dart';
import 'package:local_event_finder_app/provider/event_list_provider.dart';
import 'package:local_event_finder_app/screens/event_detail_screen.dart';
import 'package:local_event_finder_app/screens/widgets/event_card.dart';
import 'package:provider/provider.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key,});
  // static const name = '/EventListScreen';

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
@override
void initState() {
super.initState();

WidgetsBinding.instance.addPostFrameCallback((_) {
context.read<EventListProvider>().loadEvent();
});
}

  // final EventListProvider _eventListProvider = EventListProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Local Event'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Consumer<EventListProvider>(
          builder: (context,eventlistpeovider,_) {
            return ListView.builder(
                itemCount: eventlistpeovider.events.length,
                itemBuilder: (context,index){
                  final event = eventlistpeovider.events[index];
                  return EventCard(eventModel:event, onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>
                        EventDetailScreen(eventId: event.id)));
                  });
                });
          }
        ),

    );
  }
}

