part of flutter_mvvm.bindings;

abstract class MvvmStatelessWidget<V extends BindableBase>
    extends StatelessWidget implements BindableBaseHolder<V> {
  final V _bindableBase;

  V get bindableBase => _bindableBase;

  MvvmStatelessWidget(this._bindableBase, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    bindableBase.context = context;
    return null;
  }

  void dispose() {}
}
