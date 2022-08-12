import 'dart:async';

import 'package:example/views/command_usage/command_usage.dart';
import 'package:example/views/command_usage/command_usage_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/flutter_mvvm.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const titlePlaceholder = 'Title: ';
  group(
    'executeIfCan',
    () {
      testWidgets(
        'should reflect "Empty" to AppBar after invoking displayEmptyCommand',
        (WidgetTester tester) async {
          final CommandUsageViewModel vm = await _prepareCommandUsageViewAsync(
            tester: tester,
          );
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text(titlePlaceholder),
            ),
            findsOneWidget,
          );

          vm.displayEmptyCommand.executeIfCan(
            args: null,
            fallback: Command.defaultVoidCallback,
          );
          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text('Title: Empty'),
            ),
            findsOneWidget,
          );
        },
      );
      testWidgets(
        'should reflect "Input" to AppBar after invoking displayInputValueCommand with "Input"',
        (WidgetTester tester) async {
          final CommandUsageViewModel vm = await _prepareCommandUsageViewAsync(
            tester: tester,
          );
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text(titlePlaceholder),
            ),
            findsOneWidget,
          );

          vm.displayInputValueCommand.executeIfCan(
            args: 'Input',
            fallback: Command.defaultVoidCallback,
          );
          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text('Title: Input'),
            ),
            findsOneWidget,
          );
        },
      );
      testWidgets(
        'should reflect "FutureEmpty" to AppBar after invoking displayFutureEmptyCommand',
        (WidgetTester tester) async {
          final CommandUsageViewModel vm = await _prepareCommandUsageViewAsync(
            tester: tester,
          );
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text(titlePlaceholder),
            ),
            findsOneWidget,
          );
          unawaited(
            vm.displayFutureEmptyCommand.executeIfCan(
              args: null,
              fallback: Command.defaultFutureVoidCallback,
            ),
          );

          await tester.pump(const Duration(milliseconds: 500));
          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text('Title: FutureEmpty'),
            ),
            findsOneWidget,
          );
        },
      );

      group(
        'canExecute',
        () {
          testWidgets(
            'should reflect "Empty" to AppBar after invoking displayEmptyWhenCanCommand with canUpdate is true',
            (WidgetTester tester) async {
              final CommandUsageViewModel vm =
                  await _prepareCommandUsageViewAsync(
                tester: tester,
              );
              vm.canUpdate = true;
              expect(
                find.descendant(
                  of: find.byType(AppBar),
                  matching: find.text(titlePlaceholder),
                ),
                findsOneWidget,
              );
              vm.displayEmptyWhenCanCommand.executeIfCan(
                args: null,
                fallback: Command.defaultFutureVoidCallback,
              );
              await tester.pump(const Duration(milliseconds: 500));
              await tester.pump();
              expect(
                find.descendant(
                  of: find.byType(AppBar),
                  matching: find.text('Title: Empty'),
                ),
                findsOneWidget,
              );
            },
          );
          testWidgets(
            'should not reflect "Empty" to AppBar after invoking displayEmptyWhenCanCommand with canUpdate is false',
            (WidgetTester tester) async {
              final CommandUsageViewModel vm =
                  await _prepareCommandUsageViewAsync(
                tester: tester,
              );
              vm.canUpdate = false;
              expect(
                find.descendant(
                  of: find.byType(AppBar),
                  matching: find.text(titlePlaceholder),
                ),
                findsOneWidget,
              );
              vm.displayEmptyWhenCanCommand.executeIfCan(
                args: null,
                fallback: Command.defaultFutureVoidCallback,
              );
              await tester.pump(const Duration(milliseconds: 500));
              await tester.pump();
              expect(
                find.descendant(
                  of: find.byType(AppBar),
                  matching: find.text(titlePlaceholder),
                ),
                findsOneWidget,
              );
            },
          );
        },
      );
    },
  );

  group(
    'toResultCallback',
    () {
      testWidgets(
        'should reflect "Empty" to AppBar after invoking displayEmptyCommand from view',
        (WidgetTester tester) async {
          await _prepareCommandUsageViewAsync(
            tester: tester,
          );

          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text(titlePlaceholder),
            ),
            findsOneWidget,
          );
          await tester.tap(find.byKey(const ValueKey('DisplayEmptyButton')));
          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text('Title: Empty'),
            ),
            findsOneWidget,
          );
        },
      );
      testWidgets(
        'should reflect "Input value" to AppBar after invoking displayInputValueCommand from view',
        (WidgetTester tester) async {
          await _prepareCommandUsageViewAsync(
            tester: tester,
          );

          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text(titlePlaceholder),
            ),
            findsOneWidget,
          );
          await tester
              .tap(find.byKey(const ValueKey('DisplayInputValueButton')));
          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text('Title: Input value'),
            ),
            findsOneWidget,
          );
        },
      );
      testWidgets(
        'should reflect "FutureEmpty" to AppBar after invoking displayFutureEmptyCommand from view',
        (WidgetTester tester) async {
          await _prepareCommandUsageViewAsync(
            tester: tester,
          );

          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text(titlePlaceholder),
            ),
            findsOneWidget,
          );
          await tester
              .tap(find.byKey(const ValueKey('DisplayFutureEmptyButton')));
          await tester.pump(const Duration(milliseconds: 500));
          expect(
            find.descendant(
              of: find.byType(AppBar),
              matching: find.text('Title: FutureEmpty'),
            ),
            findsOneWidget,
          );
        },
      );

      group(
        'handleCanExecute',
        () {
          testWidgets(
            'should reflect "Empty" to AppBar after invoking displayEmptyWhenCanCommand with canUpdate is true',
            (WidgetTester tester) async {
              final CommandUsageViewModel vm =
                  await _prepareCommandUsageViewAsync(
                tester: tester,
              );
              vm.canUpdate = true;
              await tester.pump();
              expect(
                find.descendant(
                  of: find.byType(AppBar),
                  matching: find.text(titlePlaceholder),
                ),
                findsOneWidget,
              );
              await tester
                  .tap(find.byKey(const ValueKey('DisplayEmptyWhenCanButton')));
              await tester.pump();
              expect(
                find.descendant(
                  of: find.byType(AppBar),
                  matching: find.text('Title: Empty'),
                ),
                findsOneWidget,
              );
            },
          );
          testWidgets(
            'should not reflect "Empty" to AppBar after invoking displayEmptyWhenCanCommand with canUpdate is false',
            (WidgetTester tester) async {
              final CommandUsageViewModel vm =
                  await _prepareCommandUsageViewAsync(
                tester: tester,
              );
              vm.canUpdate = false;
              await tester.pump();
              expect(
                find.descendant(
                  of: find.byType(AppBar),
                  matching: find.text(titlePlaceholder),
                ),
                findsOneWidget,
              );
              await tester
                  .tap(find.byKey(const ValueKey('DisplayEmptyWhenCanButton')));
              await tester.pump();
              expect(
                find.descendant(
                  of: find.byType(AppBar),
                  matching: find.text(titlePlaceholder),
                ),
                findsOneWidget,
              );
            },
          );
        },
      );
    },
  );

  group(
    'toResultWithInputCallback',
    () {
      testWidgets(
        'should reflect "2000" to the YearPicker button after invoking selectDateCommand',
        (WidgetTester tester) async {
          await _prepareCommandUsageViewAsync(
            tester: tester,
          );

          final yearPickerButtonFinder =
              find.byKey(const ValueKey('YearPickerButton'));
          expect(
            find.descendant(
              of: yearPickerButtonFinder,
              matching: find.text('Selected year: 1999'),
            ),
            findsOneWidget,
          );
          await tester.tap(yearPickerButtonFinder);
          await tester.pump();
          final expectedYearOptionFinder = find.descendant(
            of: find.byKey(const ValueKey('YearPicker')),
            matching: find.text('2000'),
            skipOffstage: false,
          );
          await tester.scrollUntilVisible(
            expectedYearOptionFinder,
            36,
          );
          await tester.tap(
            expectedYearOptionFinder,
          );
          await tester.pump();

          expect(
            find.descendant(
              of: yearPickerButtonFinder,
              matching: find.text('Selected year: 2000'),
            ),
            findsOneWidget,
          );
        },
      );
    },
  );
}

Future<CommandUsageViewModel> _prepareCommandUsageViewAsync({
  required WidgetTester tester,
}) async {
  final vm = CommandUsageViewModel();
  await tester.pumpWidget(
    MaterialApp(
      home: CommandUsageView(vm),
    ),
  );
  await tester.pump();
  return vm;
}
