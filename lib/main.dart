import 'package:flutter/material.dart';
import 'package:local_event_finder_app/provider/event_list_provider.dart';
import 'package:local_event_finder_app/screens/event_list_screen.dart';
import 'package:local_event_finder_app/services/event_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LocalEventFinder());
}

class LocalEventFinder extends StatelessWidget {
  const LocalEventFinder({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (_)=> EventListProvider(EventService()))
     ],
     child: MaterialApp(
       home: EventListScreen(),
     ),
   );
  }

}