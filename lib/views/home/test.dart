import 'package:flutter/material.dart';

class AnimatedBottomSheet extends StatelessWidget {
  final bool isOpen;
  final bool focused;
  final Widget page;
  final Widget child;

  const AnimatedBottomSheet({
    super.key,
    required this.focused,
    required this.isOpen,
    required this.page,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        page,
        BottomSwitcher(isOpen: isOpen, focused: focused, child: child)
      ],
    );
  }
}

class BottomSwitcher extends StatelessWidget {
  final bool isOpen;
  final Widget child;
  final bool focused;

  const BottomSwitcher({
    super.key,
    required this.isOpen,
    required this.child,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOutQuad,
      child: isOpen
          ? Container(
              key: ValueKey('bottom-sheet'),
              color: Colors.green.withValues(alpha: 0.4),
              child: BottomChild(focused: focused, child: child),
            )
          : const SizedBox(),
    );
  }
}

class BottomChild extends StatelessWidget {
  final Widget child;
  final bool focused;

  const BottomChild({super.key, required this.child, required this.focused});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          // top: 200,
          bottom: focused ? 50 : 20,
          child: Container(
              // width: 300,
              child: child),
        ),
      ],
    );
  }
}




// Container bottomContent(VoidCallback onPressed, AccBalanceCtrl acc) {
//   return Container(
//     height: 250,
//     width: 320,
//     alignment: Alignment.center,
//     margin: const EdgeInsets.all(15),
//     padding: const EdgeInsets.all(15),
//     decoration: BoxDecoration(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: Form(
//       key: formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Row(
//             children: [
//               const AppText(text: 'Enter amount to fund', textSize: 20),
//               const Spacer(),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isOpen = false;
//                   });
//                   print(isOpen);
//                 },
//                 icon: const Icon(Icons.cancel_outlined),
//               ),
//             ],
//           ),
//           Container(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               children: [
//                 AppText(text: '₦', textSize: 20),
//                 Expanded(
//                   child: PriceFormField(
//                     numberCtrl: amountCtrl,
//                     hint: AppText(text: 'Enter amount to fund'),
//                     color: Colors.transparent,
//                     key: amountKey,
//                     onTap: () {
//                       setState(() {
//                         focused = true;
//                       });
//                     },
//                     validator: (val) => Validator.validatePrice(val!),
//                     onChanged: (val) => amountKey.currentState!.validate(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // AppText(text: 'Please enter amount you want to fund', textColor: Colors.red,),
//           Divider(color: AppColors.lightGreen, thickness: 3),
//           AppBtn(
//             onPressed: () {
//               if (formKey.currentState!.validate()) {
//                 setState(() {
//                   focused = false;
//                   isOpen = false;
//                 });
//                 onPressed();
//
//               } else {}
//               amountCtrl.text = '';
//               acc.selectPay.value = '';
//             },
//             label: 'Proceed to payment',
//           ),
//         ],
//       ),
//     ),
//   );
// }