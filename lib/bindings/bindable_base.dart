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

  void ensureRunAfterContextAssigned(VoidCallback task){
    if(task == null) return;
    if(context == null)
      contextNotifier.addListener(task);
    else
      task();
  }
}

class InitParam {
  final dynamic param;

  InitParam({
    this.param,
  });
}

bool isDeepLinkRouteParam(dynamic param) {
  return param is Map<String, List<String>>;
}
