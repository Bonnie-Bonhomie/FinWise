import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/datePicker.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/constant.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> searchKey = GlobalKey<FormFieldState>();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int selected = 1;
    return Scaffold(
      body: PageContainer(
        topMargin: 5,
        topChild: Column(
          children: [
            CustomAppBar.header('Search', 10, () {}),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 40,
                child: TextFormField(
                  controller: searchCtrl,
                  key: searchKey,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hint: const Text('Search...'),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const  AppText(text: 'Categories', textWeigh: FontWeight.bold),
              SizedBox(
                height: 50,
                child: DropdownButtonFormField(
                  value: selected,
                  items: List.generate(Categories.values.length, (index) {
                    final name = Categories.values[index];

                    return DropdownMenuItem(
                      value: index,
                      child: Text(name.label),
                    );
                  }),
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: AppColors.primary,
                  ),
                  decoration: InputDecoration(
                    fillColor: AppColors.lightGreen,
                    filled: true,
                    hintText: 'Select Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  dropdownColor: AppColors.lightGreen,
                  onChanged: (val) {
                    selected = val!;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const AppText(text: 'Date', textWeigh: FontWeight.bold),
              const SizedBox(height: 5),
              DatePicker(dateControl: dateCtrl),
              const SizedBox(height: 20,),
              const AppText(text: 'Report', textWeigh: FontWeight.bold, textSize:  17,),
              Row(
                children: List.generate(2, (index) {
                  var selected = MoneyState.values[index];
                  final title = MoneyState.values[index].name;
                  return  Expanded(
                    child: RadioListTile(
                      value: selected,
                      groupValue: MoneyState.values[index],
                      activeColor: AppColors.primary,
                      onChanged: (val) {
                        // selected = val.toString();
                      },
                      title: Text(title),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              Align(
                  alignment: Alignment.center,
                  child: AppBtn(onPressed: () {}, label: 'Search')),
            ],
          ),
        ),
      ),
    );
  }
}
