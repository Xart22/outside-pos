import 'package:flutter/services.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:get/get.dart';
import 'package:pos_getx/app/data/model/show_transaction_model.dart';
import 'package:pos_getx/app/data/repository/transaction_repository.dart';
import 'package:pos_getx/app/utils/rupiah_formater.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:image/image.dart' as img;

class HistoryDetailController extends GetxController {
  final transaction = ShowTransaction(
      type: '',
      orderDate: '',
      orderNumber: '',
      customerName: '',
      tableNumber: 0,
      subTotal: 0,
      discount: 0,
      total: 0,
      paymentMethod: '',
      cash: null,
      change: null,
      data: []).obs;
  final macPrinterCasier = '66:32:F9:51:03:BF';

  final isLoading = false.obs;

  void fetchTransactionDetails() async {
    isLoading.value = true;
    if (Get.arguments == null || Get.arguments['transaction_id'] == null) {
      print("🛑 No transaction ID provided in arguments.");
      return;
    }
    final data = await TransactionRepository.getTransactionById(
        Get.arguments['transaction_id'].toString());
    transaction.value = data;

    isLoading.value = false;
  }

  Future<void> _safePrint(String macAddress, List<int> bytes) async {
    try {
      await PrintBluetoothThermal.connect(macPrinterAddress: macAddress);
      bool isConnected = await PrintBluetoothThermal.connectionStatus;
      if (isConnected) {
        await PrintBluetoothThermal.writeBytes(bytes);
      } else {
        print("⚠️ Failed to connect to printer: $macAddress");
      }
    } catch (e) {
      print("🛑 Error printing to $macAddress: $e");
    } finally {
      // await PrintBluetoothThermal.disconnect;
    }
  }

  List<int> _buildRow(String label, String value, Generator generator) {
    return generator.row([
      PosColumn(text: label, width: 5),
      PosColumn(text: ':', width: 1),
      PosColumn(text: value, width: 6),
    ]);
  }

  Future<void> printKitchen(bool kitchen) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    var kitchenBytes = <int>[];

    // Header
    kitchenBytes += generator.reset();
    kitchenBytes += generator.text('================================');
    kitchenBytes += generator.text(
      kitchen ? 'Kitchen Order' : 'Bar Order',
      styles: PosStyles(align: PosAlign.center, fontType: PosFontType.fontB),
    );
    kitchenBytes +=
        generator.text('==========================================');

