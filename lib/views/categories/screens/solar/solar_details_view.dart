import 'package:fin_wise/controllers/categoryCtrl/market_ctrl.dart';
import 'package:fin_wise/data/models/product_model.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controller_exports.dart';

class SolarDetailsView extends StatefulWidget {
  final ProductModel product;
  const SolarDetailsView({super.key, required this.product});

  @override
  State<SolarDetailsView> createState() => _SolarDetailsViewState();
}

class _SolarDetailsViewState extends State<SolarDetailsView> {

  final ScrollController _controller = ScrollController();
  final loader = Get.find<LoaderController>();
  final ctrl = Get.find<MarketCtrl>();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      setState(() {
        offset = _controller.offset;
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    final progress = (offset / 150).clamp(0.0, 1.0);
    // Move from left (20) to center
    final left = (20 + offset).clamp(
      0.0,
      (screenWidth / 2) - 50,
    );
    final radius = 50 -(20 + progress);
    return Scaffold(
      body: LoaderWrapper(
        child: Material(
          child: Hero(
            tag: widget.product.name,
            child: CustomScrollView(
              controller: _controller,
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: progress > 0.8
                        ? Text(widget.product.name)
                        : null,
                    background: Image.network(
                      widget.product.coverImage,
                      errorBuilder: (context, __ ,___){
                        return Icon(Icons.image_outlined, size: 50,);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(widget.product.name, overflow: TextOverflow.ellipsis,),
                        subtitle:  Text(widget.product.shortDes),
                        trailing: Icon(Icons.favorite),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [

                            const SizedBox(height: 10,),

                            Row(
                              children: [
                                Text('Duration'), Text(widget.product.deliveryDurat),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                Text('Regular Price: ${widget.product.regularPrice}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                const SizedBox(width: 15,),
                                Text('${widget.product.discountPrice}% discount', style: TextStyle(fontSize: 14,)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Sale Price: ${widget.product.salePrice}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Text(widget.product.longDes),

                            // AppBtn(onPressed: (){}, label: 'Buy')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
