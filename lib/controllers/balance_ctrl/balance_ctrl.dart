import 'package:dio/dio.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/repositories/accountRepo/virtual_repo.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

import '../../data/models/model_export.dart';
import '../controller_exports.dart';

class AccBalanceCtrl extends GetxController {
  final AccountRepo repo;
  final StorageFile storage;

  AccBalanceCtrl(this.repo, this.storage);

  @override
  void onInit() {
    // TODO: implement onInit
    //   getBalance();
    super.onInit();
  }

  final AuthCtrl auth = Get.find<AuthCtrl>();

  var accountBalance = 0.00.obs;
  var dailyExpense = 0.00.obs;
  var monthlyExpense = 0.00.obs;
  var bonusBal = 0.00.obs;
  var totalExpense = 0.00.obs;
  var expense = 1000.00.obs;
  var income = 4000.45.obs;
  var spendingLimit = 2000.00.obs;
  var virtualAcc = ''.obs;

  var selectPay = 0.obs;

  RxBool isFilled = false.obs;
  RxBool loading = false.obs;
  RxBool loadingB = false.obs;

  var channelErr = ''.obs;
  var balanceErr = ''.obs;

  var paymentGateWay = <BankModel>[].obs;

  double get spentPercent => expense.value / spendingLimit.value;

  void fillVirtualAcc(String accNumber) {
    virtualAcc.value = accNumber.toString();
  }

  void fillBalance() {
    accountBalance.value = double.parse(auth.userWallet?.accBalance ?? '0.00');
  }

  void fillAmount(double value) {
    isFilled.value = value >= 100;
  }

  double formatDouble(String amount) {
    double formated = double.parse(amount);
    return formated;
  }

