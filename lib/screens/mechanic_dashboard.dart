import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MechanicDashboardScreen extends StatefulWidget {
  const MechanicDashboardScreen({super.key});

  @override
  State<MechanicDashboardScreen> createState() => _MechanicDashboardScreenState();
}

class _MechanicDashboardScreenState extends State<MechanicDashboardScreen> {
  final Color primaryColor = const Color(0xFFFB3300);

  List<Map<String, dynamic>> requests = [
    {
      'user': 'Ali Khan',
      'service': 'Car Mechanic',
      'status': 'Pending',
      'distance': 2.5,
      'earnings': 1200,
      'timer': 60,
      'actionTaken': false,
      'actionType': '',
    },
    {
      'user': 'Sarah Ahmed',
      'service': 'Bike Mechanic',
      'status': 'Pending',
      'distance': 3.2,
      'earnings': 800,
      'timer': 60,
      'actionTaken': false,
      'actionType': '',
    },
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        for (var req in requests) {
          if (req['status'] == 'Pending' && req['timer'] > 0 && !req['actionTaken']) {
            req['timer']--;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateRequestStatus(Map<String, dynamic> request, String actionType) {
    setState(() {
      request['status'] = actionType;
      request['actionTaken'] = true;
      request['actionType'] = actionType;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalEarnings = requests.fold(0, (sum, item) => sum + item['earnings']);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Mechanic Dashboard',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
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
            ListTile(
              leading: Icon(Icons.dashboard, color: primaryColor),
              title: Text('Dashboard', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.list_alt, color: primaryColor),
              title: Text('Bookings', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.history, color: primaryColor),
              title: Text('Booking History', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.payment, color: primaryColor),
              title: Text('Earnings', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.person, color: primaryColor),
              title: Text('Profile', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: primaryColor),
              title: Text('Logout', style: GoogleFonts.poppins()),
              onTap: () {
                // Logout logic
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Total Earnings
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(colors: [primaryColor, Colors.deepOrange]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total Earnings',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
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
            ),
            const SizedBox(height: 24),
            Text(
              'Active Requests',
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...requests.map((req) => _requestCard(req)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _requestCard(Map<String, dynamic> request) {
    bool isPending = request['status'] == 'Pending';
    bool actionTaken = request['actionTaken'];
    String actionType = request['actionType'];
    Color statusColor = Colors.orange.shade700;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
        border: actionTaken ? Border.all(color: Colors.orange, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User & Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                request['user'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isPending ? 'Pending (${request['timer']}s)' : actionType,
                  style: GoogleFonts.poppins(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${request['service']} • ${request['distance']} km away',
            style: GoogleFonts.poppins(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 6),
          Text(
            'Earnings: PKR ${request['earnings']}',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),

          // Action Buttons
          if (isPending)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: actionTaken ? null : () => _updateRequestStatus(request, 'Accepted'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.orange.shade800,
                    side: BorderSide(
                      color: actionTaken && actionType == 'Accepted' ? Colors.orange : Colors.grey.shade300,
                    ),
                  ),
                  child: Text('Accept', style: TextStyle(color: Colors.orange.shade800)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: actionTaken ? null : () => _updateRequestStatus(request, 'Rejected'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.orange.shade800,
                    side: BorderSide(
                      color: actionTaken && actionType == 'Rejected' ? Colors.orange : Colors.grey.shade300,
                    ),
                  ),
                  child: Text('Reject', style: TextStyle(color: Colors.orange.shade800)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
