import 'package:example/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm/flutter_mvvm.dart';

class CommandUsageViewModel extends BindableBase {
  String _title = '';

  String get title => 'Title: $_title';

  bool _canUpdate = false;

  bool get canUpdate => _canUpdate;

  @visibleForTesting
  set canUpdate(bool canUpdate) {
    if (_canUpdate == canUpdate) {
      return;
    }
    _canUpdate = canUpdate;
    notifyListeners();
  }

  DateTime _selectedDate = DateTime(1999);

  DateTime get selectedDate => _selectedDate;

  late final Command<void, void> displayEmptyCommand = AppCommand(
    _displayEmpty,
  );
  late final Command<void, String> displayInputValueCommand =
      AppCommand<void, String>.withArgument(
    _displayInputValue,
  );
  late final Command<Future<void>, void> displayFutureEmptyCommand = AppCommand(
    _displayFutureEmptyAsync,
  );
  late final Command<void, void> displayEmptyWhenCanCommand = AppCommand(
    _displayEmpty,
    canExecute: () => canUpdate,
  );
  late final Command<void, DateTime> selectDateCommand =
      AppCommand<void, DateTime>.withArgument(
    _selectDate,
  );

  CommandUsageViewModel();

  void _displayEmpty() {
    _title = 'Empty';
    notifyListeners();
  }

  void _displayInputValue(String value) {
    _title = value;
    notifyListeners();
  }

  @override
  BuildContext retrieveFallbackContext() {
    return MyApp.fallbackContext!;
  }

  Future<void> _displayFutureEmptyAsync() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _title = 'FutureEmpty';
    notifyListeners();
  }

  void _selectDate(DateTime dateTime) {
    if (_selectedDate == dateTime) {
      throw ArgumentError('Cannot re-select the previous value');
    }
    _selectedDate = dateTime;
    notifyListeners();
    Navigator.pop(context);
  }
}