  //Get bonus balance function
  Future<void> getBonusBal() async {
    if (loadingB.value) return;
    try {
      loadingB.value = true;
      final String? token = await storage.getToken();

      if (token == null) {
        CustomSnackbar.warningSnack('Unauthenticated');
      } else {
        final response = await repo.getBonusBal(token);
        if (response is DataSuccess) {
          if (response.data['status'] == true) {
            final data = response.data['data'];
            print(data);
            bonusBal.value = formatDouble((data['referralAmount'].toString()));
            dailyExpense.value = formatDouble(data['daily_spent'].toString());
            monthlyExpense.value = formatDouble(
              data['total_spent_amount_with_monthly'].toString(),
            );
            totalExpense.value = formatDouble(
              data['total_spent_amount'].toString(),
            );
          }
        } else if (response is DataFailed) {
          final err = response.exception;

          if (err is DioException) {
            print(err);
            //  Network issues
            if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout|| err.type == DioExceptionType.receiveTimeout) {
              CustomSnackbar.showSnackbar(
                message: 'No internet connection, when loading bonus',
              );
              return;
            }

            //  Server error
            final errData = err.response?.data;
            print(err.response?.data);

            if (errData != null && errData['message'] != null) {
              CustomSnackbar.showSnackbar(message: errData['message']);
            } else {
              CustomSnackbar.showSnackbar(
                message: 'Server error, Unable to load expenses',
              );
            }
          } else {
            CustomSnackbar.showSnackbar(
              message: 'Unknown error occurred, Unable to load expenses',
            );
          }
        }
      }
    } catch (e) {
      print(e);
      CustomSnackbar.showSnackbar(
        message: 'Something went wrong, Unable to load expenses',
      );
    } finally {
      loadingB.value = false;
    }
  }

  //Get bonus balance function

  ///Get balance function
  Future<void> getBalance() async {
    if (loading.value) return;
    try {
      loading.value = true;
      final String? token = await storage.getToken();

      if (token != null) {
        final response = await repo.getWallet(token);

        if (response is DataSuccess) {
          final data = response.data;
          print(data);
          if (data['status'] == true) {
            accountBalance.value = double.parse(data['data']['bal']);
          } else {
            balanceErr.value = '--';
          }
        } else if (response is DataFailed) {
          final err = response.exception;

          if (err is DioException) {
            //  Network issues
            if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout|| err.type == DioExceptionType.receiveTimeout) {
              balanceErr.value = 'No network ';
            }

            //  Server error
            final errData = err.response?.data;
            print(err.response?.data);

            print(errData);
            if (errData != null && errData['message'] != null) {
              balanceErr.value = '-.--';
            } else {
              balanceErr.value = '-.--';
            }
          }
        }
      }
    } catch (e) {
      print(e);
      balanceErr.value = '-.--';
    } finally {
      loading.value = false;
    }
  }

  ///End Get balance function

  ///get payment channels
  Future<void> getPayemntChannels() async {
    try {
      loading.value = true;
      final String? token = await storage.getToken();

      if (token != null) {
        final response = await repo.getPaymentChannel(token);

        if (response is DataSuccess) {
          final data = response.data;
          print(data);
          if (data['status'] == true) {
            List channels = data['data'];

            if (channels.isEmpty) {
              channelErr.value = 'Payment getway is unavailable';
            }
            final channel = channels.map((e) => BankModel.fromJson(e)).toList();
            paymentGateWay.assignAll(channel);
          } else {
            channelErr.value =
                'Unable to load available payment channel. Reload page';
          }
        } else if (response is DataFailed) {
          final err = response.exception;

          if (err is DioException) {
            //  Network issues
            if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout|| err.type == DioExceptionType.receiveTimeout) {
              channelErr.value = 'No internet connection';
            }

            //  Server error
            final errData = err.response?.data;
            print(err.response?.data);

            print(errData);
            if (errData != null && errData['message'] != null) {
              balanceErr.value = errData['message'];
            } else {
              channelErr.value =
                  'unable to load available channel, reload page';
            }
          }
        }
      }
    } catch (e) {
      print(e);
      channelErr.value = 'Something went wrong, reload';
    } finally {
      loading.value = false;
    }
  }   ///get payment channels

  ///get payment channels
  ///
  /// Make payment

  //generate virtual account function
  Future<void> paymentFunction(String method, amount, String url) async {
    try {
      final String? token = await storage.getToken();

      if (token == null) {
        CustomSnackbar.showSnackbar(message: 'Unauthenticated');
        return;
      }

      final response;
      if (method.toUpperCase() == 'GET') {
        response = await repo.getPaymentUrl(url, token, amount);

      } else {
        response = await repo.postPayment(url, token, amount);
      }

      if (response is DataSuccess) {
        if (response.data['status'] == true) {
          print(response.data);
        } else {
          CustomSnackbar.showSnackbar(
            message: 'Unable to generate virtual account',
          );
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        print(err);
        if (err is DioException) {
          //  Network issues
          if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout|| err.type == DioExceptionType.receiveTimeout) {
            CustomSnackbar.showSnackbar(title: 'No internet connection', message: 'Check your internet connection');
            return;
          }

          //  Server error
          final errData = err.response?.data;
          print(errData['message']);

          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message']);
          }

        } else {
          CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
        }
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(
        message: 'Something went wrong try again later',
        title: 'Oops',
      );
    }
  }

  //generate virtual account function

  //generate virtual account function
  Future<void> generateVirtual({
    required String fullname,
    required String phoneNumber,
    required String bvn,
    required String dob,
  })
  async {
    try {
      final response = await repo.generateVirtual(
        fullname: fullname,
        bvn: bvn,
        phoneNumber: phoneNumber,
        dob: dob,
      );

      if (response is DataSuccess) {
        if (response.data['status'] == true) {
          virtualAcc.value = response.data['accountNumber'];
        } else {
          CustomSnackbar.showSnackbar(
            message: 'Unable to generate virtual account',
          );
        }
      } else if (response is DataFailed) {
        final err = response.exception;

        if (err is DioException) {
          //  Network issues
          if (err.type == DioExceptionType.connectionError || err.type == DioExceptionType.connectionTimeout|| err.type == DioExceptionType.receiveTimeout) {
            CustomSnackbar.showSnackbar(message: 'No internet connection');
            return;
          }

          //  Server error
          final errData = err.response?.data;
          // print(err.response?.data);

          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message']);
          } else {
            CustomSnackbar.showSnackbar(
              message: 'Server error, try again later',
            );
          }
        } else {
          CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
        }
      }
    } catch (e) {
      CustomSnackbar.showSnackbar(
        message: 'Something went wrong try again later',
        title: 'Oops',
      );
    }
  }
  //generate virtual account function
}
