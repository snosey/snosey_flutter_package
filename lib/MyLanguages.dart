import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MyLanguagesKeys {
  appName,
  language,
  ok,
  thisFieldRequired,
  loadingPleaseWait,
  appSlogan,
  price,
  priceError,
  notes,
  noResultsFound,
  intro,
  token,
  reports,
  wallet,
  email,
  emailError,
  orders,
  phones,
  paymentWay,
  cash,
  visa,
  addNewAddress,
  isAddressBanha,
  addressArea,
  addressStreetName,
  addressBuildName,
  addressFloorNumber,
  addressFlatNumber,
  addressNotes,
  addressPhone,
  addressPhone2,
  cantBeEmpty,
  address,
  chooseAddress,
  sendOrder,
  addMore,
  verification,
  enterCode,
  reSendCode,
  loginWithGoogle,
  forgetPassword,
  login,
  signup,
  welcomeApp,
  name,
  password,
  phoneNumber,
  searchHint,
  passwordHintError,
  phoneHintError,
  confirm,
  yes,
  no,
  count,
  continueOrder,
  addressNickName,
  favorite,
  areYouSure,
  advancedSearch,
  close,
  orderOnline,
  requestHasSent,
  searchHintOrders,
  itemDetailsHint,
  addToShoppingCart,
  shoppingCart,
  offerEnded,
  changeThemeNote,
  next,
  pressAgainToExit,
  noDataFound,
  cancel,
  news,
  applicationUpdate,
  features,
  map,
  foodCategory,
  branches,
  call,
  addRestaurant,
  darkModeOn,
  home,
  sortBy,
  offers,
  notifications,
  profile,
  setting,
  searchHintRest,
  serverError,
  newest,
  lowestPrice,
  highPrice,
  closeToMe,
  rate,
  recommended,
  abc,
  inviteFriends,
  facebook,
  aboutUs,
  rateUs,
  callCenter,
  shakawa,
  offerNews,
  gallery,
  menu,
  menuGallery,
  info,
  workingTime,
  deliveryTime,
  addToFaves,
  removedFromFaves
}

class MyLanguages extends Translations {
  Map<String, String> _arStrings = {};
  Map<String, String> _enStrings = {};

  static final _secondaryLanguage = 'ar';
  static final _primaryLanguage = 'en';

