import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import 'package:mech_app/screens/view_detail.dart';
import 'mechanic_list_screen.dart';
import 'auto_assign.dart';
import 'mechanic_login.dart';
import 'service_chat_screen.dart';
import 'package:mech_app/screens/mechanic_registration_screen.dart'; // ✅ Fixed import
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_session.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color primaryColor = const Color(0xFFFB3300);

  String _userName = "Loading...";
  bool _isLoading = true;

  List<Map<String, dynamic>> nearbyMechanics = [];

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    final url = Uri.parse(
        "https://mechanicapp-service-621632382478.asia-south1.run.app/api/user/dashboard");

    try {
      final response = await http.get(
        url,
        headers: UserSession().getAuthHeader(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          if (data['user'] != null) {
            _userName = data['user']['username'] ?? "User";
          }

          if (data['mechanics'] != null) {
            nearbyMechanics = List<Map<String, dynamic>>.from(
              (data['mechanics'] as List).map((m) => {
                "id": m['id'] ?? 0,
                "name": m['name'] ?? "Unknown Mechanic",
                "rating": (m['averagerating'] as num?)?.toDouble() ?? 0.0,
                "distance": (m['distance'] as num?)?.toDouble() ?? 0.0,
                "available": m['isactive'] ?? false,
                "image": m['mechanicimgurl'] ?? "assets/images/m1.jpg",
                "phone": m['phonenumber'] ?? "",
                "type": m['MechanicType'] ?? "",
                "experience": m['experience'] ?? 0,
              }),
            );
          }

          _isLoading = false;
        });
      } else {
        debugPrint("Failed to fetch dashboard: ${response.statusCode}");
        setState(() {
          _userName = "USER";
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching dashboard: $e");
      setState(() {
        _userName = "USER";
        _isLoading = false;
      });
    }
  }
=======
import 'package:mech_app/screens/mechanic_login.dart';
import 'package:mech_app/screens/view_detail.dart';
import 'mechanic_list_screen.dart';
import 'auto_assign.dart';
import 'service_chat_screen.dart'; 

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Color primaryColor = const Color(0xFFFB3300);

  final List<Map<String, dynamic>> nearbyMechanics = [
    {
      "id": 1,
      "name": "Ali Mechanic",
      "rating": 4.8,
      "distance": 2.5,
      "available": true,
      "image": "assets/images/m1.jpg",
      "phone": "03001234567",
    },
    {
      "id": 2,
      "name": "Ahmed Auto Repair",
      "rating": 4.6,
      "distance": 4.0,
      "available": false,
      "image": "assets/images/m2.png",
      "phone": "03009876543",
    },
    {
      "id": 3,
      "name": "Zain's Garage",
      "rating": 4.7,
      "distance": 3.2,
      "available": true,
      "image": "assets/images/m3.jpg",
      "phone": "03001112233",
    },
    {
      "id": 4,
      "name": "John Auto",
      "rating": 4.5,
      "distance": 5.0,
      "available": true,
      "image": "assets/images/m4.png",
      "phone": "03004445566",
    },
  ];
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: primaryColor),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
            Text(
              "Hi 👋",
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
            ),
            _isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 100,
                      height: 20,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    _userName,
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
          ],
        ),
      ),
      body: _isLoading
          ? const _SkeletonHomeBody()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Auto Assign
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient:
                          LinearGradient(colors: [primaryColor, Colors.deepOrange]),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Need a Mechanic Now?",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text("Nearest mechanic will be auto assigned",
                            style: GoogleFonts.poppins(color: Colors.white70)),
                        const SizedBox(height: 14),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AutoAssignScreen()),
                            );
                          },
                          child: Text("Auto Assign Mechanic",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 26),
                  // Nearby Mechanics
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nearby Mechanics",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MechanicListScreen(
                                serviceType: "Nearby Mechanics",
                                mechanics: nearbyMechanics,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Text(
                            "See All",
                            style: GoogleFonts.poppins(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 165,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearbyMechanics.length,
                      itemBuilder: (context, index) {
                        return _NearbyMechanicCompactCard(
                          mechanic: nearbyMechanics[index],
                          primaryColor: primaryColor,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Service Categories
                  Text("Service Categories",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  _serviceCard(context, "Bike Mechanic", 2, 'assets/images/bike.jpg'),
                  const SizedBox(height: 16),
                  _serviceCard(context, "Car Mechanic", 3, 'assets/images/car.jpg'),
                  const SizedBox(height: 16),
                  _serviceCard(context, "Puncher", 4, 'assets/images/puncherr.jpg'),
                ],
              ),
            ),
    );
  }

  Widget _serviceCard(BuildContext context, String title, int id, String image) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceChatScreen(serviceType: title, id: id),
