part of flutter_mvvm.bindings;

abstract class MvvmStatelessWidget<V extends BindableBase>
    extends StatelessWidget implements BindableBaseHolder<V> {
  final V _bindableBase;

  @override
  V get bindableBase => _bindableBase;

  const MvvmStatelessWidget(this._bindableBase, {Key? key}) : super(key: key);

  void dispose() {}
}
