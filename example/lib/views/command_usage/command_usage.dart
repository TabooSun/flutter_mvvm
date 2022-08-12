import 'package:example/views/command_usage/command_usage_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/flutter_mvvm.dart';

class CommandUsageView extends MvvmStatefulWidget<CommandUsageViewModel> {
  const CommandUsageView(
    CommandUsageViewModel vm, {
    super.key,
  }) : super(vm);

  @override
  CommandUsageState createState() => CommandUsageState();
}

class CommandUsageState extends State<CommandUsageView> {
  CommandUsageState();

  @override
  Widget build(BuildContext context) {
    return MvvmBindingWidget<CommandUsageViewModel>(
      viewModel: widget.bindableBase,
      builder: (context, vm, child) {
        final vm = widget.bindableBase;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              vm.title,
            ),
          ),
          body: Column(
            children: <Widget>[
              ElevatedButton(
                key: const ValueKey('DisplayEmptyButton'),
                onPressed: vm.displayEmptyCommand.toResultCallback(
                  args: null,
                  fallback: Command.defaultVoidCallback,
                ),
                child: const Text('Display empty'),
              ),
              ElevatedButton(
                key: const ValueKey('DisplayInputValueButton'),
                onPressed: vm.displayInputValueCommand.toResultCallback(
                  args: 'Input value',
                  fallback: Command.defaultVoidCallback,
                ),
                child: const Text('Display input value'),
              ),
              ElevatedButton(
                key: const ValueKey('DisplayFutureEmptyButton'),
                onPressed: vm.displayFutureEmptyCommand.toResultCallback(
                  args: null,
                  fallback: Command.defaultFutureVoidCallback,
                ),
                child: const Text('Display future empty'),
              ),
              ElevatedButton(
                key: const ValueKey('DisplayEmptyWhenCanButton'),
                onPressed: vm.displayEmptyWhenCanCommand.toResultCallback(
                  args: null,
                  fallback: Command.defaultFutureVoidCallback,
                  handleCanExecute: true,
                ),
                child: const Text('Display empty when can'),
              ),
              ElevatedButton(
                key: const ValueKey('YearPickerButton'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: YearPicker(
                          key: const ValueKey('YearPicker'),
                          firstDate: DateTime(1970),
                          lastDate: DateTime.now(),
                          selectedDate: vm.selectedDate,
                          onChanged:
                              vm.selectDateCommand.toResultWithInputCallback(
                            fallback: Command.defaultVoidCallback,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text('Selected year: ${vm.selectedDate.year}'),
              ),
            ],
          ),
        );
      },
    );
  }
}
