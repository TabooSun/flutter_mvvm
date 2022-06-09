part of flutter_mvvm.bindings;

class MvvmBindingWidget<T extends BindableBase> extends StatefulWidget {
  final T viewModel;

  /// {@template provider.consumer.builder}
  /// Build a widget tree based on the value from a [Provider<T>].
  ///
  /// Must not be null.
  /// {@endtemplate}
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  final bool isReuse;

  const MvvmBindingWidget({
    Key? key,
    required this.viewModel,
    required this.builder,
    this.isReuse = false,
  }) : super(key: key);

  @override
  State<MvvmBindingWidget<T>> createState() => _MvvmBindingWidgetState<T>();
}

class _MvvmBindingWidgetState<T extends BindableBase>
    extends State<MvvmBindingWidget<T>> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.context = context;
    widget.viewModel.mvvmBindingWidgetState = this;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isReuse) {
      return ChangeNotifierProvider<T>.value(
        value: widget.viewModel,
        child: Consumer<T>(builder: widget.builder),
      );
    }
    return ChangeNotifierProvider<T>(
      create: (c) {
        return widget.viewModel;
      },
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
