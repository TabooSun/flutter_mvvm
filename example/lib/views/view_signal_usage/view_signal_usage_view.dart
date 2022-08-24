import 'package:example/views/view_signal_usage/view_signal_usage_view_model.dart';
import 'package:example/views/view_signal_usage/view_signal_usage_view_signal_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/flutter_mvvm.dart';

class ViewSignalUsageView extends MvvmStatefulWidget<ViewSignalUsageViewModel> {
  const ViewSignalUsageView(
    ViewSignalUsageViewModel vm, {
    super.key,
  }) : super(vm);

  @override
  ViewSignalUsageViewState createState() => ViewSignalUsageViewState();
}

class ViewSignalUsageViewState extends State<ViewSignalUsageView>
    with ViewSignalListenerMixin<ViewSignalUsageView> {
  String? text;

  ViewSignalUsageViewState();

  @override
  void initState() {
    widget.bindableBase.initAsync(param: const InitParam());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MvvmBindingWidget<ViewSignalUsageViewModel>(
      viewModel: widget.bindableBase,
      builder: (context, vm, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('View signal usage'),
          ),
          body: Center(
            child: Text('Rendering text: ${text ?? ''}'),
          ),
        );
      },
    );
  }

  @override
  void onViewSignalEmitted(ViewSignalData viewSignalData) {
    switch (viewSignalData.signalName) {
      case ViewSignalUsageViewSignalKey.updateText:
        text = viewSignalData.data;
        setState(() {});
        break;
      default:
    }
  }
}
