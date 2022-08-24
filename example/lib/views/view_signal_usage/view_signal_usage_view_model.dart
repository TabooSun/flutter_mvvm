import 'package:example/main.dart';
import 'package:example/views/view_signal_usage/view_signal_usage_view_signal_key.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm/flutter_mvvm.dart';

class ViewSignalUsageViewModel extends BindableBase {
  late final Command<void, String> updateTextCommand;

  ViewSignalUsageViewModel() {
    updateTextCommand = AppCommand<void, String>.withArgument(_updateText);
  }

  @override
  BuildContext retrieveFallbackContext() {
    return MyApp.fallbackContext!;
  }

  void _updateText(String args) {
    emitSignal(
      ViewSignalData(
        signalName: ViewSignalUsageViewSignalKey.updateText,
        data: args,
      ),
    );
  }
}
