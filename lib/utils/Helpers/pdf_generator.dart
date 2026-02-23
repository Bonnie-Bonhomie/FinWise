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

  Future<void> generatePdfAndShare() async {
    final pdf = pw.Document();

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
                '200.00',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),

              rowTile('Reference', 'ghNNJHIOLkjOIP100203090i98'),
              pw.Divider(),
              rowTile('Payment Type', 'Airtime Recharge'),
              pw.Divider(),
              rowTile('Provider', 'Airtel'),
              pw.Divider(),
              rowTile('Narration', 'AIrtime purchase for 09076892973'),
              pw.Divider(),
              rowTile('Date', '7th Feb, 2026'),
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
