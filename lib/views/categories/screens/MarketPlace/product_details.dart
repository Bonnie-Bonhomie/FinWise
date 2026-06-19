import 'package:fin_wise/controllers/categoryCtrl/market_ctrl.dart';
import 'package:fin_wise/core/validator/validator.dart';
import 'package:fin_wise/data/models/product_model.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/views/categories/service_export.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controller_exports.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ScrollController _controller = ScrollController();
  final loader = Get.find<LoaderController>();
  final ctrl = Get.find<MarketCtrl>();

  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final numberKey = GlobalKey<FormFieldState>();
  final addressKey = GlobalKey<FormFieldState>();
  final formKey = GlobalKey<FormState>();
  double offset = 0;
  int quantity = 1;

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
    final left = (20 + offset).clamp(0.0, (screenWidth / 2) - 50);
    final radius = 50 - (20 + progress);
    return Scaffold(
      body: LoaderWrapper(
        child: Material(
          child: Hero(
            tag: widget.product.name,
            child: Stack(
              children: [
                CustomScrollView(
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
                          errorBuilder: (context, __, ___) {
                            return Icon(Icons.image_outlined, size: 50);
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(widget.product.name),
                            subtitle: Text(widget.product.shortDes),
                            trailing: Icon(Icons.favorite),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Quantity in Kg'),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantity = quantity--;
                                          return;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.do_not_disturb_on_outlined,
                                    ),
                                  ),
                                  Text(quantity.toString()),
                                  IconButton(
                                    onPressed: () {
                                      setState(() => quantity = quantity++);
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Duration'),
                              Text(widget.product.deliveryDurat),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Text(
                                'Regular Price: ${widget.product.regularPrice}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                '${widget.product.discountPrice}% discount',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Sale Price: ${widget.product.salePrice}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(widget.product.longDes),
                          const SizedBox(height: 15),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Text('Delivery Address'),
                                TextFormField(
                                  maxLines: 5,
                                  minLines: 1,
                                  controller: addressCtrl,
                                  key: addressKey,
                                  validator: (val)=> Validator.validateText(val, 'Address'),
                                  onChanged: (val) => addressKey.currentState?.validate(),
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: 'Write your address',
                                    contentPadding:
                                        EdgeInsetsGeometry.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text('Phone number'),
                                NumberFormField(
                                  numberCtrl: numberCtrl,
                                  numberKey: numberKey,
                                  validator: (val) =>
                                      Validator.validateNumber(val!),
                                  onChanged: (val) => numberKey.currentState?.validate(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          AppBtn(
                            onPressed: () {
                              double amount = double.parse(
                                widget.product.salePrice,
                              );
                              if(formKey.currentState!.validate()){
                                loader.offLoading(() async {
                                  ConfirmBottomSheet().confirmBottomSheet(
                                    context,
                                    amount: amount,
                                    numberCtrl: numberCtrl,
                                    productName: 'Fish',
                                    action: (pin) async {
                                      await ctrl.buyProduct(
                                        productId: widget.product.id,
                                        deliveryAdd: addressCtrl.text,
                                        phone: numberCtrl.text,
                                        quantity: quantity,
                                        pin: pin,
                                      );
                                    },
                                  );
                                });
                              }else{
                                CustomSnackbar.warningSnack( 'Enter your address and phone number to continue');
                              }

                            },
                            label: 'Buy',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Positioned(
                  top: 200 - (120 * progress),
                  left: left,
                  child: CircleAvatar(
                    radius: radius,
                    backgroundImage: NetworkImage(widget.product.coverImage),
                    // errorBuilder: (context, __ ,___){
                    //   return Icon(Icons.image_outlined);
                    // },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
