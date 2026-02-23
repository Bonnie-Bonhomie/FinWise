import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.dateControl,
    this.firstDate,
    this.lastDate,
    this.initialDate,
  });

  final TextEditingController dateControl;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

final dDay = DateTime.now();
final today = DateFormat('dd/MM/yyyy').format(dDay);
final onlyToday = DateTime(dDay.year, dDay.month, dDay.day);
final initDate = DateTime(2010, 12, 30);
final formatInit = DateFormat('dd-MM-yyyy').format(initDate);

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.dateControl,
      readOnly: true,
      decoration: InputDecoration(
        hintText: formatInit,
        filled: true,
        fillColor: AppColors.lightGreen,
        suffixIcon: CircleAvatar(
          radius: 3,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.date_range_outlined, color: AppColors.bgColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onTap: () {
        Future<void> selectDate() async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: widget.initialDate ?? DateTime(2010, 12, 30),

            //To make other days before today un selectable
            // firstDate: DateTime.now(),

            //To make other days before today un selectable
            // To avoid disabling day if the timezone is different
            // firstDate: onlyToday
            firstDate: widget.firstDate ?? DateTime(1960),
            lastDate: widget.lastDate ?? DateTime(2011),
          );
          if (picked != null) {
            setState(() {
              widget.dateControl.text = picked.toString().split(" ")[0];
            });
          }
        }

        selectDate();
      },
    );
  }
}
