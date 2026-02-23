import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReceiptImage extends StatelessWidget {
  ReceiptImage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(key: receiptKey, child: child);
  }

  final GlobalKey receiptKey = GlobalKey();

}

class ImageGenerationService{

  final GlobalKey imageKey;
  ImageGenerationService(this.imageKey);


  Future<File> captureReceipt() async{
    RenderRepaintBoundary repaintBdry =
    imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await repaintBdry.toImage(pixelRatio: 3.0);

    //Import the typed_data package
    ByteData? byteData = (await image.toByteData(format: ui.ImageByteFormat.png)) ;
    //Nullity check
    if(byteData == null){
      throw Exception('Failed to load Image');
    }

    final bytes = byteData.buffer.asUint8List();

    final dir = await getTemporaryDirectory();

    File file = File('${dir.path}/receipt.png');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<void> shareImage() async{
    final file = await captureReceipt();

    await Share.shareXFiles([XFile(file.path)], text: 'Transaction Receipt');
  }

}
