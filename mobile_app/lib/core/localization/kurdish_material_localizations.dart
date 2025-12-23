import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Custom Material Localizations for Kurdish language
/// Uses Arabic as a fallback for system strings
class KurdishMaterialLocalizations extends MaterialLocalizations {
  KurdishMaterialLocalizations({
    this.fullYearFormat = 'y',
    this.compactDateFormat = 'yMd',
    this.shortDateFormat = 'yMd',
    this.mediumDateFormat = 'MMM d, y',
    this.longDateFormat = 'MMMM d, y',
    this.yearMonthFormat = 'MMMM y',
    this.shortMonthDayFormat = 'MMM d',
  });

  final String fullYearFormat;
  final String compactDateFormat;
  final String shortDateFormat;
  final String mediumDateFormat;
  final String longDateFormat;
  final String yearMonthFormat;
  final String shortMonthDayFormat;

  @override
  String get alertDialogLabel => 'ئاگادارکردنەوە';

  @override
  String get anteMeridiemAbbreviation => 'ب.ن';

  @override
  String get backButtonTooltip => 'گەڕانەوە';

  @override
  String get cancelButtonLabel => 'پاشگەزبوونەوە';

  @override
  String get closeButtonLabel => 'داخستن';

  @override
  String get closeButtonTooltip => 'داخستن';

  @override
  String get collapsedIconTapHint => 'فراوانکردن';

  @override
  String get continueButtonLabel => 'بەردەوامبوون';

  @override
  String get copyButtonLabel => 'کۆپیکردن';

  @override
  String get cutButtonLabel => 'بڕین';

  @override
  String get deleteButtonTooltip => 'سڕینەوە';

  @override
  String get dialogLabel => 'دیالۆگ';

  @override
  String get drawerLabel => 'مینیوی ڕێنیشاندەر';

  @override
  String get expandedIconTapHint => 'کۆکردنەوە';

  @override
  String get firstPageTooltip => 'لاپەڕەی یەکەم';

  @override
  String get hideAccountsLabel => 'شاردنەوەی هەژمارەکان';

  @override
  String get lastPageTooltip => 'لاپەڕەی کۆتایی';

  @override
  String get licensesPageTitle => 'مۆڵەتەکان';

  @override
  String get modalBarrierDismissLabel => 'لابردن';

  @override
  String get moreButtonTooltip => 'زیاتر';

  @override
  String get nextMonthTooltip => 'مانگی داهاتوو';

  @override
  String get nextPageTooltip => 'لاپەڕەی داهاتوو';

  @override
  String get okButtonLabel => 'باشە';

  @override
  String get openAppDrawerTooltip => 'کردنەوەی مینیوی ڕێنیشاندەر';

  @override
  String get pasteButtonLabel => 'لکاندن';

  @override
  String get popupMenuLabel => 'مینیوی پەنجەرەی سەرکەوتوو';

  @override
  String get postMeridiemAbbreviation => 'د.ن';

  @override
  String get previousMonthTooltip => 'مانگی پێشوو';

  @override
  String get previousPageTooltip => 'لاپەڕەی پێشوو';

  @override
  String get refreshIndicatorSemanticLabel => 'نوێکردنەوە';

  @override
  String get reorderItemDown => 'بردنە خوارەوە';

  @override
  String get reorderItemLeft => 'بردنە لای چەپ';

  @override
  String get reorderItemRight => 'بردنە لای ڕاست';

  @override
  String get reorderItemToEnd => 'بردنە کۆتایی';

  @override
  String get reorderItemToStart => 'بردنە سەرەتا';

  @override
  String get reorderItemUp => 'بردنە سەرەوە';

  @override
  String get rowsPerPageTitle => 'ڕیز بۆ هەر لاپەڕەیەک:';

  @override
  ScriptCategory get scriptCategory => ScriptCategory.tall;

  @override
  String get searchFieldLabel => 'گەڕان';

  @override
  String get selectAllButtonLabel => 'هەڵبژاردنی هەموو';

  @override
  String get selectYearSemanticsLabel => 'ساڵ هەڵبژێرە';

  @override
  String get showAccountsLabel => 'پیشاندانی هەژمارەکان';

  @override
  String get showMenuTooltip => 'پیشاندانی مینیو';

