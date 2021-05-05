part of flutter_mvvm.bindings;

/// Interface to be implemented by objects that retain references to view models.
abstract class BindableBaseHolder<T extends BindableBase> {
  /// The class's ViewModel reference.
  T get bindableBase;
}
