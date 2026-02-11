
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_event_finder_app/screens/event_detail_screen.dart';

import '../../models/event_model.dart';
import '../../utilits/category_color.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key, required this.eventModel, required this.onTap,
  });
  //
   final EventModel eventModel;
   final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
  // EventModel eventModel =  EventModel(
  //     id: 'dhaka1',
  //     title: 'Pohela Boishakh Celebration',
  //     description:
  //     'Celebrate Bengali New Year with traditional music, dance, and cultural performances at Ramna Batamul. Enjoy authentic Bengali cuisine, art exhibitions, and festive activities.',
  //     date: '2026-04-14',
  //     time: '09:00',
  //     location: 'Ramna Park, Dhaka',
  //     latitude: 23.7379,
  //     longitude: 90.3947,
  //     category: 'Culture',
  //     imageUrl:
  //     'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=800',
  //   );


  final DateTime dateTime = DateTime.parse(eventModel.date);
  final String formatedDate = DateFormat('MMMM dd, yyyy').format(dateTime);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
        
                GestureDetector(
                  onTap:()=> onTap(),
                  child: Image.network(
                    eventModel.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: Icon(Icons.image_not_supported)),
                      );
                    },
                  ),
                ),
        
                const SizedBox(height: 10),
        
                ElevatedButton(
                  onPressed: () {},
        
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    CategoryColor.getColor(eventModel.category),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
        
                  child: Text(eventModel.category),
                ),
        
        
                const SizedBox(height: 5),
        
                Text(eventModel.title,style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.date_range,color: Colors.grey,),
                    Text(formatedDate,style:TextStyle(color: Colors.grey),)
        
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.location_on,color: Colors.grey,),
                    Expanded(child: Text(
                        eventModel.location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
        
                    )),
                  ],
                )
        
              ],
            ),
          ),
        ),

    );
  }
}