  @override
  String get signedInLabel => 'چووەتە ژوورەوە';

  TimeOfDayFormat get timeOfDayFormatRaw => TimeOfDayFormat.h_colon_mm_space_a;

  @override
  String get timePickerDialHelpText => 'کاتژمێر هەڵبژێرە';

  @override
  String get timePickerHourLabel => 'کاتژمێر';

  @override
  String get timePickerHourModeAnnouncement => 'کاتژمێر هەڵبژێرە';

  @override
  String get timePickerInputHelpText => 'کات بنووسە';

  @override
  String get timePickerMinuteLabel => 'خولەک';

  @override
  String get timePickerMinuteModeAnnouncement => 'خولەک هەڵبژێرە';

  @override
  String get unspecifiedDate => 'بەروار';

  @override
  String get unspecifiedDateRange => 'مەودای بەروار';

  @override
  String get viewLicensesButtonLabel => 'پیشاندانی مۆڵەتەکان';

  @override
  String get calendarModeButtonLabel => 'گۆڕین بۆ ڕۆژژمێر';

  @override
  String get dateHelpText => 'رر/مم/سسسس';

  @override
  String get dateInputLabel => 'بەروار بنووسە';

  @override
  String get dateOutOfRangeLabel => 'دەرەوەی مەودا';

  @override
  String get datePickerHelpText => 'بەروار هەڵبژێرە';

  @override
  String get selectedDateLabel => 'بەرواری هەڵبژێردراو';

  @override
  String get dateRangeEndLabel => 'بەرواری کۆتایی';

  @override
  String get dateRangePickerHelpText => 'مەودا هەڵبژێرە';

  @override
  String get dateRangeStartLabel => 'بەرواری دەستپێک';

  @override
  String get dateSeparator => '/';

  @override
  String get dialModeButtonLabel => 'گۆڕین بۆ دەستکردی دایاڵ';

  @override
  String get inputDateModeButtonLabel => 'گۆڕین بۆ نووسین';

  @override
  String get inputTimeModeButtonLabel => 'گۆڕین بۆ نووسین';

  @override
  String get invalidDateFormatLabel => 'شێوە هەڵەیە';

  @override
  String get invalidDateRangeLabel => 'مەودا هەڵەیە';

  @override
  String get invalidTimeLabel => 'کات هەڵەیە';

  @override
  List<String> get narrowWeekdays => const <String>[
    'ی',
    'د',
    'س',
    'چ',
    'پ',
    'ه',
    'ش',
  ];

  @override
  int get firstDayOfWeekIndex => 0;

  @override
  String get keyboardKeyAlt => 'Alt';

  @override
  String get keyboardKeyAltGraph => 'AltGr';

  @override
  String get keyboardKeyBackspace => 'Backspace';

  @override
  String get keyboardKeyCapsLock => 'Caps Lock';

  @override
  String get keyboardKeyChannelDown => 'کەناڵ خوارەوە';

  @override
  String get keyboardKeyChannelUp => 'کەناڵ سەرەوە';

  @override
  String get keyboardKeyControl => 'Ctrl';

  @override
  String get keyboardKeyDelete => 'Del';

  @override
  String get keyboardKeyEject => 'Eject';

  @override
  String get keyboardKeyEnd => 'End';

  @override
  String get keyboardKeyEscape => 'Esc';

  @override
  String get keyboardKeyFn => 'Fn';

  @override
  String get keyboardKeyHome => 'Home';

  @override
  String get keyboardKeyInsert => 'Insert';

  @override
  String get keyboardKeyMeta => 'Meta';

  @override
  String get keyboardKeyMetaMacOs => 'Command';

  @override
  String get keyboardKeyMetaWindows => 'Win';

  @override
  String get keyboardKeyNumLock => 'Num Lock';

  @override
  String get keyboardKeyNumpad0 => 'Num 0';

  @override
  String get keyboardKeyNumpad1 => 'Num 1';

  @override
  String get keyboardKeyNumpad2 => 'Num 2';

  @override
  String get keyboardKeyNumpad3 => 'Num 3';

  @override
  String get keyboardKeyNumpad4 => 'Num 4';

  @override
  String get keyboardKeyNumpad5 => 'Num 5';

  @override
  String get keyboardKeyNumpad6 => 'Num 6';

