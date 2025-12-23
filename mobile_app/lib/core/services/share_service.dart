import 'package:share_plus/share_plus.dart';

class ShareService {
  // Share business details
  Future<void> shareBusiness({
    required String businessName,
    required String businessId,
    String? description,
  }) async {
    final text =
        '''
تحقق من $businessName على تطبيق طابور!

${description ?? 'احجز دورك الآن بدون انتظار!'}

رابط التطبيق: https://taabor.app/business/$businessId
    ''';

    await Share.share(text);
  }

  // Share offer details
  Future<void> shareOffer({
    required String offerTitle,
    required String businessName,
    required String discount,
  }) async {
    final text =
        '''
🔥 عرض خاص من $businessName!

$offerTitle
خصم: $discount

لا تفوت الفرصة! حمّل تطبيق طابور الآن
https://taabor.app
    ''';

    await Share.share(text);
  }

  // Share app
  Future<void> shareApp() async {
    final text = '''
📱 جرب تطبيق طابور - احجز دورك بدون انتظار!

التطبيق الأول لإدارة الطوابير في المنطقة
وفر وقتك واحجز خدماتك بكل سهولة

حمّل الآن: https://taabor.app
    ''';

    await Share.share(text);
  }

  // Share with deep link
  Future<void> shareWithDeepLink({
    required String title,
    required String message,
    required String deepLink,
  }) async {
    final text =
        '''
$message

$deepLink
    ''';

    await Share.share(text, subject: title);
  }

  // Share files (images, documents)
  Future<void> shareFiles({
    required List<String> filePaths,
    String? text,
  }) async {
    final files = filePaths.map((path) => XFile(path)).toList();
    await Share.shareXFiles(files, text: text);
  }
}
