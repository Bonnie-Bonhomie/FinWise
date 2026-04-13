import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/models/tv_model.dart';
import 'package:fin_wise/data/repositories/CategoriesRepo/television_repo.dart';
import 'package:fin_wise/utils/Helpers/loader_helper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class TelevisionCtrl extends GetxController{

  final TelevisionRepo repo;
  TelevisionCtrl(this.repo);

  String error = '';
  var tvRecipt = [];

  var availableTv =[
    TvModel(name: 'DSTV Subscription', abbrev: 'DSTV', description: 'Share the joy this season with DSTv, your home of drama series and football'),

    TvModel(name: 'GoTV', abbrev: 'GoTV', description: 'Share the joy this season with GoTv, your home of drama series and football'),
    TvModel(name: 'Startimes Payment', abbrev: 'STIM', description: 'Share the joy this season with STIMTv, your home of drama series and football'),
    TvModel(name: 'DSTV Box Office Wallet TopUp', abbrev: 'BOX', description: 'Share the joy this season with DSTv, your home of drama series and football'),
    TvModel(name: 'TSTV', abbrev: 'TSTV', description: 'Share the joy this season with TSTv, your home of drama series and football'),
    TvModel(name: 'African Cable Television (ACTV) Subscription', abbrev: 'ACTV', description: 'Share the joy this season with ACTv, your home of drama series and football'),
    TvModel(name: 'Cable Africa Network TV (CableTV)', abbrev: 'CNTV', description: 'Share the joy this season with CNTv, your home of drama series and football'),
    TvModel(name: 'Infinity TV Payments', abbrev: 'ITV', description: 'Share the joy this season with ITv, your home of drama series and football'),
  ].obs;

  var leftService = [
    TvServiceModel(title: 'Yanga', amount: '6000', duration: '1'),
    TvServiceModel(title: 'Compact', amount: '8000', duration: '1'),
    TvServiceModel(title: 'Stream', amount: '9000', duration: '1'),
    TvServiceModel(title: 'Premium', amount: '10000', duration: '1'),
  ];
  var rightService = [
    TvServiceModel(title: 'Padi', amount: '7000', duration: '1'),
    TvServiceModel(title: 'Compact Plus', amount: '8000', duration: '1'),
    TvServiceModel(title: 'Confam', amount: '7000', duration: '1'),
  ];
  var premiumService = [
    TvServiceModel(title: 'Premium', amount: '10000', duration: '1'),
    TvServiceModel(title: 'Padi', amount: '15000', duration: '2'),
    TvServiceModel(title: 'Padi', amount: '20000', duration: '3'),
    TvServiceModel(title: 'Padi', amount: '20000', duration: '4'),
  ];


    Future<void> buyTvService({
    required double amount,
      required int smartcard
}) async{

    try{
      await runWithLoader(() async{
        final result = await repo.buyTv(amount: amount, smartcard: smartcard);

        if(DataState == DataSuccess && result.data['status'] == 'success'){
          tvRecipt = result.data;
        }else{
          error = 'Unable to Complete transaction';
          CustomSnackbar.showSnackbar(message: error, title: 'Oops');
        }
      });
    }catch(e){
      print(e.toString());
    }
    }


}