part of flutter_mvvm.bindings;

mixin ViewSignalListenerMixin<TStatefulWidget extends MvvmStatefulWidget>
    on State<TStatefulWidget> {
  StreamSubscription<ViewSignalData>? _viewSignalStreamSubscription;

  @override
  void initState() {
    super.initState();
    _listenToViewSignal();
  }

  @override
  void didUpdateWidget(covariant TStatefulWidget oldWidget) {
    if (oldWidget.bindableBase != widget.bindableBase) {
      _cancelViewSignalStreamSubscription();
      _listenToViewSignal();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _listenToViewSignal() {
    _viewSignalStreamSubscription =
        widget.bindableBase.viewSignal.stream.listen(onViewSignalEmitted);
  }

  /// Override this method to handle view signal emitted by [BindableBase].
  @protected
  void onViewSignalEmitted(ViewSignalData viewSignalData);

  void _cancelViewSignalStreamSubscription() {
    _viewSignalStreamSubscription?.cancel();
  }

  @override
  void dispose() {
    _cancelViewSignalStreamSubscription();
    super.dispose();
  }
}
