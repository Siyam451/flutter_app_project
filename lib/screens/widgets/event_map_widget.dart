import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class EventMapWidget extends StatefulWidget {
  const EventMapWidget({super.key, required this.latitude, required this.longitude, required this.location});
  final double latitude;
  final double longitude;
  final String location;

  @override
  State<EventMapWidget> createState() => _EventMapWidgetState();
}

class _EventMapWidgetState extends State<EventMapWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.maxFinite,

      child: GoogleMap(initialCameraPosition:CameraPosition(
          target: 
      LatLng(widget.latitude,widget.longitude),
      zoom: 15,
      ),
      markers: {
        Marker(markerId: MarkerId('Event-marker'),
          position: LatLng(widget.latitude, widget.longitude),//location show kora
          infoWindow: InfoWindow(title: widget.location),//location er moddhe ki show korbe ta

        )

          }
      ),
      


    );
  }
}
