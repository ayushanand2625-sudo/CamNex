import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width < 700 ? double.infinity : 300,

      child: Card(
        elevation: 5,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Row(
            children: [
              Icon(
                icon,
                size: width < 700 ? 30 : 40,
                color: Colors.white,
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            width < 700 ? 16 : 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            width < 700 ? 14 : 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}