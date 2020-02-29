part of flutter_mvvm.bindings;

abstract class MvvmStatefulWidget<V extends BindableBase> extends StatefulWidget
    implements BindableBaseHolder<V> {
  final V _bindableBase;

  V get bindableBase => _bindableBase;

  @mustCallSuper
  MvvmStatefulWidget(this._bindableBase, {Key key}) : super(key: key);

  void dispose() {}
}
