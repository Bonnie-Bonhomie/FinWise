import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentUrl;
  final String successUrl;
  final String failedUrl;

  const PaymentWebView({
    super.key,
    required this.paymentUrl,
    required this.failedUrl,
    required this.successUrl,
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController controller;

  bool loading = false;
  int progress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) {
            setState(() {
              loading = value < 100;
            });
          },
          onNavigationRequest: (request) {
            final url = request.url;
            print('Current ur: $url');
            print('Expected: ${widget.successUrl}');
            if (url.startsWith(widget.successUrl)) {

              showSuccessPay();
              return NavigationDecision.prevent;
            }

            if(url.startsWith(widget.failedUrl)){

              showFailPay();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? shouldPop = await showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(),
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Payment")),
        body: loading
            ? Center(child: LinearProgressIndicator())
            : WebViewWidget(controller: controller),
      ),
    );
  }

  showSuccessPay(){
    return showDialog(context: context, builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 50,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    border: Border.all(color: AppColors.darkGreen, width: 3)
                ),
                child: Icon(Icons.check_circle_sharp),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Excellent 🤗'),
                  const SizedBox(height: 10,),
                  Text('You have successfully fund your wallet and funds has been credited to your wallet.'),
                  const SizedBox(height: 10,),
                  AppBtn(onPressed: (){
                    Get.back();
                    Get.back();
                    Get.back();
                  }, label: 'Continue')
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  showFailPay(){
    return showDialog(context: context, builder: (context){
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Oops 😒'),
            Text('Payment failed, try again later'),
            CancelBtn(onPressed: (){
              Get.back();
              Get.back();
              Get.back();
            })
          ],
        ),
      );
    });
  }
}
