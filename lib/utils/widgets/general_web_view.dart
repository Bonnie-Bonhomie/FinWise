import 'package:data_boot/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:data_boot/core/app_colors.dart';
import 'package:data_boot/core/resources/storage_keys.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GeneralWebView extends StatefulWidget {
  final String url;


  const GeneralWebView({
    super.key,
    required this.url,
  });

  @override
  State<GeneralWebView> createState() => _GeneralWebViewState();
}

class _GeneralWebViewState extends State<GeneralWebView> {
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
          onWebResourceError: (err){
            Get.defaultDialog(
              title: 'Error',
              middleText: err.description
            );
          }
          // onProgress: (value) {
          //   setState(() {
          //     loading = value < 100;
          //   });
          // },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(PrefStoreKeys.appName), backgroundColor: AppColors.primary,),
      body: loading
          ? Center(child: SizedBox(width: 200, height: 5, child: LinearProgressIndicator()))
          : WebViewWidget(controller: controller),
    );
  }

}
