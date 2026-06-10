import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfGeneratorService {

  //Custom row tile
  pw.Widget rowTile(String title, String value) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(top: 5, bottom: 5),
      child: pw.Row(
        children: [
          pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.grey)),
          pw.Spacer(),
          pw.Text(value, style: pw.TextStyle( color: PdfColors.black)),
        ],
      ),
    );
  }

  Future<void> generatePdfAndShare(TransactionModel receipt) async {
    final pdf = pw.Document();
    final viewModel = HomeViewModel();
    final roboto = pw.Font.ttf(
      await rootBundle.load('Assets/fonts/Roboto-Regular.ttf')
    );
    final robotoBold = pw.Font.ttf(
        await rootBundle.load('Assets/fonts/Roboto-Bold.ttf')
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 15),

              // pw.Image(image: pw.AssetImage(PrefStoreKeys.appImage), height: 80, width: 80,),
              pw.Text(
                PrefStoreKeys.appName,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 25,
                    color: PdfColors.black
                ),
              ),
              pw.Text(
                'Transaction Receipt',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 25,
                    color: PdfColors.black
                ),
              ),
              pw.Text(
                'Amount',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 25,
                    color: PdfColors.black
                ),
              ),

              pw.Text(
                viewModel.formatCurrency(receipt.amount),
                style: pw.TextStyle(font: roboto, color: PdfColors.black),
              ),

              rowTile('Reference', receipt.referenceId),
              pw.Divider(),
              rowTile('Payment Type', receipt.modelableType),
              pw.Divider(),
              rowTile('Provider', receipt.modelableId.toUpperCase()),
              pw.Divider(),
              receipt.category == Categories.airtime || receipt.category == Categories.data? rowTile('Beneficiary', receipt.phoneNo): pw.SizedBox(),
              receipt.category == Categories.cable ? rowTile('Beneficiary', receipt.phoneNo): pw.SizedBox(),
              receipt.category == Categories.electricity ? rowTile('Meter Number', receipt.meterNo ?? 'null'): pw.SizedBox(),
              receipt.category == Categories.education ? rowTile('Token', receipt.token ?? 'null'): pw.SizedBox(),
              receipt.category == Categories.education ? rowTile('Pin', receipt.pin ?? 'null'): pw.SizedBox(),
              pw.Divider(),
              rowTile('Date', viewModel.formatDate(receipt.purchaseAt)),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text('Thank you for using our service!'),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: '${receipt.productRef}.pdf');
  }
}
