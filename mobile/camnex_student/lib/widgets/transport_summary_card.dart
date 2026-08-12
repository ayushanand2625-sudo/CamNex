import 'package:flutter/material.dart';

class TransportSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const TransportSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [

          // ICON
          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: const Color(0xffDBEAFE),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              size: 25,
              color: const Color(0xff2563EB),
            ),
          ),

          const SizedBox(width: 14),

          // INFORMATION
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}