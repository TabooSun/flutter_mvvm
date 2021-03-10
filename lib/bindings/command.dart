part of flutter_mvvm.bindings;

typedef Func = bool Function();

class AppCommand<T> extends Command<T> {
  AppCommand.withArgument(
    FutureOr<void> Function(T args) execute, {
    Func? canExecute,
  }) : super(
          execute,
          canExecute: canExecute,
        );

  AppCommand(
    FutureOr<void> Function() execute, {
    Func? canExecute,
  }) : super.nullable(
          (_) => execute(),
          canExecute: canExecute,
        );
}

abstract class Command<T> {
  @protected
  FutureOr<void> Function(T args)? execute;

  @protected
  FutureOr<void> Function(T? args)? nullableInputExecute;

  bool get canExecute => _canExecute == null ? true : _canExecute!();

  @protected
  Func? _canExecute;

  /// Convert [Command] to [VoidCallback].
  ///
  /// If [handleCanExecute] is true, disable Flutter widget if [canExecute]
  /// return false. Default to false.
  VoidCallback? toVoidCallback({
    T? args,
    bool handleCanExecute = false,
    void Function(VoidCallback)? customHandler,
  }) {
    final executeIfCanHandler = () async => await executeIfCan(args: args);
    return (handleCanExecute && !canExecute)
        ? null
        : customHandler != null
            ? () => customHandler.call(executeIfCanHandler)
            : executeIfCanHandler;
  }

  Command.nullable(
    this.nullableInputExecute, {
    Func? canExecute,
  }) {
    this._canExecute = canExecute;
  }

  Command(
    this.execute, {
    Func? canExecute,
  }) {
    this._canExecute = canExecute;
  }

  FutureOr<void> executeIfCan({T? args}) {
    if (canExecute) {
      if(args ==null) {
        return nullableInputExecute!(args);
      }

      return execute!(args);
    }
  }
}
