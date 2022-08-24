import 'package:example/views/view_signal_usage/view_signal_usage_view.dart';
import 'package:example/views/view_signal_usage/view_signal_usage_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/flutter_mvvm.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'should reflect "Early text" even there is no listener listens to viewSignal stream',
    (widgetTester) async {
      final vm = ViewSignalUsageViewModel();
      expect(
        vm.viewSignal.hasListener,
        false,
      );
      vm.updateTextCommand.executeIfCan(
        args: 'Early text',
        fallback: Command.defaultVoidCallback,
      );
      await widgetTester.pumpWidget(
        MaterialApp(
          home: ViewSignalUsageView(vm),
        ),
      );

      await widgetTester.pump();
      expect(
        vm.viewSignal.hasListener,
        true,
      );
      expect(
        find.text('Rendering text: Early text'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'should reflect "new text" after emitting signal',
    (widgetTester) async {
      final vm = await _prepareViewSignalUsageViewAsync(
        tester: widgetTester,
      );

      vm.updateTextCommand.executeIfCan(
        args: 'new text',
        fallback: Command.defaultVoidCallback,
      );
      await widgetTester.pump();
      await widgetTester.pump();
      expect(
        find.text('Rendering text: new text'),
        findsOneWidget,
      );
    },
  );
}

Future<ViewSignalUsageViewModel> _prepareViewSignalUsageViewAsync({
  required WidgetTester tester,
}) async {
  final vm = ViewSignalUsageViewModel();
  await tester.pumpWidget(
    MaterialApp(
      home: ViewSignalUsageView(vm),
    ),
  );
  await tester.pump();
  return vm;
}