  @override
  Map<String, Map<String, String>> get keys {
    _addAppName();
    _addAppSlogan();
    _addString(key: MyLanguagesKeys.addressArea.toString(), arValue: 'المنطقه');
    _addString(
        key: MyLanguagesKeys.addNewAddress.toString(),
        arValue: 'اضف عنوان جديد');
    _addString(
        key: MyLanguagesKeys.addressBuildName.toString(),
        arValue: 'اسم او رقم المبني');
    _addString(
        key: MyLanguagesKeys.notes.toString(),
        arValue: 'ملاحظات');

    _addString(
        key: MyLanguagesKeys.thisFieldRequired.toString(),
        arValue: 'هذا الحقل مطلوب');

    _addString(
        key: MyLanguagesKeys.addToFaves.toString(),
        arValue: 'تمت الاضافة الى المفضلة');
    _addString(
        key: MyLanguagesKeys.email.toString(), arValue: 'البريد الالكتروني');
    _addString(
        key: MyLanguagesKeys.emailError.toString(),
        arValue: 'البريد الالكتروني غير صحيح');
    _addString(
        key: MyLanguagesKeys.removedFromFaves.toString(),
        arValue: 'تم الحذف من المفضلة');
    _addString(key: MyLanguagesKeys.phones.toString(), arValue: 'الأرقام');

    _addString(
        key: MyLanguagesKeys.addressFlatNumber.toString(),
        arValue: 'رقم الشقه');
    _addString(
        key: MyLanguagesKeys.addressFloorNumber.toString(),
        arValue: 'رقم الطابق');
    _addString(
        key: MyLanguagesKeys.addressPhone.toString(), arValue: 'رقم الشقه');
    _addString(
        key: MyLanguagesKeys.addressPhone2.toString(),
        arValue: 'رقم الهاتف الاحتياطي ( اختياري )');
    _addString(
        key: MyLanguagesKeys.addressNotes.toString(), arValue: 'ملاحظات اخرى');
    _addString(
        key: MyLanguagesKeys.addressStreetName.toString(),
        arValue: 'اسم الشارع');
    _addString(
        key: MyLanguagesKeys.isAddressBanha.toString(),
        arValue: 'هل العنوان داخل بنها ؟');
    _addString(
        key: MyLanguagesKeys.addressNickName.toString(),
        arValue: 'منزلي - مكان العمل - الخ... ');
    _addString(key: MyLanguagesKeys.favorite.toString(), arValue: 'المفضلة');
    _addString(key: MyLanguagesKeys.price.toString(), arValue: 'السعر');
    _addString(key: MyLanguagesKeys.priceError.toString(), arValue: 'السعر غير صحيح');


    _addString(
        key: MyLanguagesKeys.applicationUpdate.toString(),
        arValue: 'برجاء تحديث البرنامج لتتمكن من استخدام اخر المميزات');
    _addString(key: MyLanguagesKeys.branches.toString(), arValue: 'الفروع');
    _addString(
        key: MyLanguagesKeys.foodCategory.toString(), arValue: 'أقسام الأكل');
    _addString(
        key: MyLanguagesKeys.continueOrder.toString(), arValue: 'تأكيد الطلب');
    _addString(key: MyLanguagesKeys.news.toString(), arValue: 'اخبار');
    _addString(key: MyLanguagesKeys.ok.toString(), arValue: 'حسنا');
    _addString(
        key: MyLanguagesKeys.paymentWay.toString(), arValue: 'طريقة الدفع');
    _addString(key: MyLanguagesKeys.cash.toString(), arValue: 'نقدي');
    _addString(key: MyLanguagesKeys.visa.toString(), arValue: 'فيزا ( قريبا )');
    _addString(key: MyLanguagesKeys.features.toString(), arValue: 'المميزات');
    _addString(
        key: MyLanguagesKeys.workingTime.toString(), arValue: 'مواعيد العمل:');
    _addString(key: MyLanguagesKeys.cancel.toString(), arValue: 'الغاء');
    _addString(
        key: MyLanguagesKeys.deliveryTime.toString(), arValue: 'زمن التوصيل');
    _addString(key: MyLanguagesKeys.login.toString(), arValue: 'تسجيل دخول');
    _addString(key: MyLanguagesKeys.call.toString(), arValue: 'اتصال');
    _addString(
        key: MyLanguagesKeys.offerEnded.toString(), arValue: 'تم انتهاء العرض');
    _addString(key: MyLanguagesKeys.map.toString(), arValue: 'الخريطه');
    _addString(
        key: MyLanguagesKeys.offerNews.toString(), arValue: 'عروض و اخبار');
    _addString(key: MyLanguagesKeys.gallery.toString(), arValue: 'صور');
    _addString(key: MyLanguagesKeys.menu.toString(), arValue: 'المنيو');
    _addString(
        key: MyLanguagesKeys.menuGallery.toString(), arValue: 'منيو و صور');
    _addString(key: MyLanguagesKeys.info.toString(), arValue: 'ارقام و بيانات');
    _addString(key: MyLanguagesKeys.wallet.toString(), arValue: 'المحفظة');
    _addString(key: MyLanguagesKeys.close.toString(), arValue: 'اغلاق');
    _addString(
        key: MyLanguagesKeys.orderOnline.toString(), arValue: 'اطلب اونلاين');
    _addString(key: MyLanguagesKeys.home.toString(), arValue: 'الرئيسية');
    _addString(
        key: MyLanguagesKeys.noResultsFound.toString(),
        arValue: 'لا يوجد نتائج');

    _addString(key: MyLanguagesKeys.sortBy.toString(), arValue: 'رتب ب');
    _addString(key: MyLanguagesKeys.offers.toString(), arValue: 'عروض');
    _addString(key: MyLanguagesKeys.notifications.toString(), arValue: 'اخبار');
    _addString(key: MyLanguagesKeys.profile.toString(), arValue: 'صفحتي');
    _addString(key: MyLanguagesKeys.setting.toString(), arValue: 'اعدادات');
    _addString(key: MyLanguagesKeys.addMore.toString(), arValue: 'اضف المزيد');
    _addString(
        key: MyLanguagesKeys.serverError.toString(),
        arValue: 'حدث خطأ, برجاء المحاوله لاحقا');
    _addString(
        key: MyLanguagesKeys.searchHintRest.toString(),
        arValue: 'اكتب هنا للبحث..');
    _addString(
        key: MyLanguagesKeys.searchHintOrders.toString(),
        arValue: 'ابحث برقم الطلب او رقم الهاتف');
    _addString(
        key: MyLanguagesKeys.searchHint.toString(), arValue: 'ابحث بالاسم');
    _addString(key: MyLanguagesKeys.closeToMe.toString(), arValue: 'الأقرب');
    _addString(key: MyLanguagesKeys.recommended.toString(), arValue: 'المميز');
    _addString(key: MyLanguagesKeys.rate.toString(), arValue: 'التقيم');
    _addString(key: MyLanguagesKeys.newest.toString(), arValue: 'الأحدث');
    _addString(key: MyLanguagesKeys.abc.toString(), arValue: 'الاسم');
    _addString(key: MyLanguagesKeys.orders.toString(), arValue: 'طلبات');
    _addString(
        key: MyLanguagesKeys.darkModeOn.toString(),
        arValue: 'تفعيل الوضع الداكن');
    _addString(
        key: MyLanguagesKeys.addRestaurant.toString(), arValue: 'اضافة مطعم');
    _addString(key: MyLanguagesKeys.next.toString(), arValue: 'متابعه');
    _addString(
        key: MyLanguagesKeys.verification.toString(),
        arValue: 'تأكيد رقم الهاتف');
    _addString(
        key: MyLanguagesKeys.shakawa.toString(), arValue: 'شكاوى و اقتراحات');
    _addString(
        key: MyLanguagesKeys.callCenter.toString(), arValue: 'الدعم الفني');
    _addString(
        key: MyLanguagesKeys.rateUs.toString(), arValue: 'تقييم التطبيق');
    _addString(
        key: MyLanguagesKeys.sendOrder.toString(), arValue: 'ارسال الطلب');
    _addString(key: MyLanguagesKeys.address.toString(), arValue: 'العنوان');
    _addString(key: MyLanguagesKeys.count.toString(), arValue: 'العدد');
    _addString(key: MyLanguagesKeys.confirm.toString(), arValue: 'تأكيد');
    _addString(
        key: MyLanguagesKeys.forgetPassword.toString(),
        arValue: 'نسيت كلمة السر؟');
    _addString(
        key: MyLanguagesKeys.loginWithGoogle.toString(),
        arValue: 'تسجيل دخول بحساب جوجل');
    _addString(
        key: MyLanguagesKeys.inviteFriends.toString(), arValue: 'دعوة اصدقاء');
    _addString(
        key: MyLanguagesKeys.facebook.toString(),
        arValue: 'تابعنا على الفيسبوك');
    _addString(key: MyLanguagesKeys.aboutUs.toString(), arValue: 'من نحن ؟');
    _addString(
        key: MyLanguagesKeys.noDataFound.toString(),
        arValue: 'نأسف, لا يوجد نتائج حاليا');
    _addString(
        key: MyLanguagesKeys.cantBeEmpty.toString(),
        arValue: 'يجب ملئ البيانات المطلوبه');
    _addString(
        key: MyLanguagesKeys.changeThemeNote.toString(),
        arValue: 'يمكنك تغير الوضع من الاعدات في اي وقت');
    _addString(
        key: MyLanguagesKeys.pressAgainToExit.toString(),
        arValue: 'اضغط رجوع مره اخرى للخروج');
    _addString(
        key: MyLanguagesKeys.requestHasSent.toString(),
        arValue: 'تم ارسال طلبك بنجاح');
    _addString(
        key: MyLanguagesKeys.highPrice.toString(),
        arValue: 'السعر: من الاكثر للأقل');
    _addString(
        key: MyLanguagesKeys.lowestPrice.toString(),
        arValue: 'السعر: من الاقل للأكثر');
    _addString(
        key: MyLanguagesKeys.advancedSearch.toString(), arValue: 'بحث متقدم');
    _addString(
        key: MyLanguagesKeys.addToShoppingCart.toString(),
        arValue: 'اضف الى قائمة التسوق');
    _addString(
        key: MyLanguagesKeys.shoppingCart.toString(), arValue: 'قائمة التسوق');
    _addString(
        key: MyLanguagesKeys.itemDetailsHint.toString(),
        arValue: 'لو عايز تضيف ملحوظه .. اكتب هنا');
    _addString(key: MyLanguagesKeys.yes.toString(), arValue: 'نعم');
    _addString(key: MyLanguagesKeys.no.toString(), arValue: 'لا');
    _addString(key: MyLanguagesKeys.reports.toString(), arValue: 'تقارير');
    _addString(
        key: MyLanguagesKeys.signup.toString(), arValue: 'تسجيل حساب جديد');
    _addString(key: MyLanguagesKeys.name.toString(), arValue: 'الاسم');
    _addString(
        key: MyLanguagesKeys.welcomeApp.toString(), arValue: 'اهلا بك في ');
    _addString(
        key: MyLanguagesKeys.password.toString(),
        arValue: 'كلمة المرور');
    _addString(
        key: MyLanguagesKeys.phoneNumber.toString(), arValue: 'رقم الهاتف');
    _addString(
        key: MyLanguagesKeys.phoneHintError.toString(),
        arValue: 'رقم الهاتف غير صحيح');
    _addString(
        key: MyLanguagesKeys.passwordHintError.toString(),
        arValue: ' كلمة المرور يجب الا تقل عن ٦ ارقام او حروف');
    _addString(
        key: MyLanguagesKeys.enterCode.toString(),
        arValue: 'سيتم ارسال الكود الى رقم الهاتف');
    _addString(
        key: MyLanguagesKeys.chooseAddress.toString(),
        arValue: 'اختر عنوان التوصيل');
    _addString(
        key: MyLanguagesKeys.reSendCode.toString(),
        arValue: 'اعد ارسال الكود مره اخرى');

    return {_primaryLanguage: _enStrings, _secondaryLanguage: _arStrings};
  }

