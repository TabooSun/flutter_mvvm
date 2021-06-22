part of flutter_mvvm.bindings;

abstract class BindableBase extends ChangeNotifier {
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
}

class InitParam {
  final dynamic param;
  final String? hashAnchor;
  final Map<String, List<String>>? deepLinkRouteParam;

  const InitParam({
    this.param,
    this.hashAnchor,
    this.deepLinkRouteParam,
  });

  InitParam copyWith({
    dynamic param,
    String? hashAnchor,
    Map<String, List<String>>? deepLinkRouteParam,
  }) =>
      InitParam(
        param: param ?? this.param,
        deepLinkRouteParam: deepLinkRouteParam ?? this.deepLinkRouteParam,
        hashAnchor: hashAnchor ?? this.hashAnchor,
      );
}

bool checkIsMap(dynamic param) {
  return param is Map<String, List<String>>;
}
