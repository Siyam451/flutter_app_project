import 'package:flutter/material.dart';
import 'package:local_event_finder_app/screens/payment_screen.dart';

class TicketBookingScreen extends StatefulWidget {
  const TicketBookingScreen({super.key});

  @override
  State<TicketBookingScreen> createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();


  int ticketCount = 1;

  // Increase tickets
  void _increment() {
    setState(() {
      ticketCount++;
    });
  }

  // Decrease tickets
  void _decrement() {
    if (ticketCount > 1) {
      setState(() {
        ticketCount--;
      });
    }
  }

  // Submit form
  void _submit() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String phone = _phonecontroller.text;

      // You can navigate to payment screen here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Name: $name\nEmail: $email\nTickets: $ticketCount",
          ),
        ),
      );

      
      Navigator.push(context,
         MaterialPageRoute(builder: (_) => PaymentMethodScreen(
           name: name,
           email: email,
           ticketCount: ticketCount, phone: phone,)),
       );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ticket Booking'),
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                
                  // Full Name
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                
                  const SizedBox(height: 16),
                
                  // Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      }
                      if (!value.contains('@')) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                
                  TextFormField(
                    controller: _phonecontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      prefixIcon: Icon(Icons.call),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Phone Number";
                      }
                      return null;
                    },
                  ),
                
                  const SizedBox(height: 24),
                
                  // Ticket Counter
                  const Text(
                    "Number of Tickets",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                
                  const SizedBox(height: 40),
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                
                      // Decrement Button
                      IconButton(
                        onPressed: _decrement,
                        icon: const Icon(Icons.remove_circle),
                        color: Colors.red,
                        iconSize: 32,
                      ),
                
                      const SizedBox(width: 20),
                
                      // Ticket Count
                      Text(
                        ticketCount.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                
                      const SizedBox(width: 20),
                
                      // Increment Button
                      IconButton(
                        onPressed: _increment,
                        icon: const Icon(Icons.add_circle),
                        color: Colors.green,
                        iconSize: 32,
                      ),
                    ],
                  ),
                
                  const SizedBox(height: 50),
                
                  // Submit Button
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      "Proceed to Payment",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  }
}
