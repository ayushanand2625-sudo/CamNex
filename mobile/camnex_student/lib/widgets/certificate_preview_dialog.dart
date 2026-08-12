import 'package:flutter/material.dart';

import '../models/school_reward.dart';

void showCertificatePreview(

  BuildContext context,
  SchoolReward reward,

){

  showDialog(

    context: context,

    builder: (_) {

      return AlertDialog(

        title: const Text(
          "Certificate Preview",
        ),

        content: SizedBox(

          width: 500,

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              const Icon(
                Icons.picture_as_pdf,
                size: 90,
                color: Colors.red,
              ),

              const SizedBox(height: 20),

              Text(
                reward.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                reward.date,
              ),

              Text(
                reward.certificateId,
              ),

            ],
          ),
        ),

        actions: [

          ElevatedButton(

            onPressed: () {},

            child: const Text(
              "Download PDF",
            ),
          ),

          TextButton(

            onPressed: (){
              Navigator.pop(context);
            },

            child: const Text(
              "Close",
            ),
          ),

        ],
      );
    },
  );
}