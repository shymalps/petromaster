import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/config/theme/colors.dart';

class ContactInfoWidget extends StatelessWidget {
  final String email;
  final String phoneNumber;

  const ContactInfoWidget({
    Key? key,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);

  // Director contact details
  static const String directorPhone = '+919946098799';
  static const String directorEmail = 'admission@petromasteracademy.com';

  // Office addresses with contact numbers
  static const List<Map<String, String>> officeAddresses = [
    {
      'name': 'Main Office - Aluva',
      'address':
          '3rd floor, Arafa complex, Metro pillar 97, Opposite FIT, Thaikkatukara P.O. Aluva - 683106',
      'phone': '+91 8281810554',
    },
    {
      'name': 'Branch Office - Muringoor',
      'address':
          'Petromaster Academy, 1st floor, Bluemoon Tower Service Rd, signal, Muringoor, Muringur Vadakkummuri, Kerala 680307',
      'phone': '+91 88480 42204',
    },
  ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch $launchUri';
      }
    } catch (e) {
      print('Error making phone call: $e');
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri,
            mode: LaunchMode.externalNonBrowserApplication);
      } else {
        _showEmailOptions(email);
      }
    } catch (e) {
      print('Error sending email: $e');
      _showEmailOptions(email);
    }
  }

  Future<void> _openMaps(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final Uri mapsUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$encodedAddress');

    try {
      if (await canLaunchUrl(mapsUri)) {
        await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
      } else {
        _copyToClipboard(address);
        _showErrorDialog(
            'Maps', 'Unable to open maps. Address copied to clipboard.');
      }
    } catch (e) {
      _copyToClipboard(address);
      _showErrorDialog(
          'Maps', 'Unable to open maps. Address copied to clipboard.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),

          // Director Contact Section
          _buildSectionHeader('Director Contact', Icons.person_2),
          const SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.phone,
            label: 'Director Phone',
            value: directorPhone,
            onTap: () => _makePhoneCall(directorPhone),
            backgroundColor: AppColors.primary,
          ),
          const SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.email,
            label: 'Admission Email',
            value: directorEmail,
            onTap: () => _sendEmail(directorEmail),
            backgroundColor: AppColors.secondary,
          ),

          const SizedBox(height: 24),

          // General Contact Section
          _buildSectionHeader('General Contact', Icons.contact_phone),
          const SizedBox(height: 12),
          _buildContactItem(
            icon: Icons.phone,
            label: 'Phone',
            value: phoneNumber,
            onTap: () => _makePhoneCall(phoneNumber),
            backgroundColor: AppColors.primary,
          ),
          const SizedBox(height: 12),
          // _buildContactItem(
          //   icon: Icons.email,
          //   label: 'Email',
          //   value: email,
          //   onTap: () => _sendEmail(email),
          //   backgroundColor: AppColors.secondary,
          // ),

          const SizedBox(height: 24),

          // Office Addresses Section
          _buildSectionHeader('Our Offices', Icons.location_on),
          const SizedBox(height: 12),

          ...officeAddresses
              .map((office) => Column(
                    children: [
                      _buildOfficeCard(office),
                      const SizedBox(height: 16),
                    ],
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.lightGrey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: backgroundColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.fontcolor,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficeCard(Map<String, String> office) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.business,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  office['name']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Address
          GestureDetector(
            onTap: () => _openMaps(office['address']!),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      office['address']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.fontcolor,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.open_in_new,
                    color: AppColors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Phone
          GestureDetector(
            onTap: () => _makePhoneCall(office['phone']!),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      office['phone']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.fontcolor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.call,
                    color: AppColors.grey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmailOptions(String email) {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Email Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.copy,
                    color: AppColors.secondary,
                  ),
                ),
                title: const Text('Copy Email Address'),
                subtitle: Text(email),
                onTap: () {
                  _copyToClipboard(email);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.open_in_new,
                    color: AppColors.primary,
                  ),
                ),
                title: const Text('Try Opening Email App'),
                subtitle: const Text('Attempt to open default email client'),
                onTap: () {
                  Navigator.pop(context);
                  _tryOpenEmailApp(email);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Future<void> _tryOpenEmailApp(String email) async {
    try {
      // Try different email URL formats
      final List<Uri> emailUris = [
        Uri.parse('mailto:$email'),
        Uri.parse('mailto:$email?subject=&body='),
        Uri(scheme: 'mailto', path: email),
      ];

      for (Uri uri in emailUris) {
        try {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
            return;
          }
        } catch (e) {
          continue;
        }
      }

      _showErrorDialog('Email',
          'No email app found. The email address has been copied to clipboard.');
      _copyToClipboard(email);
    } catch (e) {
      _showErrorDialog('Email',
          'Unable to open email app. The email address has been copied to clipboard.');
      _copyToClipboard(email);
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              color: AppColors.fontcolor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));

    // Show success message
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('$text copied to clipboard'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
