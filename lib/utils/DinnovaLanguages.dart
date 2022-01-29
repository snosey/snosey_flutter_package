import 'package:get/get.dart';

enum DinnovaLanguagesKeys {
  language,
  ok,
  thisFieldRequired,
  loadingPleaseWait,
  price,
  priceError,
  notes,
  noResultsFound,
  intro,
  token,
  requestHasSent,
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
  name,
  password,
  phoneNumber,
  searchHint,
  passwordHintError,
  phoneHintError,
  confirm,
  yes,
  no,
  favorite,
  areYouSure,
  advancedSearch,
  close,
  changeThemeNote,
  next,
  pressAgainToExit,
  cancel,
  call,
  home,
  sortBy,
  notifications,
  profile,
  setting,
  serverError,
  rate,
  abc,
  inviteFriends,
  facebook,
  aboutUs,
  rateUs,
  callCenter,
  shakawa,
  info,
}

class DinnovaLanguages extends Translations {
  Map<String, String> _arStrings = {};
  Map<String, String> _enStrings = {};

  @override
  Map<String, Map<String, String>> get keys {
    _addString(
        key: DinnovaLanguagesKeys.addressArea.toString(), arValue: 'المنطقه');
    _addString(
        key: DinnovaLanguagesKeys.addNewAddress.toString(),
        arValue: 'اضف عنوان جديد');
    _addString(
        key: DinnovaLanguagesKeys.addressBuildName.toString(),
        arValue: 'اسم او رقم المبني');
    _addString(key: DinnovaLanguagesKeys.notes.toString(), arValue: 'ملاحظات');

    _addString(
        key: DinnovaLanguagesKeys.thisFieldRequired.toString(),
        arValue: 'هذا الحقل مطلوب');

    _addString(
        key: DinnovaLanguagesKeys.email.toString(),
        arValue: 'البريد الالكتروني');
    _addString(
        key: DinnovaLanguagesKeys.emailError.toString(),
        arValue: 'البريد الالكتروني غير صحيح');

    _addString(key: DinnovaLanguagesKeys.phones.toString(), arValue: 'الأرقام');

    _addString(
        key: DinnovaLanguagesKeys.addressFlatNumber.toString(),
        arValue: 'رقم الشقه');
    _addString(
        key: DinnovaLanguagesKeys.addressFloorNumber.toString(),
        arValue: 'رقم الطابق');
    _addString(
        key: DinnovaLanguagesKeys.addressPhone.toString(), arValue: 'رقم الشقه');
    _addString(
        key: DinnovaLanguagesKeys.addressPhone2.toString(),
        arValue: 'رقم الهاتف الاحتياطي ( اختياري )');
    _addString(
        key: DinnovaLanguagesKeys.addressNotes.toString(),
        arValue: 'ملاحظات اخرى');
    _addString(
        key: DinnovaLanguagesKeys.addressStreetName.toString(),
        arValue: 'اسم الشارع');

    _addString(
        key: DinnovaLanguagesKeys.favorite.toString(), arValue: 'المفضلة');
    _addString(key: DinnovaLanguagesKeys.price.toString(), arValue: 'السعر');
    _addString(
        key: DinnovaLanguagesKeys.priceError.toString(),
        arValue: 'السعر غير صحيح');

    _addString(key: DinnovaLanguagesKeys.ok.toString(), arValue: 'حسنا');
    _addString(
        key: DinnovaLanguagesKeys.paymentWay.toString(), arValue: 'طريقة الدفع');
    _addString(key: DinnovaLanguagesKeys.cash.toString(), arValue: 'نقدي');
    _addString(
        key: DinnovaLanguagesKeys.visa.toString(), arValue: 'فيزا ( قريبا )');
    _addString(key: DinnovaLanguagesKeys.cancel.toString(), arValue: 'الغاء');
    _addString(
        key: DinnovaLanguagesKeys.login.toString(), arValue: 'تسجيل دخول');
    _addString(key: DinnovaLanguagesKeys.call.toString(), arValue: 'اتصال');
    _addString(
        key: DinnovaLanguagesKeys.info.toString(), arValue: 'ارقام و بيانات');
    _addString(key: DinnovaLanguagesKeys.wallet.toString(), arValue: 'المحفظة');
    _addString(key: DinnovaLanguagesKeys.close.toString(), arValue: 'اغلاق');
    _addString(key: DinnovaLanguagesKeys.home.toString(), arValue: 'الرئيسية');
    _addString(
        key: DinnovaLanguagesKeys.noResultsFound.toString(),
        arValue: 'لا يوجد نتائج');

    _addString(key: DinnovaLanguagesKeys.sortBy.toString(), arValue: 'رتب ب');
    _addString(
        key: DinnovaLanguagesKeys.notifications.toString(), arValue: 'اخبار');
    _addString(key: DinnovaLanguagesKeys.profile.toString(), arValue: 'صفحتي');
    _addString(key: DinnovaLanguagesKeys.setting.toString(), arValue: 'اعدادات');
    _addString(
        key: DinnovaLanguagesKeys.addMore.toString(), arValue: 'اضف المزيد');
    _addString(
        key: DinnovaLanguagesKeys.serverError.toString(),
        arValue: 'حدث خطأ, برجاء المحاوله لاحقا');
    _addString(
        key: DinnovaLanguagesKeys.searchHint.toString(), arValue: 'ابحث بالاسم');
    _addString(key: DinnovaLanguagesKeys.rate.toString(), arValue: 'التقيم');
    _addString(key: DinnovaLanguagesKeys.abc.toString(), arValue: 'الاسم');
    _addString(key: DinnovaLanguagesKeys.orders.toString(), arValue: 'طلبات');
    _addString(key: DinnovaLanguagesKeys.next.toString(), arValue: 'متابعه');
    _addString(
        key: DinnovaLanguagesKeys.verification.toString(),
        arValue: 'تأكيد رقم الهاتف');
    _addString(
        key: DinnovaLanguagesKeys.shakawa.toString(),
        arValue: 'شكاوى و اقتراحات');
    _addString(
        key: DinnovaLanguagesKeys.callCenter.toString(), arValue: 'الدعم الفني');
    _addString(
        key: DinnovaLanguagesKeys.rateUs.toString(), arValue: 'تقييم التطبيق');
    _addString(
        key: DinnovaLanguagesKeys.sendOrder.toString(), arValue: 'ارسال الطلب');
    _addString(key: DinnovaLanguagesKeys.address.toString(), arValue: 'العنوان');
    _addString(key: DinnovaLanguagesKeys.confirm.toString(), arValue: 'تأكيد');
    _addString(
        key: DinnovaLanguagesKeys.forgetPassword.toString(),
        arValue: 'نسيت كلمة السر؟');
    _addString(
        key: DinnovaLanguagesKeys.loginWithGoogle.toString(),
        arValue: 'تسجيل دخول بحساب جوجل');
    _addString(
        key: DinnovaLanguagesKeys.inviteFriends.toString(),
        arValue: 'دعوة اصدقاء');
    _addString(
        key: DinnovaLanguagesKeys.facebook.toString(),
        arValue: 'تابعنا على الفيسبوك');
    _addString(
        key: DinnovaLanguagesKeys.aboutUs.toString(), arValue: 'من نحن ؟');
    _addString(
        key: DinnovaLanguagesKeys.cantBeEmpty.toString(),
        arValue: 'يجب ملئ البيانات المطلوبه');
    _addString(
        key: DinnovaLanguagesKeys.changeThemeNote.toString(),
        arValue: 'يمكنك تغير الوضع من الاعدات في اي وقت');
    _addString(
        key: DinnovaLanguagesKeys.pressAgainToExit.toString(),
        arValue: 'اضغط رجوع مره اخرى للخروج');
    _addString(
        key: DinnovaLanguagesKeys.requestHasSent.toString(),
        arValue: 'تم ارسال طلبك بنجاح');

    _addString(
        key: DinnovaLanguagesKeys.advancedSearch.toString(),
        arValue: 'بحث متقدم');

    _addString(key: DinnovaLanguagesKeys.yes.toString(), arValue: 'نعم');
    _addString(key: DinnovaLanguagesKeys.no.toString(), arValue: 'لا');
    _addString(key: DinnovaLanguagesKeys.reports.toString(), arValue: 'تقارير');
    _addString(
        key: DinnovaLanguagesKeys.signup.toString(), arValue: 'تسجيل حساب جديد');
    _addString(key: DinnovaLanguagesKeys.name.toString(), arValue: 'الاسم');

    _addString(
        key: DinnovaLanguagesKeys.password.toString(), arValue: 'كلمة المرور');
    _addString(
        key: DinnovaLanguagesKeys.phoneNumber.toString(), arValue: 'رقم الهاتف');
    _addString(
        key: DinnovaLanguagesKeys.phoneHintError.toString(),
        arValue: 'رقم الهاتف غير صحيح');
    _addString(
        key: DinnovaLanguagesKeys.passwordHintError.toString(),
        arValue: ' كلمة المرور يجب الا تقل عن ٦ ارقام او حروف');
    _addString(
        key: DinnovaLanguagesKeys.enterCode.toString(),
        arValue: 'سيتم ارسال الكود الى رقم الهاتف');
    _addString(
        key: DinnovaLanguagesKeys.chooseAddress.toString(),
        arValue: 'اختر عنوان التوصيل');
    _addString(
        key: DinnovaLanguagesKeys.reSendCode.toString(),
        arValue: 'اعد ارسال الكود مره اخرى');

    return {"en": _enStrings, "ar": _arStrings};
  }

  _addString({required String key, String? enValue, String? arValue}) {
    _enStrings[key] = enValue ?? arValue!;
    if (arValue != null) _arStrings[key] = arValue;
  }
}