  @override
  String get keyboardKeyNumpad7 => 'Num 7';

  @override
  String get keyboardKeyNumpad8 => 'Num 8';

  @override
  String get keyboardKeyNumpad9 => 'Num 9';

  @override
  String get keyboardKeyNumpadAdd => 'Num +';

  @override
  String get keyboardKeyNumpadComma => 'Num ,';

  @override
  String get keyboardKeyNumpadDecimal => 'Num .';

  @override
  String get keyboardKeyNumpadDivide => 'Num /';

  @override
  String get keyboardKeyNumpadEnter => 'Num Enter';

  @override
  String get keyboardKeyNumpadEqual => 'Num =';

  @override
  String get keyboardKeyNumpadMultiply => 'Num *';

  @override
  String get keyboardKeyNumpadParenLeft => 'Num (';

  @override
  String get keyboardKeyNumpadParenRight => 'Num )';

  @override
  String get keyboardKeyNumpadSubtract => 'Num -';

  @override
  String get keyboardKeyPageDown => 'PgDown';

  @override
  String get keyboardKeyPageUp => 'PgUp';

  @override
  String get keyboardKeyPower => 'Power';

  @override
  String get keyboardKeyPowerOff => 'Power Off';

  @override
  String get keyboardKeyPrintScreen => 'Print Screen';

  @override
  String get keyboardKeyScrollLock => 'Scroll Lock';

  @override
  String get keyboardKeySelect => 'Select';

  @override
  String get keyboardKeyShift => 'Shift';

  @override
  String get keyboardKeySpace => 'Space';

  @override
  String get menuBarMenuLabel => 'مینیوی شریتی مینیو';

  @override
  String get bottomSheetLabel => 'شیتی خوارەوە';

  @override
  String get currentDateLabel => 'ئەمڕۆ';

  @override
  String get scrimLabel => 'Scrim';

  @override
  String get collapsedHint => 'کۆکراوەتەوە';

  @override
  String get expandedHint => 'فراوانکراوە';

  @override
  String get expansionTileCollapsedHint => 'دابگرە بۆ فراوانکردن';

  @override
  String get expansionTileCollapsedTapHint => 'فراوانکردن بۆ زانیاری زیاتر';

  @override
  String get expansionTileExpandedHint => 'دابگرە بۆ کۆکردنەوە';

  @override
  String get expansionTileExpandedTapHint => 'کۆکردنەوە';

  @override
  String get scanTextButtonLabel => 'سکانکردنی دەق';

  @override
  String get lookUpButtonLabel => 'گەڕان بۆ دەورووبەر';

  @override
  String get menuDismissLabel => 'داخستنی مینیو';

  @override
  String get searchWebButtonLabel => 'گەڕان لە وێب';

  @override
  String get shareButtonLabel => 'هاوبەشکردن';

  @override
  String get clearButtonTooltip => 'سڕینەوە';

  @override
  String get saveButtonLabel => 'پاشەکەوتکردن';

  // Format methods
  @override
  String formatDecimal(int number) => number.toString();

  @override
  String formatHour(
    TimeOfDay timeOfDay, {
    bool alwaysUse24HourFormat = false,
  }) => timeOfDay.hour.toString();

  @override
  String formatMediumDate(DateTime date) =>
      '${date.day}-${date.month}-${date.year}';

  @override
  String formatMinute(TimeOfDay timeOfDay) =>
      timeOfDay.minute.toString().padLeft(2, '0');

  @override
  String formatMonthYear(DateTime date) => '${date.month}/${date.year}';

  @override
  String formatShortDate(DateTime date) => '${date.day}/${date.month}';

  @override
  String formatShortMonthDay(DateTime date) => '${date.day}/${date.month}';

  @override
  String formatYear(DateTime date) => date.year.toString();

  @override
  String formatCompactDate(DateTime date) =>
      '${date.day}/${date.month}/${date.year}';

  @override
  String formatFullDate(DateTime date) =>
      '${date.day}/${date.month}/${date.year}';

  @override
  String formatTimeOfDay(
    TimeOfDay timeOfDay, {
    bool alwaysUse24HourFormat = false,
  }) => '${timeOfDay.hour}:${timeOfDay.minute}';

