import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage>
    with WidgetsBindingObserver {
  late MobileScannerController controller;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    WidgetsBinding.instance.addObserver(this);
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      // Permission granted
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        if (controller.value.isInitialized) {
          controller.start();
        }
        return;
      case AppLifecycleState.inactive:
        if (controller.value.isInitialized) {
          controller.stop();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مسح التذكرة')),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              if (!_isScanning) return;

              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  setState(() => _isScanning = false);
                  _handleScan(barcode.rawValue!);
                  break; // Process only first valid code
                }
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.crop_free, color: Colors.white, size: 40),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.crop_free, color: Colors.white, size: 40),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleScan(String code) {
    // Show dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('تم مسح الرمز'),
        content: Text('الرمز: $code\n\nيتم التحقق من التذكرة...'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _isScanning = true);
            },
            child: const Text('إغلاق'),
          ),
          ElevatedButton(
            onPressed: () {
              // Verify logic here
              Navigator.pop(context);
              setState(() => _isScanning = true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم التحقق بنجاح (تجريبي)')),
              );
            },
            child: const Text('تحقق (تجريبي)'),
          ),
        ],
      ),
    );
  }
}
