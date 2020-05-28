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

  FutureOr<void> ensureRunAfterContextAssigned(
      FutureOr<void> Function() task) async {
    if (task == null) return;
    if (context == null)
      contextNotifier.addListener(task);
    else
      await task();
  }
}

class InitParam {
  final dynamic param;
  final String hashAnchor;

  InitParam({
    this.param,
    this.hashAnchor,
  });
}

bool isDeepLinkRouteParam(dynamic param) {
  return param is Map<String, List<String>>;
}
