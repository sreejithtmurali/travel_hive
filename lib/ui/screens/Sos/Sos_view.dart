import 'package:flutter/material.dart';
//import 'package:medhub/ui/screens/Sosview/sosviewmodel.dart';
import 'package:stacked/stacked.dart';

import 'Sos_viewmodel.dart';

class SOSView extends StatelessWidget {
  const SOSView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SOSViewModel>.reactive(
      onViewModelReady: (m){
        m.init();
      },
      viewModelBuilder: () => SOSViewModel(),
      builder: (context, model, child) => Scaffold(

        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.red[50]!,
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (model.errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            model.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        if (model.errorMessage!.contains('settings'))
                          TextButton(
                            onPressed: () => model.errorMessage!.contains('permanently')
                                ? model.openAppSettings()
                                : model.openLocationSettings(),
                            child: const Text('Open Settings',
                                style: TextStyle(color: Colors.red)),
                          ),
                      ],
                    ),
                  ),
                const Text(
                  'Need Emergency Help?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select one of the options below to get immediate assistance',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                _buildEmergencyButton(
                  'Emergency Call',
                  Icons.phone_enabled,
                  model.makeEmergencyCall,
                  model.isBusy,
                ),
                const SizedBox(height: 20),
                _buildEmergencyButton(
                  'Call Ambulance',
                  Icons.local_hospital,
                  model.callAmbulance,
                  model.isBusy,
                ),
                // const SizedBox(height: 20),
                // _buildEmergencyButton(
                //   'Share Location with Trip Report',
                //   Icons.share_location,
                //   model.shareLocationWithMedicalHistory,
                //   model.isBusy,
                // ),
                const SizedBox(height: 20),
                _buildWhatsAppButton(
                  'Share via WhatsApp',
                  model.shareViaWhatsApp,
                  model.isBusy,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyButton(
      String label,
      IconData icon,
      VoidCallback onPressed,
      bool isBusy,
      ) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: isBusy
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(color: Colors.white),
        )
            : Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          shadowColor: Colors.red.withOpacity(0.5),
        ),
        onPressed: isBusy ? null : onPressed,
      ),
    );
  }

  Widget _buildWhatsAppButton(
      String label,
      VoidCallback onPressed,
      bool isBusy,
      ) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: isBusy
            ? const SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(color: Colors.white),
        )
            : Image.asset(
          'assets/images/whatsapp.png', // Make sure to add WhatsApp icon asset
          width: 40,
          height: 40,
          color: Colors.white,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          shadowColor: Colors.green.withOpacity(0.5),
        ),
        onPressed: isBusy ? null : onPressed,
      ),
    );
  }
}