  @override
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) =>
      TimeOfDayFormat.h_colon_mm_space_a;

  // New required methods
  @override
  String aboutListTileTitle(String applicationName) =>
      'دەربارەی $applicationName';

  @override
  String dateRangeStartDateSemanticLabel(String fullDate) =>
      'بەرواری دەستپێک $fullDate';

  @override
  String dateRangeEndDateSemanticLabel(String fullDate) =>
      'بەرواری کۆتایی $fullDate';

  String unselectedTabLabel({required int tabIndex, required int tabCount}) =>
      'تابی $tabIndex لە $tabCount';

  @override
  String pageRowsInfoTitle(
    int firstRow,
    int lastRow,
    int rowCount,
    bool rowCountIsApproximate,
  ) => rowCountIsApproximate
      ? '$firstRow–$lastRow لە نزیکەی $rowCount'
      : '$firstRow–$lastRow لە $rowCount';

  @override
  DateTime? parseCompactDate(String? inputString) {
    if (inputString == null) return null;
    try {
      final parts = inputString.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    } catch (_) {}
    return null;
  }

  @override
  String remainingTextFieldCharacterCount(int remaining) {
    if (remaining == 0) return 'هیچ پیتێک نەماوە';
    if (remaining == 1) return '١ پیت ماوە';
    return '$remaining پیت ماوە';
  }

  @override
  String selectedRowCountTitle(int selectedRowCount) {
    if (selectedRowCount == 0) return 'هیچ بابەتێک هەڵنەبژێردراوە';
    if (selectedRowCount == 1) return '١ بابەت هەڵبژێردراوە';
    return '$selectedRowCount بابەت هەڵبژێردراوە';
  }

  @override
  String tabLabel({required int tabIndex, required int tabCount}) =>
      'تابی $tabIndex لە $tabCount';

  @override
  String licensesPackageDetailText(int licenseCount) {
    if (licenseCount == 0) return 'هیچ مۆڵەتێک نییە';
    if (licenseCount == 1) return '١ مۆڵەت';
    return '$licenseCount مۆڵەت';
  }

  @override
  String scrimOnTapHint(String modalRouteContentName) =>
      'داخستنی $modalRouteContentName';
}

class KurdishMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const KurdishMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ku';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return KurdishMaterialLocalizations();
  }

  @override
  bool shouldReload(KurdishMaterialLocalizationsDelegate old) => false;
}

/// Simple Kurdish Cupertino Localizations
class KurdishCupertinoLocalizations extends DefaultCupertinoLocalizations {
  const KurdishCupertinoLocalizations();

  @override
  String get alertDialogLabel => 'ئاگادارکردنەوە';

  @override
  String get anteMeridiemAbbreviation => 'ب.ن';

  @override
  String get copyButtonLabel => 'کۆپیکردن';

  @override
  String get cutButtonLabel => 'بڕین';

  @override
  String get pasteButtonLabel => 'لکاندن';

  @override
  String get postMeridiemAbbreviation => 'د.ن';

  @override
  String get selectAllButtonLabel => 'هەڵبژاردنی هەموو';

  @override
  String get todayLabel => 'ئەمڕۆ';

  @override
  String get searchTextFieldPlaceholderLabel => 'گەڕان';

  @override
  String get noSpellCheckReplacementsLabel => 'هیچ جێگرەوەیەک نەدۆزرایەوە';

  @override
  String datePickerYear(int yearIndex) => yearIndex.toString();

  @override
  String datePickerMonth(int monthIndex) => monthIndex.toString();

  @override
  String datePickerDayOfMonth(int dayIndex, [int? weekDay]) =>
      dayIndex.toString();

  @override
  String datePickerHour(int hour) => hour.toString();

  @override
  String datePickerHourSemanticsLabel(int hour) => hour.toString();

  @override
  String datePickerMinute(int minute) => minute.toString();

  @override
  String datePickerMinuteSemanticsLabel(int minute) => minute.toString();

  @override
  String datePickerMediumDate(DateTime date) => date.toString();

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.dmy;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String get modalBarrierDismissLabel => 'لابردن';

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) =>
      'تابی $tabIndex لە $tabCount';
}

class KurdishCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const KurdishCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ku';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return const KurdishCupertinoLocalizations();
  }

  @override
  bool shouldReload(KurdishCupertinoLocalizationsDelegate old) => false;
}
