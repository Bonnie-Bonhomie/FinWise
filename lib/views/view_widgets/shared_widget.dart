import 'package:fin_wise/controllers/controller_exports.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/data/models/product_model.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/categories/screens/MarketPlace/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/model_export.dart';
import '../../utils/utils_export.dart';
import '../view_export.dart';


class SharedWidget{

  static Widget serviceBox({
    required BuildContext context,
    required String title,
    required String amount,
    required VoidCallback onTap,
    String duration = '',
    IconData? icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: title, textSize: 16, textWeigh: FontWeight.bold),
            duration == ''
                ? SizedBox.shrink()
                : Container(
              padding: const EdgeInsets.all(3.4),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.orangeAccent.shade100.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: AppText(
                text: duration,
                textColor: Colors.orange,
                textWeigh: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  AppText(text: amount),
                  const Spacer(),
                  Icon(icon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
    this.color,
    required this.headingText,
    this.textAlign = TextAlign.center,
  });

  final String headingText;
  final Color? color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      headingText,
      style: TextStyle(
          color: color ?? Theme.of(context).textTheme.headlineMedium?.color,
          decoration: TextDecoration.none,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          // fontFamily: 'Poppins'
      ),
      textAlign: textAlign,
    );
  }
}


class BalanceCard extends StatelessWidget {
  BalanceCard({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor,
    required this.value
  });
  final String title;
  final IconData icon;
  final Color? iconColor;
  final double value;

  final HomeViewModel viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5.0),
      // color: ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? AppColors.primary),
          AppText(text: title),
          AppText(
            text: viewModel.formatCurrency(value),
            textColor: iconColor,
            textWeigh: FontWeight.bold,
            textSize: 18,
          ),
        ],
      ),
    );
  }
}


class AnimatedCard extends StatefulWidget {
  final Widget child;
  final int index;
  const AnimatedCard({super.key, required this.child, required this.index});
  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
        begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    final delay = Duration(milliseconds: widget.index * 80);
    Future.delayed(delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _fade,
    child: SlideTransition(position: _slide, child: widget.child),
  );
}



class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notify,
    required this.list,
    required this.index,
    required this.isRead,
    required this.markAsRead,
    required this.ctrl
  });
  final NotifyModel notify;
  final List<NotifyModel> list;
  final Function(int) markAsRead;
  final bool isRead;
  final int index;
  final NotifyCtrl ctrl;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(notify.id),

      confirmDismiss: (_) async {
        await ctrl.deleteNotify(notify.id, index, list);
        return true;
      },
      secondaryBackground: Container(
        color: AppColors.declined,
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete, color: Colors.white, size: 30),
      ),

      // background: Container(color: AppColors.primary, alignment: Alignment.centerLeft, child: Icon(Icons.done_all, size: 30, color: Colors.white),),
      background: Container(),
      direction: DismissDirection.endToStart,
      // confirmDismiss: (val) {return confirm();},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardColor,
        ),
        child: ListTile(
          tileColor: Theme.of(context).cardColor,
          onTap: () {
            ShowBottomInfo().showMoreInfo(context, notify);
            markAsRead(index);
          },
          leading: CircleAvatar(
            backgroundColor: AppColors.primary,
            child: isRead
                ? Icon(Icons.notifications_active, color: AppColors.bgColor,)
                : Icon(Icons.notifications_active_outlined,  color: AppColors.bgColor,),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText(
                  text: notify.title,
                  textWeigh: FontWeight.bold,
                  textSize: 15,
                ),
              ),
              Icon(Icons.circle, color: isRead? AppColors.primary: AppColors.declined, size: 10,)
            ],
          ),
          subtitle: Text(
            notify.description,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}



class MarketProdCard extends StatelessWidget {
  const MarketProdCard({super.key, required this.item});

  final ProductModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ProductDetails(product: item)),
      child: Hero(
        tag: item.name,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [

                  Container(
                    height: 150,
                    // width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(item.coverImage),
                        fit: BoxFit.cover,
                        onError: (__, ___) => Container(
                          color: Colors.grey,
                          child: Icon(Icons.image_outlined),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                      right: 5,
                      child: Icon(Icons.favorite, color: AppColors.declined,)),
                ],
              ),
              const SizedBox(height: 5.0,),

                  Text(item.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17), overflow: TextOverflow.ellipsis, maxLines: 2,),

              const SizedBox(height: 5.0,),
              Row(
                children: [
                  Text('Regular Price: ₦${item.regularPrice}', style: TextStyle(fontSize: 14, decoration: TextDecoration.overline)),
                  const Spacer(),
                  Text('Discount: ₦${item.discountPrice}', style: TextStyle(fontSize: 14,)),
                ],
              ),
              const SizedBox(height: 5.0,),
              Row(
                children: [
                  Text('Sale Price: ₦${item.salePrice}'),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}


