part of flutter_mvvm.bindings;

abstract class BindableBase extends ChangeNotifier {
  Widget? boundView;
  String? boundViewName;

  late BuildContext context;

  @deprecated
  Function? onContextAssigned;

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
