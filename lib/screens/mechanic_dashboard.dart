import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

<<<<<<< HEAD
// Screens imports
import 'mechanic_bookingrequest.dart';
import 'mechanic_earnings.dart';
import 'mechanic_profile.dart';
import 'mechanic_login.dart';

=======
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
class MechanicDashboardScreen extends StatefulWidget {
  const MechanicDashboardScreen({super.key});

  @override
  State<MechanicDashboardScreen> createState() =>
      _MechanicDashboardScreenState();
}

class _MechanicDashboardScreenState extends State<MechanicDashboardScreen> {
  final Color primaryColor = const Color(0xFFFB3300);

<<<<<<< HEAD
=======
  // Sample service requests
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
  List<Map<String, dynamic>> requests = [
    {
      'user': 'Ali Khan',
      'service': 'Car Mechanic',
      'status': 'Pending',
      'distance': 2.5,
      'earnings': 1200,
      'timer': 60,
<<<<<<< HEAD
=======
      'actionTaken': false,
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
    },
    {
      'user': 'Sarah Ahmed',
      'service': 'Bike Mechanic',
      'status': 'Pending',
      'distance': 3.2,
      'earnings': 800,
      'timer': 60,
<<<<<<< HEAD
    },
  ];

  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startTimers();
  }

  void startTimers() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        for (var req in requests) {
          if (req['timer'] > 0) req['timer'] -= 1;
        }
      });
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
=======
      'actionTaken': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate total earnings
    double totalEarnings = requests.fold(0, (sum, r) => sum + r['earnings']);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// APP BAR
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          'Mechanic Dashboard',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
<<<<<<< HEAD
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => showNotificationDialog(context),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(Icons.notifications,
                      size: 30, color: Colors.black87),
                  if (requests.any((r) => r['status'] == 'Pending'))
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
=======
          IconButton(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: primaryColor,
            ),
            onPressed: _openNotifications,
          ),
        ],
      ),

      /// DRAWER
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: Center(
                child: Text(
                  'Mechanic Menu',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            _drawerItem(Icons.dashboard, 'Dashboard'),
<<<<<<< HEAD
            _drawerItem(
              Icons.history,
              'Booking Requests',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MechanicBookingRequestScreen(),
                  ),
                );
              },
            ),
            _drawerItem(
              Icons.payment,
              'Earnings',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MechanicEarningsScreen(),
                  ),
                );
              },
            ),
            _drawerItem(
              Icons.person,
              'Profile',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MechanicProfileScreen(),
                  ),
                );
              },
            ),
            _drawerItem(Icons.settings, 'Settings'),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  // ✅ LOGOUT (ORANGE + LOGIN NAVIGATION)
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const MechanicLoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Switch to User Mode'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
=======
            _drawerItem(Icons.history, 'Booking History'),
            _drawerItem(Icons.payment, 'Earnings'),
            _drawerItem(Icons.person, 'Profile'),
            _drawerItem(Icons.settings, 'Settings'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.swap_horiz),
                label: const Text('Switch to User Mode'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
              ),
            ),
          ],
        ),
      ),
<<<<<<< HEAD
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildDashboardCard(
                      'Total Earnings', 'PKR 5500', const Color(0xFF2E7D32)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDashboardCard(
                      'Today', 'PKR 1500', const Color(0xFF2196F3)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDashboardCard(
                      'Completed', '2', const Color(0xFF2E7D32)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDashboardCard(
                      'Pending', '1', const Color(0xFFFFA000)),
                ),
              ],
            ),
          ],
=======

      /// BODY: Total Earnings Card
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [primaryColor, Colors.deepOrange],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Earnings',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'PKR ${totalEarnings.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildDashboardCard(String title, String value, Color valueColor) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54)),
          const SizedBox(height: 8),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: valueColor)),
=======
  /// 🔔 OPEN SERVICE REQUESTS MODAL
  void _openNotifications() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        Timer? modalTimer;

        return StatefulBuilder(
          builder: (context, setModalState) {
            // Start the timer inside modal
            modalTimer ??= Timer.periodic(const Duration(seconds: 1), (_) {
              setModalState(() {
                for (var r in requests) {
                  if (r['status'] == 'Pending' && r['timer'] > 0) {
                    r['timer']--;
                  }
                }
              });
            });

            return WillPopScope(
              onWillPop: () async {
                modalTimer?.cancel(); // stop timer when modal closes
                return true;
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Service Requests',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView(
                        children: requests.map((r) {
                          return _requestCard(r, () => setModalState(() {}));
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// REQUEST CARD
  Widget _requestCard(Map<String, dynamic> r, VoidCallback refresh) {
    bool pending = r['status'] == 'Pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User & Timer / Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(r['user'],
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  pending ? 'Pending (${r['timer']}s)' : r['status'],
                  style: GoogleFonts.poppins(
                      color: primaryColor, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('${r['service']} • ${r['distance']} km away'),
          const SizedBox(height: 6),
          Text('Earnings: PKR ${r['earnings']}'),
          if (pending)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _updateStatus(r, 'Accepted');
                    refresh();
                  },
                  child: Text('Accept',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () {
                    _updateStatus(r, 'Rejected');
                    refresh();
                  },
                  child: Text('Reject',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget _drawerItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title, style: GoogleFonts.poppins()),
      onTap: onTap ?? () => Navigator.pop(context),
    );
  }

  void showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Notifications'),
        content: const SizedBox(
          height: 200,
          child: Center(child: Text('No new notifications')),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      ),
=======
  /// UPDATE STATUS
  void _updateStatus(Map<String, dynamic> r, String status) {
    setState(() {
      r['status'] = status;
      r['actionTaken'] = true;
      r['timer'] = 0; // stop timer visually
    });
  }

  /// DRAWER ITEM
  Widget _drawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title, style: GoogleFonts.poppins()),
      onTap: () => Navigator.pop(context),
>>>>>>> 176a7fec0fb3584ef958e6ed87bb4e58bc590a39
    );
  }
}
