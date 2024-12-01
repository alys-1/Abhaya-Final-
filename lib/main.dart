import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // For simulating network delay
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // If you're using latlong2 package

void main() {
  runApp(AbhayaApp());
}

class AbhayaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: RegistrationScreen(), // Set RegistrationScreen as the initial screen
    );
  }
}



class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  bool isVerified = false;
  bool isVerifying = false; // To show a loading indicator during verification

  // Simulated API call for Aadhar Verification
  Future<void> verifyAadhar(String aadhar) async {
    setState(() {
      isVerifying = true;
    });

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    if (aadhar.length == 12 && aadhar.startsWith("1")) {
      setState(() {
        isVerified = true;
        isVerifying = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Aadhar Verified Successfully!')),
      );
    } else {
      setState(() {
        isVerified = false;
        isVerifying = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Aadhar Number! Please try again.')),
      );
    }
  }

  void registerUser() {
    if (isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to LoginScreen
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please verify your Aadhar to proceed!')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text('Registration'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green[300],
                child: Icon(Icons.person_add, size: 50, color: Colors.white),
              ),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              TextField(
                controller: aadharController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Aadhar Number',
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                maxLength: 12,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: isVerifying
                    ? null
                    : () {
                  verifyAadhar(aadharController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: isVerifying
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    SizedBox(width: 10),
                    Text('Verifying...'),
                  ],
                )
                    : Text('Verify Aadhar'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isVerified ? Colors.green : Colors.grey,
                ),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );

  }
}


// Login Screen
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.green[300],
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text('Abhaya', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Welcome back!', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your username/Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your password',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextButton(onPressed: () {}, child: Text('Forgot Password?')),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddressScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Address Selection Screen with Map Integration
class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  LatLng pickupAddress = LatLng(19.0760, 72.8777); // Default pickup (Mumbai)
  LatLng destinationAddress = LatLng(18.5204, 73.8567); // Default destination (Pune)

  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  // Function to handle location updates from the map
  void _onTap(LatLng latLng, bool isPickup) {
    setState(() {
      if (isPickup) {
        pickupAddress = latLng;
        pickupController.text = "${latLng.latitude}, ${latLng.longitude}";
      } else {
        destinationAddress = latLng;
        destinationController.text = "${latLng.latitude}, ${latLng.longitude}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text('Abhaya'),
        actions: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('SOS Sent!')),
              );
            },
            child: Text('SOS', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Choose your Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Manual Pickup Location Entry
            TextField(
              controller: pickupController,
              decoration: InputDecoration(
                labelText: 'Enter Pickup Location',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (value) {
                // Handle manual entry (Optional: Convert to LatLng if needed)
              },
            ),
            SizedBox(height: 10),

            // Manual Destination Location Entry
            TextField(
              controller: destinationController,
              decoration: InputDecoration(
                labelText: 'Enter Destination Location',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (value) {
                // Handle manual entry (Optional: Convert to LatLng if needed)
              },
            ),
            SizedBox(height: 20),

            // OSM Map Widget
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(19.0760, 72.8777), // Default map center
                  maxZoom: 12,
                  onTap: (tapPosition, point) {
                    // Toggle between pickup and destination
                    bool isPickup = pickupAddress == LatLng(19.0760, 72.8777);
                    _onTap(point, isPickup);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: pickupAddress,
                        width: 40.0, // Width of the marker
                        height: 40.0, // Height of the marker
                        child: Icon(Icons.location_pin, color: Colors.green), // Green Pin for Pickup Address
                      ),
                      Marker(
                        point: destinationAddress,
                        width: 40.0, // Width of the marker
                        height: 40.0, // Height of the marker
                        child: Icon(Icons.location_pin, color: Colors.red), // Red Pin for Destination Address
                      ),
                    ],
                  ),

                ],
                  ),

              ),

            SizedBox(height: 10),

            // Confirm Buttons
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pickup Location Confirmed: ${pickupController.text}')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Confirm Pick-Up Address'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Destination Location Confirmed: ${destinationController.text}')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Confirm Destination Address'),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreferencesScreen()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class PreferencesScreen extends StatefulWidget {
  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  String ridePreference = 'female_only';
  bool liveLocation = false;
  TextEditingController emergencyContactController = TextEditingController();

  // Function to show the emergency contacts dialog
  void showEmergencyContacts() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emergency Contacts'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Police: 100'),
              Text('Ambulance: 108'),
              Text('Women Helpline: 181'),
              Text('Emergency: 112'),
              Text('Parents: ${emergencyContactController.text.isNotEmpty ? emergencyContactController.text : 'Not set'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Function to save preferences and proceed to Available Rides screen
  void savePreferences() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Preferences Saved!')),
    );
    // After saving preferences, proceed to Available Rides screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AvailableRidesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text('Abhaya'),
        actions: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('SOS Sent!')),
              );
            },
            child: Text('SOS', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Set additional preferences',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(value: 'talk', child: Text('Want the driver to talk')),
                DropdownMenuItem(value: 'silent', child: Text('Want a silent ride')),
                DropdownMenuItem(value: 'none', child: Text('No Preferences')),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                RadioListTile(
                  value: 'female_only',
                  groupValue: ridePreference,
                  title: Text('Female Only'),
                  onChanged: (value) {
                    setState(() {
                      ridePreference = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  value: 'male_female',
                  groupValue: ridePreference,
                  title: Text('Male/Female'),
                  onChanged: (value) {
                    setState(() {
                      ridePreference = value.toString();
                    });
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Live Location'),
                    Switch(
                      value: liveLocation,
                      onChanged: (value) {
                        setState(() {
                          liveLocation = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Emergency contact input field
                TextField(
                  controller: emergencyContactController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Emergency Contact',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: savePreferences,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text('Save Preferences'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: showEmergencyContacts,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Emergency Contacts'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Available Rides Screen
class AvailableRidesScreen extends StatelessWidget {
  void selectRide(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('This ride is selected!')),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(title: Text('Available Rides')),
      body: ListView(
          padding: EdgeInsets.all(20),
          children: [
      ListTile(
      title: Text('Ride 1 - ₹200'),
      subtitle: Text('Driver: John, Contact: 9876543210, Distance: 9km'),
      onTap: () => selectRide(context),
    ),
    ListTile(
    title: Text('Ride 2 - ₹250'),
    subtitle: Text('Driver: Mike, Contact: 8765432109, Distance: 9.5 km'),
    onTap: () => selectRide(context),
    ),
    ListTile(
    title: Text('Ride 3 - ₹300'),
    subtitle: Text('Driver: Sarah, Contact: 7654321098, Distance: 12 km'),
    onTap: () => selectRide(context),
    ),
    ElevatedButton(
    onPressed: () {
    Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => FinalRideScreen()),
    );
    },
      child: Text('Select & Proceed'),
    ),
          ],
      ),
    );
  }
}

// Final Ride Screen
// Final Ride Screen
class FinalRideScreen extends StatefulWidget {
  @override
  _FinalRideScreenState createState() => _FinalRideScreenState();
}

class _FinalRideScreenState extends State<FinalRideScreen> {
  int trustRating = 5; // Initial trust rating (out of 5)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text('Your Ride'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Travel distance info
              Text(
                'Traveling Distance: 10km',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Trust rating
              Text(
                'Trust Rating',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => IconButton(
                    icon: Icon(
                      index < trustRating
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.yellow[700],
                    ),
                    onPressed: () {
                      setState(() {
                        trustRating = index + 1; // Update trust rating
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Ride summary
              Text(
                'Driver: Sarah\nContact: 7654321098',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Ride completion button
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ride Completed!')),
                  );
                  Navigator.pop(context); // Return to the previous screen
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Complete Ride'),
              ),
              SizedBox(height: 20),

              // Cancel ride button
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ride Cancelled!')),
                  );
                  Navigator.pop(context); // Return to the previous screen
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Cancel Ride'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





