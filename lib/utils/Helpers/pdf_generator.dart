import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGeneratorService {

  //Custom row tile
  pw.Widget rowTile(String title, String value) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(top: 5, bottom: 5),
      child: pw.Row(
        children: [
          pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Spacer(),
          pw.Text(value),
        ],
      ),
    );
  }

  Future<void> generatePdfAndShare(TransactionModel receipt) async {
    final pdf = pw.Document();
    final viewModel = HomeViewModel();
    final roboto = pw.Font.ttf(
      await rootBundle.load('Assets/fonts/Roboto-regular.ttf')
    );
    final robotoBold = pw.Font.ttf(
        await rootBundle.load('Assets/fonts/Roboto-regular.ttf')
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 15),

              // pw.Image(image: pw.AssetImage('Assets/logos/Vector.png'), height: 80, width: 80,),
              pw.Text(
                'FinWise',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              pw.Text(
                'Transaction Receipt',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              pw.Text(
                'Amount',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 25,
                ),
              ),

              pw.Text(
                viewModel.formatCurrency(receipt.amount),
                style: pw.TextStyle(font: robotoBold),
              ),

              rowTile('Reference', receipt.referenceId),
              pw.Divider(),
              rowTile('Payment Type', receipt.modelableType),
              pw.Divider(),
              rowTile('Provider', receipt.modelableId.toUpperCase()),
              pw.Divider(),
              rowTile('Beneficiary', receipt.phoneNo),
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

    await Printing.sharePdf(bytes: await pdf.save(), filename: 'receipt.pdf');
  }
}