=======
            Text("Hi 👋",
                style: GoogleFonts.poppins(
                    fontSize: 13, color: Colors.grey)),
            Text(
              "Syeda Zainab",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- Auto Assign --------
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient:
                    LinearGradient(colors: [primaryColor, Colors.deepOrange]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Need a Mechanic Now?",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text("Nearest mechanic will be auto assigned",
                      style: GoogleFonts.poppins(
                          color: Colors.white.withValues(alpha: 0.7))),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AutoAssignScreen()),
                      );
                    },
                    child: Text("Auto Assign Mechanic",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            // -------- Nearby Mechanics --------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nearby Mechanics",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                InkWell(
                  onTap: () {
                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => MechanicListScreen(
      serviceType: "Nearby Mechanics",
      mechanics: nearbyMechanics, 
    ),
  ),
);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      "See All",
                      style: GoogleFonts.poppins(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 165,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nearbyMechanics.length,
                itemBuilder: (context, index) {
                  return _NearbyMechanicCompactCard(
                    mechanic: nearbyMechanics[index],
                    primaryColor: primaryColor,
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // -------- Service Categories --------
            Text("Service Categories",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),

            _serviceCard(context, "Bike Mechanic", 2 ,'assets/images/bike.jpg' ),
            const SizedBox(height: 16),
            _serviceCard(context, "Car Mechanic", 3,'assets/images/car.jpg'),
            const SizedBox(height: 16),
            _serviceCard(context, "Puncher",4, 'assets/images/puncherr.jpg'),
          ],
        ),
      ),
    );
  }

  // ================= SERVICE CARD =================
  Widget _serviceCard(BuildContext context,   String title,  int id , String image) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        // 🔴 Navigate to ServiceChatScreen instead of MechanicListScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceChatScreen(serviceType: title , id:id),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
          ),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
<<<<<<< HEAD
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
=======
          image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
<<<<<<< HEAD
            color: Colors.black.withOpacity(0.45),
=======
            color: Colors.black.withValues(alpha: 0.45),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: GoogleFonts.poppins(
<<<<<<< HEAD
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
=======
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
=======
  // ================= DRAWER =================
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: primaryColor),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundImage: AssetImage('assets/images/user.jpg'),
                ),
                const SizedBox(height: 10),
<<<<<<< HEAD
                Text(
                    _isLoading ? "Loading..." : _userName,
=======
                Text("Syeda Zainab",
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                Text("User",
<<<<<<< HEAD
                    style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13)),
=======
                    style: GoogleFonts.poppins(
                        color: Colors.white.withValues(alpha: 0.7), fontSize: 13)),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
              ],
            ),
          ),
          _drawerItem(Icons.home_rounded, "Home", context),
          _drawerItem(Icons.person_rounded, "My Profile", context),
          _drawerItem(Icons.build_circle_rounded, "My Requests", context),
          _drawerItem(Icons.chat_rounded, "Chats", context),
          _drawerItem(Icons.history_rounded, "History", context),
          const Divider(),
          _drawerItem(Icons.settings_rounded, "Settings", context),
<<<<<<< HEAD
          _drawerItem(Icons.logout_rounded, "Logout", context, isLogout: true),
          const SizedBox(height: 8),
=======
          _drawerItem(Icons.logout_rounded, "Logout", context,
              isLogout: true),

          const SizedBox(height: 8),
          // ====== SWITCH TO MECHANIC MODE BUTTON AT BOTTOM ======
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
<<<<<<< HEAD
                  context,
                  MaterialPageRoute(
                    builder: (_) => MechanicRegistrationScreen(), // ✅ Fixed
                  ),
                );
=======
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MechanicLoginScreen()),
                      );
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              ),
              child: Text(
                "Switch to Mechanic Mode",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  ListTile _drawerItem(IconData icon, String title, BuildContext context,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : primaryColor),
=======
  ListTile _drawerItem(
      IconData icon, String title, BuildContext context,
      {bool isLogout = false}) {
    return ListTile(
      leading:
          Icon(icon, color: isLogout ? Colors.red : primaryColor),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
      title: Text(title,
          style: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.w500)),
      onTap: () => Navigator.pop(context),
    );
  }
}

