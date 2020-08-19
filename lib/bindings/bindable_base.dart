part of flutter_mvvm.bindings;

abstract class BindableBase extends ChangeNotifier {
  Widget boundView;

  BuildContext get context => contextNotifier.value;

  set context(BuildContext value) {
    contextNotifier.value = value;
  }

  ValueNotifier<BuildContext> contextNotifier = ValueNotifier(null);

  Function onContextAssigned;

  Future<void> initAsync({InitParam param}) async {
    return Future.value(null);
  }

  Future<void> unInitAsync() async {
    return Future.value(null);
  }

  @override
  void dispose() {
    contextNotifier.dispose();
    super.dispose();
  }
}

class InitParam {
  final dynamic param;
  final String hashAnchor;
  final Map<String, List<String>> deepLinkRouteParam;

  InitParam({
    this.param,
    this.hashAnchor,
    this.deepLinkRouteParam,
  });

  InitParam copyWith({
    param,
    hashAnchor,
    deepLinkRouteParam,
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
