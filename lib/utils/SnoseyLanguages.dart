import 'package:get/get.dart';

enum SnoseyLanguagesKeys {
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

class SnoseyLanguages extends Translations {
  Map<String, String> _arStrings = {};
  Map<String, String> _enStrings = {};

  @override
  Map<String, Map<String, String>> get keys {
    _addString(
        key: SnoseyLanguagesKeys.addressArea.toString(), arValue: 'المنطقه');
    _addString(
        key: SnoseyLanguagesKeys.addNewAddress.toString(),
        arValue: 'اضف عنوان جديد');
    _addString(
        key: SnoseyLanguagesKeys.addressBuildName.toString(),
        arValue: 'اسم او رقم المبني');
    _addString(key: SnoseyLanguagesKeys.notes.toString(), arValue: 'ملاحظات');

    _addString(
        key: SnoseyLanguagesKeys.thisFieldRequired.toString(),
        arValue: 'هذا الحقل مطلوب');

    _addString(
        key: SnoseyLanguagesKeys.email.toString(),
        arValue: 'البريد الالكتروني');
    _addString(
        key: SnoseyLanguagesKeys.emailError.toString(),
        arValue: 'البريد الالكتروني غير صحيح');

    _addString(key: SnoseyLanguagesKeys.phones.toString(), arValue: 'الأرقام');

    _addString(
        key: SnoseyLanguagesKeys.addressFlatNumber.toString(),
        arValue: 'رقم الشقه');
    _addString(
        key: SnoseyLanguagesKeys.addressFloorNumber.toString(),
        arValue: 'رقم الطابق');
    _addString(
        key: SnoseyLanguagesKeys.addressPhone.toString(), arValue: 'رقم الشقه');
    _addString(
        key: SnoseyLanguagesKeys.addressPhone2.toString(),
        arValue: 'رقم الهاتف الاحتياطي ( اختياري )');
    _addString(
        key: SnoseyLanguagesKeys.addressNotes.toString(),
        arValue: 'ملاحظات اخرى');
    _addString(
        key: SnoseyLanguagesKeys.addressStreetName.toString(),
        arValue: 'اسم الشارع');

    _addString(
        key: SnoseyLanguagesKeys.favorite.toString(), arValue: 'المفضلة');
    _addString(key: SnoseyLanguagesKeys.price.toString(), arValue: 'السعر');
    _addString(
        key: SnoseyLanguagesKeys.priceError.toString(),
        arValue: 'السعر غير صحيح');

    _addString(key: SnoseyLanguagesKeys.ok.toString(), arValue: 'حسنا');
    _addString(
        key: SnoseyLanguagesKeys.paymentWay.toString(), arValue: 'طريقة الدفع');
    _addString(key: SnoseyLanguagesKeys.cash.toString(), arValue: 'نقدي');
    _addString(
        key: SnoseyLanguagesKeys.visa.toString(), arValue: 'فيزا ( قريبا )');
    _addString(key: SnoseyLanguagesKeys.cancel.toString(), arValue: 'الغاء');
    _addString(
        key: SnoseyLanguagesKeys.login.toString(), arValue: 'تسجيل دخول');
    _addString(key: SnoseyLanguagesKeys.call.toString(), arValue: 'اتصال');
    _addString(
        key: SnoseyLanguagesKeys.info.toString(), arValue: 'ارقام و بيانات');
    _addString(key: SnoseyLanguagesKeys.wallet.toString(), arValue: 'المحفظة');
    _addString(key: SnoseyLanguagesKeys.close.toString(), arValue: 'اغلاق');
    _addString(key: SnoseyLanguagesKeys.home.toString(), arValue: 'الرئيسية');
    _addString(
        key: SnoseyLanguagesKeys.noResultsFound.toString(),
        arValue: 'لا يوجد نتائج');

    _addString(key: SnoseyLanguagesKeys.sortBy.toString(), arValue: 'رتب ب');
    _addString(
        key: SnoseyLanguagesKeys.notifications.toString(), arValue: 'اخبار');
    _addString(key: SnoseyLanguagesKeys.profile.toString(), arValue: 'صفحتي');
    _addString(key: SnoseyLanguagesKeys.setting.toString(), arValue: 'اعدادات');
    _addString(
        key: SnoseyLanguagesKeys.addMore.toString(), arValue: 'اضف المزيد');
    _addString(
        key: SnoseyLanguagesKeys.serverError.toString(),
        arValue: 'حدث خطأ, برجاء المحاوله لاحقا');
    _addString(
        key: SnoseyLanguagesKeys.searchHint.toString(), arValue: 'ابحث بالاسم');
    _addString(key: SnoseyLanguagesKeys.rate.toString(), arValue: 'التقيم');
    _addString(key: SnoseyLanguagesKeys.abc.toString(), arValue: 'الاسم');
    _addString(key: SnoseyLanguagesKeys.orders.toString(), arValue: 'طلبات');
    _addString(key: SnoseyLanguagesKeys.next.toString(), arValue: 'متابعه');
    _addString(
        key: SnoseyLanguagesKeys.verification.toString(),
        arValue: 'تأكيد رقم الهاتف');
    _addString(
        key: SnoseyLanguagesKeys.shakawa.toString(),
        arValue: 'شكاوى و اقتراحات');
    _addString(
        key: SnoseyLanguagesKeys.callCenter.toString(), arValue: 'الدعم الفني');
    _addString(
        key: SnoseyLanguagesKeys.rateUs.toString(), arValue: 'تقييم التطبيق');
    _addString(
        key: SnoseyLanguagesKeys.sendOrder.toString(), arValue: 'ارسال الطلب');
    _addString(key: SnoseyLanguagesKeys.address.toString(), arValue: 'العنوان');
    _addString(key: SnoseyLanguagesKeys.confirm.toString(), arValue: 'تأكيد');
    _addString(
        key: SnoseyLanguagesKeys.forgetPassword.toString(),
        arValue: 'نسيت كلمة السر؟');
    _addString(
        key: SnoseyLanguagesKeys.loginWithGoogle.toString(),
        arValue: 'تسجيل دخول بحساب جوجل');
    _addString(
        key: SnoseyLanguagesKeys.inviteFriends.toString(),
        arValue: 'دعوة اصدقاء');
    _addString(
        key: SnoseyLanguagesKeys.facebook.toString(),
        arValue: 'تابعنا على الفيسبوك');
    _addString(
        key: SnoseyLanguagesKeys.aboutUs.toString(), arValue: 'من نحن ؟');
    _addString(
        key: SnoseyLanguagesKeys.cantBeEmpty.toString(),
        arValue: 'يجب ملئ البيانات المطلوبه');
    _addString(
        key: SnoseyLanguagesKeys.changeThemeNote.toString(),
        arValue: 'يمكنك تغير الوضع من الاعدات في اي وقت');
    _addString(
        key: SnoseyLanguagesKeys.pressAgainToExit.toString(),
        arValue: 'اضغط رجوع مره اخرى للخروج');
    _addString(
        key: SnoseyLanguagesKeys.requestHasSent.toString(),
        arValue: 'تم ارسال طلبك بنجاح');

    _addString(
        key: SnoseyLanguagesKeys.advancedSearch.toString(),
        arValue: 'بحث متقدم');

    _addString(key: SnoseyLanguagesKeys.yes.toString(), arValue: 'نعم');
    _addString(key: SnoseyLanguagesKeys.no.toString(), arValue: 'لا');
    _addString(key: SnoseyLanguagesKeys.reports.toString(), arValue: 'تقارير');
    _addString(
        key: SnoseyLanguagesKeys.signup.toString(), arValue: 'تسجيل حساب جديد');
    _addString(key: SnoseyLanguagesKeys.name.toString(), arValue: 'الاسم');

    _addString(
        key: SnoseyLanguagesKeys.password.toString(), arValue: 'كلمة المرور');
    _addString(
        key: SnoseyLanguagesKeys.phoneNumber.toString(), arValue: 'رقم الهاتف');
    _addString(
        key: SnoseyLanguagesKeys.phoneHintError.toString(),
        arValue: 'رقم الهاتف غير صحيح');
    _addString(
        key: SnoseyLanguagesKeys.passwordHintError.toString(),
        arValue: ' كلمة المرور يجب الا تقل عن ٦ ارقام او حروف');
    _addString(
        key: SnoseyLanguagesKeys.enterCode.toString(),
        arValue: 'سيتم ارسال الكود الى رقم الهاتف');
    _addString(
        key: SnoseyLanguagesKeys.chooseAddress.toString(),
        arValue: 'اختر عنوان التوصيل');
    _addString(
        key: SnoseyLanguagesKeys.reSendCode.toString(),
        arValue: 'اعد ارسال الكود مره اخرى');

    return {"en": _enStrings, "ar": _arStrings};
  }

  _addString({required String key, String? enValue, String? arValue}) {
    _enStrings[key] = enValue ?? arValue!;
    if (arValue != null) _arStrings[key] = arValue;
  }
}