    // Order Info
    kitchenBytes += generator.text(
      'Order from: ${transaction.value.customerName}',
      styles: PosStyles(align: PosAlign.center),
    );
    kitchenBytes += generator.text(
      'Table: ${transaction.value.tableNumber}',
      styles: PosStyles(align: PosAlign.center),
    );
    kitchenBytes += generator.text(
      'Order Number: ${transaction.value.orderNumber}',
      styles: PosStyles(align: PosAlign.center),
    );
    kitchenBytes += generator.text(
      'Order Date: ${transaction.value.orderDate}',
      styles: PosStyles(align: PosAlign.center),
    );
    transaction.value.type == "DINE_IN"
        ? kitchenBytes += _buildRow('Type', 'Dine In', generator)
        : kitchenBytes += _buildRow('Type', 'Take Away', generator);
    if (transaction.value.type == "DINE_IN") {
      kitchenBytes += _buildRow(
          'Table Number', transaction.value.tableNumber.toString(), generator);
      kitchenBytes +=
          generator.text('==========================================');

      // Menu Items
      for (var item in transaction.value.data) {
        // Baris utama (qty + nama menu)
        kitchenBytes += generator.row([
          PosColumn(
            text: 'x${item.quantity}',
            width: 1,
            styles:
                PosStyles(align: PosAlign.left, fontType: PosFontType.fontB),
          ),
          PosColumn(
            text: item.menu,
            width: 11,
            styles:
                PosStyles(align: PosAlign.left, fontType: PosFontType.fontB),
          ),
        ]);

        // Baris tambahan untuk tiap opsi
        for (var variant in item.variants) {
          kitchenBytes += generator.row([
            PosColumn(text: '', width: 1), // kosong untuk indentasi
            PosColumn(
              text: '${variant.variantName} ${variant.name}',
              width: 11,
              styles: PosStyles(align: PosAlign.left),
            ),
          ]);
        }

        // Spasi antar item
        kitchenBytes += generator.feed(1);
      }

      // Footer
      kitchenBytes +=
          generator.text('==========================================');
      kitchenBytes += generator.feed(3);

      // Kirim ke printer
      await _safePrint(macPrinterCasier, kitchenBytes);
    }
  }

  Future<void> printReceipt({bool isCopy = false}) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    var bytes = <int>[];
    bytes += generator.reset();
    try {
      // === Generate Logo Image ===
      if (!isCopy) {
        final data = await rootBundle.load('assets/logo/oc.png');
        final image = img.decodeImage(data.buffer.asUint8List());

        if (image == null) {
          throw Exception("Logo image could not be decoded.");
        }

        final resized = img.copyResize(image, width: 200, height: 150);
        final safeImage = img.Image.from(resized);
        bytes += generator.imageRaster(safeImage, align: PosAlign.center);
        bytes += generator.feed(1);
        bytes += generator.text(
          'Jl. Pandanwangi, Cinunuk, Kec. Cileunyi',
          styles:
              PosStyles(align: PosAlign.center, fontType: PosFontType.fontB),
        );
        bytes += generator.text(
          '0822-9555-3530',
          styles:
              PosStyles(align: PosAlign.center, fontType: PosFontType.fontB),
        );
      }
      // === Generate Receipt Bytes ===
      bytes += generator.text('==========================================');

      // === Informasi Umum ===
      bytes += _buildRow('Date', transaction.value.orderDate, generator);
      bytes +=
          _buildRow('Order Number', transaction.value.orderNumber, generator);
      bytes += _buildRow('Customer', transaction.value.customerName, generator);
      transaction.value.type == "DINE_IN"
          ? bytes += _buildRow('Type', 'Dine In', generator)
          : bytes += _buildRow('Type', 'Take Away', generator);
      if (transaction.value.type == "DINE_IN") {
        bytes += _buildRow('Table Number',
            transaction.value.tableNumber.toString(), generator);
      }
      bytes += _buildRow('Cashier', 'Admin', generator);
      bytes += generator.text('==========================================');

      // === List Cart ===
      for (var item in transaction.value.data) {
        bytes += generator.row([
          PosColumn(text: 'x${item.quantity}', width: 1),
          PosColumn(text: item.menu, width: 6),
          PosColumn(
            text: formatRupiah(item.totalPrice),
            width: 5,
            styles: PosStyles(align: PosAlign.right),
          ),
        ]);
      }

      bytes += generator.text('==========================================');

      // === Payment Summary ===
      bytes += _buildRow(
          'Payment Method', transaction.value.paymentMethod, generator);
      bytes += _buildRow(
          'Subtotal', formatRupiah(transaction.value.subTotal), generator);
      bytes += _buildRow(
        'Discount',
        "${formatRupiah(transaction.value.discount)}",
        generator,
      );
      bytes += _buildRow(
        'Total',
        formatRupiah(transaction.value.total),
        generator,
      );

      if (transaction.value.paymentMethod == 'CASH') {
        bytes += _buildRow(
            'Cash',
            transaction.value.cash != null
                ? formatRupiah(transaction.value.cash!)
                : 'N/A',
            generator);
        bytes += _buildRow(
            'Change', formatRupiah(transaction.value.change ?? 0), generator);
      } else {
        bytes += _buildRow(
          'Reference Code',
          transaction.value.paymentProof ?? 'N/A',
          generator,
        );
      }

      // === Wifi Section ===
      // bytes += generator.text('==========================================');
      // bytes += generator.text('Wifi Outside',
      //     styles: PosStyles(align: PosAlign.center));
      // bytes += _buildRow('Username', userWifi, generator);
      // bytes += _buildRow('Password',
      //     customerNameController.text.replaceAll(' ', '_'), generator);
      // bytes += generator.text('==========================================');

      // // === Closing ===
      // bytes += generator.text('Thank you for your visit',
      //     styles: PosStyles(align: PosAlign.center));
      // bytes += generator.text('See you again',
      //     styles: PosStyles(align: PosAlign.center));
      // bytes += generator.feed(3);

      // === Print to Casier ===
      await _safePrint(macPrinterCasier, bytes);
    } catch (e) {
      print('🛑 Print failed: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTransactionDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
