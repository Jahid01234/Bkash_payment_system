import 'package:bkash_payment_system/core/const/app_colors.dart';
import 'package:bkash_payment_system/core/style/global_text_style.dart';
import 'package:bkash_payment_system/feature/check_out/controller/check_out_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatelessWidget {
  final String bkashURL;
  final String paymentID;
  final String idToken;


   PaymentScreen({
    super.key,
    required this.bkashURL,
    required this.paymentID,
    required this.idToken,
  });

  final CheckOutController controller = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Pay with Bkash",
          style: globalTextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (request) async {
                debugPrint("URL: ${request.url}");
                final uri = Uri.parse(request.url);
                final status = uri.queryParameters['status'];
                if (status == 'success') {
                  final response = await controller.executePayment(paymentID, idToken);

                  if (response != null) {
                    Get.snackbar(
                      "Success",
                      "TRX ID: ${response.trxID}",
                    );

                    Get.back();
                  }

                  return NavigationDecision.prevent;
                }

                if (status == 'cancel') {
                  Get.back();
                  return NavigationDecision.prevent;
                }

                if (status == 'failure') {
                  Get.back();
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(bkashURL),
          ),
      ),

    );
  }
}
