import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future<Uri> createDynamicLink({String data = 'FDMRules'}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://blocle.page.link',
      link: Uri.parse("https://blocle.page.link.com?code=$data"),
      // longDynamicLink:  Uri.parse("https://blocle.page.link.com?code=532"),
      androidParameters: AndroidParameters(
        packageName: 'com.example.bloc_counter_app',
      ),
      // iosParameters: IOSParameters(
      //   bundleId: 'com.example.blocCounterApp',
      //   minimumVersion: '1',
      //   appStoreId: 'your_app_store_id',
      // ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final actualUri = dynamicLink.shortUrl;

    return actualUri;
  }

  Future<String> retrieveDynamicLink() async {
    try {
      FirebaseDynamicLinks.instance.onLink.listen((event) async {
        final Uri deepLink = event?.link;
        log('${event?.link.toString()} wwwwwwwwww');
        if (deepLink != null) {
          log('${event?.link.toString()} ffffffffff');
          var isReferred = deepLink.toString().contains('code');
          if (isReferred) {
            String code = deepLink.queryParameters['code'];
            log('${event?.link.toString()} qqqqqqqqqqq');
            if (code != null) {
              log('$code pro max');
              return code;
            }
          }
        }
      }).onError((e) {
        log('Dynamic link faild');
        log(e.toString());
      });
    } catch (e) {
      print(e.toString());
      return "Error";
    }
  }
}
