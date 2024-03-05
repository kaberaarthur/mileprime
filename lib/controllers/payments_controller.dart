import 'package:get/get.dart';

import '../config/app_icons.dart';
import '../config/app_strings.dart';

class PaymentsController extends GetxController {
  List<String> paymentMethodImage = [
    AppIcons.paypalIcon,
    AppIcons.visaIcon,
    AppIcons.netbankingIcon,
    AppIcons.upiIcon,
    AppIcons.googlePayIcon,
  ];

  List<String> paymentMethod = [
    AppStrings.payPal,
    AppStrings.debitCreditCard,
    AppStrings.netbanking,
    AppStrings.upiPayment,
    AppStrings.googlePay,
  ];
}