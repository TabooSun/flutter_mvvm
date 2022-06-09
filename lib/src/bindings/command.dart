part of flutter_mvvm.bindings;

typedef Func = bool Function();
typedef NullableInputFactory<T> = FutureOr<void> Function(T? args);

class AppCommand<T> extends Command<T> {
  AppCommand.withArgument(
    NullableInputFactory<T> execute, {
    Func? canExecute,
  }) : super(
          execute,
          canExecute: canExecute,
        );

  AppCommand(
    FutureOr<void> Function() execute, {
    Func? canExecute,
  }) : this.withArgument(
          (_) => execute(),
          canExecute: canExecute,
        );
}

abstract class Command<T> {
  @protected
  final FutureOr<void> Function(T? args) execute;

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
    Future<void> executeIfCanHandler() async => await executeIfCan(args: args);
    return (handleCanExecute && !canExecute)
        ? null
        : customHandler != null
            ? () => customHandler.call(executeIfCanHandler)
            : executeIfCanHandler;
  }

  Command(
    this.execute, {
    Func? canExecute,
  }) {
    _canExecute = canExecute;
  }

  FutureOr<void> executeIfCan({T? args}) {
    if (canExecute) {
      return execute(args);
    }
  }
}
