import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(topChild: CustomAppBar.header(title: 'Market Place', leftRight: 10), child: Column(
        children: [

        ],
      )),
    );
  }
}
