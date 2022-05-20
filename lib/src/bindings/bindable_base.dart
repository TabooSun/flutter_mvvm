part of flutter_mvvm.bindings;

abstract class BindableBase extends ChangeNotifier {
  /// A signal for publishing event to view.
  ///
  /// Support publishing event to [MvvmStatefulWidget] only.
  ///
  /// To receive events, mixin the [ViewSignalListenerMixin] to the view state.
  final StreamController<ViewSignalData> viewSignal =
      StreamController.broadcast();

  /// The view of this view model.
  Widget? boundView;

  /// The [boundView]'s name.
  String? boundViewName;

  /// The route that renders the [boundView].
  Route<dynamic>? boundRoute;

  /// ## The context from [boundView].
  ///
  /// This is often being assigned from the [StatelessWidget.build] or
  /// [StatefulElement.build].
  BuildContext? _context;

  /// ## The context from [boundView].
  ///
  /// This is often being assigned from the [StatelessWidget.build] or
  /// [StatefulElement.build].
  BuildContext get context => _context ?? retrieveFallbackContext();

  /// ## The context from [boundView].
  ///
  /// This is often being assigned from the [StatelessWidget.build] or
  /// [StatefulElement.build].
  set context(BuildContext context) {
    _context = context;
  }

  /// Retrieve fallback context.
  ///
  /// Subclasses must override this to provide a fallback context.
  ///
  /// This is typically from [WidgetsApp.builder]'s [TransitionBuilder].
  BuildContext retrieveFallbackContext();

  Future<void> initAsync({required InitParam param}) async {
    return Future.value(null);
  }

  Future<void> unInitAsync() async {
    return Future.value(null);
  }

  void emitSignal(ViewSignalData data) {
    viewSignal.add(data);
  }

  @override
  void dispose() {
    viewSignal.close();
    super.dispose();
  }
}

class InitParam {
  final dynamic param;
  final String? hashAnchor;
  final Map<String, List<String>>? deepLinkRouteParam;
  final Map<String, String>? pathParameters;

  const InitParam({
    this.param,
    this.hashAnchor,
    this.deepLinkRouteParam,
    this.pathParameters,
  });

  InitParam copyWith({
    dynamic param,
    String? hashAnchor,
    Map<String, List<String>>? deepLinkRouteParam,
    Map<String, String>? pathParameters,
  }) {
    return InitParam(
      param: param ?? this.param,
      hashAnchor: hashAnchor ?? this.hashAnchor,
      deepLinkRouteParam: deepLinkRouteParam ?? this.deepLinkRouteParam,
      pathParameters: pathParameters ?? this.pathParameters,
    );
  }
}

bool checkIsMap(dynamic param) {
  return param is Map<String, List<String>>;
}
