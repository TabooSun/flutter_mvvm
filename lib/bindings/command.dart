part of flutter_mvvm.bindings;

typedef Func = bool Function();

class AppCommand<T> extends Command<T> {
  AppCommand.withArgument(
    Function(T args) execute, {
    Func canExecute,
  }) : super(
          execute,
          canExecute: canExecute,
        );

  AppCommand(
    Function() execute, {
    Func canExecute,
  }) : super(
          (_) => execute(),
          canExecute: canExecute,
        );
}

abstract class Command<T extends Object> {
  @protected
  Function(T args) execute;

  bool get canExecute => _canExecute == null ? true : _canExecute();

  @protected
  Func _canExecute;

  /// Convert [Command] to [VoidCallback].
  ///
  /// If [handleCanExecute] is true, disable Flutter widget if [canExecute]
  /// return false. Default to false.
  VoidCallback toVoidCallback({
    T args,
    bool handleCanExecute = false,
    void Function(VoidCallback) customHandler,
  }) {
    assert(handleCanExecute != null);

    final executeIfCanHandler = () => executeIfCan(args: args);
    return (handleCanExecute && !canExecute)
        ? null
        : customHandler != null
            ? () => customHandler?.call(executeIfCanHandler)
            : executeIfCanHandler;
  }

  Command(
    this.execute, {
    Func canExecute,
  }) {
    this._canExecute = canExecute;
  }

  void executeIfCan({T args}) {
    if (canExecute) {
      execute(args);
      return;
    }
  }
}
