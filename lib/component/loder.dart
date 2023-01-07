import 'package:flutter/material.dart';

class Loader {
  BuildContext? context;
  bool _isOpen = false;
  Future? future;
  Function? onDone;
  bool? autoDismiss;

  Loader(
      {required this.context,
        this.future,
        this.onDone,
        this.autoDismiss = true});

  _futureCall() async {
    dynamic data = await future!;
    if (data != null) {
      onDone?.call(data);
      if (autoDismiss!) {
        dismissLoader();
      }
    }
  }

  showLoader() {
    _isOpen = true;
    _futureCall();
    showDialog(
        barrierDismissible: false,
        useSafeArea: true,
        context: context!,
        builder: (_) {
          return Center(
            child: Container(
                height: 40, width: 40, child: CircularProgressIndicator()),
          );
        }).then((value) => _isOpen = false);
  }

  dismissLoader() {
    if (_isOpen) {
      Navigator.of(context!).pop();
      FocusNode _unusedFocusNode = FocusNode();
      FocusScope.of(context!).requestFocus(_unusedFocusNode);
    }
  }
}
