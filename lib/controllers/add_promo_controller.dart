import 'package:get/get.dart';
import 'package:prime_taxi_flutter_ui_kit/config/app_strings.dart';

class AddPromoController extends GetxController {
  RxInt selectedOfferIndex = 0.obs;
  RxBool searchBoolean = false.obs;

  void selectOfferContainer(int index) {
    selectedOfferIndex.value = index;
  }

  List<String> promoOffer = [
    AppStrings.special25,
    AppStrings.discount30,
    AppStrings.discount40,
    AppStrings.special25,
    AppStrings.discount20,
  ];

  List<String> promoOfferSubtitle = [
    AppStrings.specialPromoOnlyToday,
    AppStrings.newUserSpecialPromo,
    AppStrings.specialPromoOnlyToday,
    AppStrings.specialPromoOnlyToday,
    AppStrings.specialPromoOnlyToday,
  ];
}