<<<<<<< HEAD
=======
// ================= MECHANIC CARD =================
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
class _NearbyMechanicCompactCard extends StatelessWidget {
  final Map<String, dynamic> mechanic;
  final Color primaryColor;

  const _NearbyMechanicCompactCard(
      {required this.mechanic, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 245,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
<<<<<<< HEAD
                backgroundImage: mechanic['image'].toString().startsWith('http')
                    ? NetworkImage(mechanic['image'])
                    : AssetImage(mechanic['image']) as ImageProvider,
=======
                backgroundImage: AssetImage(mechanic['image']),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mechanic['name'],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 14)),
<<<<<<< HEAD
                    const SizedBox(height: 2),
                    Text(mechanic['type'],
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade600, fontSize: 12)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        Text("${mechanic['rating']}",
                            style: GoogleFonts.poppins(fontSize: 12)),
                        const SizedBox(width: 8),
                        Icon(Icons.location_on, size: 14, color: primaryColor),
                        Text("${mechanic['distance']} km",
                            style: GoogleFonts.poppins(fontSize: 12)),
=======
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 14, color: Colors.amber),
                        Text("${mechanic['rating']}",
                            style:
                                GoogleFonts.poppins(fontSize: 12)),
                        const SizedBox(width: 8),
                        Icon(Icons.location_on,
                            size: 14, color: primaryColor),
                        Text("${mechanic['distance']} km",
                            style:
                                GoogleFonts.poppins(fontSize: 12)),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
<<<<<<< HEAD
                  color: mechanic['available'] ? Colors.green : Colors.red,
=======
                  color:
                      mechanic['available'] ? Colors.green : Colors.red,
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
                  shape: BoxShape.circle,
                ),
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
<<<<<<< HEAD
              _actionButton(Icons.call_rounded, "Call", Colors.green, () async {
                final phone = mechanic['phone'] as String?;
                if (phone != null && phone.isNotEmpty) {
                  final Uri launchUri = Uri(scheme: 'tel', path: phone);
                  if (await canLaunchUrl(launchUri)) {
                    await launchUrl(launchUri);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not launch dialer for $phone')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Phone number not available')));
                }
              }),
              _actionButton(Icons.remove_red_eye_rounded, "View", primaryColor, () {
=======
              _actionButton(
                  Icons.call_rounded, "Call", Colors.green, () {}),
              _actionButton(Icons.remove_red_eye_rounded, "View",
                  primaryColor, () {
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MechanicDetailScreen(
                      serviceType: "View Mechanic",
                      mechanic: Mechanic(
                        id: mechanic['id'].toString(),
                        name: mechanic['name'],
                        avatarUrl: mechanic['image'],
<<<<<<< HEAD
                        rating: (mechanic['rating'] as num).toDouble(),
                        distanceKm: (mechanic['distance'] as num).toDouble(),
=======
                        rating:
                            (mechanic['rating'] as num).toDouble(),
                        distanceKm:
                            (mechanic['distance'] as num).toDouble(),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
                        isOnline: mechanic['available'],
                        phone: mechanic['phone'],
                        lat: 0.0,
                        lng: 0.0,
<<<<<<< HEAD
                        experienceYears: mechanic['experience'] ?? 0,
=======
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget _actionButton(IconData icon, String label, Color color, VoidCallback onTap) {
=======
  Widget _actionButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
<<<<<<< HEAD
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
=======
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(label,
                style: GoogleFonts.poppins(
<<<<<<< HEAD
                    color: color, fontWeight: FontWeight.w500, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

// Skeleton Widgets
class _SkeletonHomeBody extends StatelessWidget {
  const _SkeletonHomeBody();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18))),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 150, height: 24, color: Colors.white),
                Container(
                    width: 60,
                    height: 24,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12))),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
                height: 165,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                          width: 245,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18)));
                    })),
            const SizedBox(height: 30),
            Container(width: 180, height: 24, color: Colors.white),
            const SizedBox(height: 16),
            Container(height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18))),
            const SizedBox(height: 16),
            Container(height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18))),
            const SizedBox(height: 16),
            Container(height: 120, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18))),
=======
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: 13)),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
          ],
        ),
      ),
    );
  }
}