  _addString({required String key, String? enValue, String? arValue}) {
    _enStrings[key] = enValue ?? arValue!;
    if (arValue != null) _arStrings[key] = arValue;
  }

  _addAppName() {
    String arValue = "";
    String enValue =
        ""; /*
    MyFlavorConfig myFlavorConfig = Get.find();
    switch (myFlavorConfig.appNameEnum) {
      case AppNameEnum.Banha:
        arValue = "مطاعم بنها";
        enValue = "Banha Restaurants";
        break;
    }*/
    _addString(
        key: MyLanguagesKeys.appName.toString(),
        enValue: "Engiz",
        arValue: "انجز");
  }

  _addAppSlogan() {
    String arValue = "";
    String enValue = "";
    // MyFlavorConfig myFlavorConfig = Get.find();
    // switch (myFlavorConfig.appNameEnum) {
    //   case AppNameEnum.Banha:
    //     arValue = "المنيو بين ايديك";
    //     enValue = "The menu is in your hands";
    //     break;
    // }
    _addString(
        key: MyLanguagesKeys.appSlogan.toString(),
        enValue: enValue,
        arValue: arValue);
  }

  static changeAppLanguage() {
    SharedPreferences.getInstance().then((pref) {
      if (Get.locale!.languageCode == MyLanguages._primaryLanguage) {
        pref.setString(MyLanguagesKeys.language.toString(),
            MyLanguages._secondaryLanguage);
        Get.updateLocale(Locale(MyLanguages._secondaryLanguage));
      } else {
        pref.setString(
            MyLanguagesKeys.language.toString(), MyLanguages._primaryLanguage);
        Get.updateLocale(Locale(MyLanguages._primaryLanguage));
      }
    });
  }
}
