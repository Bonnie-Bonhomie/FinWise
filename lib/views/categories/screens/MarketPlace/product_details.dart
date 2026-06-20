import 'package:fin_wise/controllers/categoryCtrl/market_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/validator/validator.dart';
import 'package:fin_wise/data/models/product_model.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
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
  final viewModel = HomeViewModel();

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

    double regular = viewModel.parseAmount(widget.product.regularPrice);
    double sale = viewModel.parseAmount(widget.product.salePrice);
    double discount = viewModel.parseAmount(widget.product.discountPrice);

    final screenWidth = MediaQuery.of(context).size.width;

    final progress = (offset / 150).clamp(0.0, 1.0);
    // Move from left (20) to center
    final left = (20 + offset).clamp(0.0, (screenWidth / 2) - 50);
    final radius = 50 - (20 + progress);
    return Scaffold(
      body: LoaderWrapper(
        child: Hero(
          tag: widget.product.name,
          child: Stack(
            children: [
              CustomScrollView(
                controller: _controller,
                slivers: [
                  SliverAppBar(
                    leading: IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.arrow_back, color: AppColors.primary,)),
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
                    child: Card(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(widget.product.name,  style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(widget.product.shortDes),
                            trailing: Icon(Icons.favorite, color: AppColors.declined,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Regular Price: ${viewModel.formatCurrency(regular)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.lineThrough
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      'Discount Price: ${viewModel.formatCurrency(discount)}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Sale Price: ${viewModel.formatCurrency(sale)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text('Quantity in Kg', style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (quantity > 1) {
                                                quantity = quantity -1;
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
                                            setState(() => quantity = quantity +1);
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
                                    Text('Delivery Duration', style: TextStyle(fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Text(widget.product.deliveryDurat),
                                    const SizedBox(width: 15,)
                                  ],
                                ),

                                const SizedBox(height: 30),

                                    Text('Description: ${widget.product.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                    Text(widget.product.longDes),

                                const SizedBox(height: 15),
                                Card(
                                  borderOnForeground: true,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text('Delivery Address'),
                                          const SizedBox(height: 10),
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
                                          const SizedBox(height: 15,),
                                          Text('Phone number'),
                                          const SizedBox(height: 10,),
                                          PhoneNumberFormField(
                                            numberCtrl: numberCtrl,
                                            numberKey: numberKey,
                                            validator: (val) =>
                                                Validator.validateNumber(val!),
                                            onChanged: (val) => numberKey.currentState?.validate(),
                                          ),
                                          const SizedBox(height: 30,),
                                          AppBtn(
                                            onPressed: () {
                                              double price = double.parse(
                                                widget.product.salePrice,
                                              );
                                              double amount = price * quantity;

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
                                  ),
                                ),
                                const SizedBox(height: 15),

                              ],
                            ),
                          ),
                        ],
                      ),
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
    );
  }
}
