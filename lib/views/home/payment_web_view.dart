import 'package:data_boot/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:data_boot/core/app_colors.dart';
import 'package:data_boot/core/resources/storage_keys.dart';
import 'package:data_boot/utils/utils_export.dart';

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
  final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();

  bool loading = false;
  int progress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          // onProgress: (value) {
          //   setState(() {
          //     loading = value < 100;
          //   });
          // },
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
        appBar: AppBar(title: Text(PrefStoreKeys.appName), backgroundColor: AppColors.primary,),
        body: loading
            ? Center(child: SizedBox(width: 200, height: 5, child: LinearProgressIndicator()))
            : WebViewWidget(controller: controller),
      ),
    );
  }

  showSuccessPay(){
    return showDialog(context: context, builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 100,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    border: Border.all(color: AppColors.primary, width: 3)
                ),
                child: Icon(Icons.check_circle_sharp, size: 100,),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30 ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).cardColor
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Excellent 🤗', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  const SizedBox(height: 15,),
                  Text('You have successfully fund your wallet and funds has been credited to your wallet.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                  const SizedBox(height: 15,),
                  AppBtn(onPressed: (){
                    Get.back();
                    Get.back();
                    acc.getBalance();
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
            const SizedBox(height: 15,),
            Text('Payment failed, try again later'),
            const SizedBox(height: 15,),

            AppBtn(onPressed: (){
              Get.back();
              Get.back();
            }, label: 'Failed', isDel: true,)
          ],
        ),
      );
    });
  }
}
