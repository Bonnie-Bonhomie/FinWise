import 'dart:io';

import 'package:fin_wise/data/models/profile_model.dart';
import 'package:fin_wise/data/repositories/profileRepo/edit_profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileCtrl extends GetxController{

  final EditProfileRepo repo;
  EditProfileCtrl(this.repo);

  final nameCtrl = TextEditingController();
  final numberCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final mailCtrl = TextEditingController();

  Rxn<ProfileModel> profile = Rxn<ProfileModel>();

  var loading = false.obs;

  Future<void> updateProfile({
    required String name, required String phone, required String dob, required String mail, File? img
}) async{
    try{
      loading.value = true;

      await repo.updateProfile(name: name, phone: phone, dob: dob, mail: mail, img: img);
      Get.snackbar('Success', 'Profile update successfully');
    }catch(e){
      Get.snackbar('Oops!', e.toString());
    }finally{
      loading.value = false;
    }
  }

  void setProfile(ProfileModel user){
    profile.value = user;

    nameCtrl.text = user.name;
    numberCtrl.text = user.phone;
    mailCtrl.text = user.mail;
    dobCtrl.text = user.dateOfBirth!;

  }
  @override
  void onClose() {
    nameCtrl.dispose();
    mailCtrl.dispose();
    numberCtrl.dispose();
    dobCtrl.dispose();

    super.onClose();
  }


  // // Image picker function and the control
  ImagePicker imagePicker = ImagePicker();

  final  picked = Rx<File?>(null);

  Future<void> selectImage() async {

    final selected = await imagePicker.pickImage(source: ImageSource.gallery);
    if(selected != null){
      picked.value = File(selected.path);
    }
    else{
      Get.snackbar("No image", "Select an Image");
    }
  }
}