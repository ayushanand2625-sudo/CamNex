import 'package:flutter/material.dart';
import '../models/transport.dart';

class TransportDetailsCard extends StatelessWidget {
  final Transport transport;

  const TransportDetailsCard({
    super.key,
    required this.transport,
  });

  Widget buildTile(
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(
    IconData icon,
    String title,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.blue,
            size: 20,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(22),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =================================================
            // HEADER
            // =================================================

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.directions_bus,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Transport Details",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 3),

                      Text(
                        "Student transportation information",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // =================================================
            // STUDENT INFORMATION
            // =================================================

            buildSectionTitle(
              Icons.person_outline,
              "Student Information",
            ),

            const SizedBox(height: 15),

            LayoutBuilder(
              builder: (context, constraints) {
                final isWide =
                    constraints.maxWidth >= 650;

                final tiles = [
                  buildTile(
                    "Student Name",
                    transport.studentName,
                  ),

                  buildTile(
                    "Admission Number",
                    transport.admissionNo,
                  ),

                  buildTile(
                    "Class",
                    transport.studentClass,
                  ),

                  buildTile(
                    "Academic Year",
                    transport.academicYear,
                  ),
                ];

                if (isWide) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: tiles.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 4.5,
                    ),
                    itemBuilder: (context, index) {
                      return tiles[index];
                    },
                  );
                }

                return Column(
                  children: tiles
                      .map(
                        (tile) => Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: tile,
                        ),
                      )
                      .toList(),
                );
              },
            ),

            const SizedBox(height: 28),

            // =================================================
            // BUS INFORMATION
            // =================================================

            buildSectionTitle(
              Icons.directions_bus_outlined,
              "Bus Information",
            ),

            const SizedBox(height: 15),

            LayoutBuilder(
              builder: (context, constraints) {
                final isWide =
                    constraints.maxWidth >= 650;

                final tiles = [
                  buildTile(
                    "Bus Number",
                    transport.busNumber,
                  ),

                  buildTile(
                    "Vehicle Number",
                    transport.vehicleNumber,
                  ),

                  buildTile(
                    "Route Number",
                    transport.routeNumber,
                  ),
                ];

                if (isWide) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: tiles.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 4.5,
                    ),
                    itemBuilder: (context, index) {
                      return tiles[index];
                    },
                  );
                }

                return Column(
                  children: tiles
                      .map(
                        (tile) => Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: tile,
                        ),
                      )
                      .toList(),
                );
              },
            ),

            const SizedBox(height: 28),

            // =================================================
            // DRIVER INFORMATION
            // =================================================

            buildSectionTitle(
              Icons.person_pin,
              "Driver Information",
            ),

            const SizedBox(height: 15),

            LayoutBuilder(
              builder: (context, constraints) {
                final isWide =
                    constraints.maxWidth >= 650;

                final tiles = [
                  buildTile(
                    "Driver Name",
                    transport.driverName,
                  ),

                  buildTile(
                    "Driver Contact Number",
                    transport.driverContactNumber,
                  ),
                ];

                if (isWide) {
                  return Row(
                    children: [
                      Expanded(child: tiles[0]),
                      const SizedBox(width: 15),
                      Expanded(child: tiles[1]),
                    ],
                  );
                }

                return Column(
                  children: [
                    tiles[0],
                    const SizedBox(height: 12),
                    tiles[1],
                  ],
                );
              },
            ),

            const SizedBox(height: 28),

            // =================================================
            // ROUTE INFORMATION
            // =================================================

            buildSectionTitle(
              Icons.location_on_outlined,
              "Route Information",
            ),

            const SizedBox(height: 15),

            LayoutBuilder(
              builder: (context, constraints) {
                final isWide =
                    constraints.maxWidth >= 650;

                final tiles = [
                  buildTile(
                    "Pickup Point",
                    transport.pickupPoint,
                  ),

                  buildTile(
                    "Drop Point",
                    transport.dropPoint,
                  ),
                ];

                if (isWide) {
                  return Row(
                    children: [
                      Expanded(child: tiles[0]),
                      const SizedBox(width: 15),
                      Expanded(child: tiles[1]),
                    ],
                  );
                }

                return Column(
                  children: [
                    tiles[0],
                    const SizedBox(height: 12),
                    tiles[1],
                  ],
                );
              },
            ),

            const SizedBox(height: 28),

            // =================================================
            // FEE INFORMATION
            // =================================================

            buildSectionTitle(
              Icons.currency_rupee,
              "Fee Information",
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: buildTile(
                    "Transport Fee",
                    transport.transportFee,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: transport.feeStatus
                                  .toLowerCase() ==
                              "paid"
                          ? Colors.green.shade50
                          : Colors.orange.shade50,
                      borderRadius:
                          BorderRadius.circular(12),
                      border: Border.all(
                        color: transport.feeStatus
                                    .toLowerCase() ==
                                "paid"
                            ? Colors.green.shade200
                            : Colors.orange.shade200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fee Status",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          transport.feeStatus,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: transport.feeStatus
                                        .toLowerCase() ==
                                    "paid"
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}