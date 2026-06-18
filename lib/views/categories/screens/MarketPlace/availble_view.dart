import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

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
