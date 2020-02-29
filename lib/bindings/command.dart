part of flutter_mvvm.bindings;

typedef Func = bool Function();

class AppCommand<T> extends Command<T> {
  AppCommand.withArgument(
    Function(T args) execute, {
    Func canExecute,
  }) : super(execute, canExecute: canExecute);

  AppCommand(
    Function() execute, {
    Func canExecute,
  }) : super(
          (void args) => execute(),
          canExecute: canExecute,
        );
}

abstract class Command<T extends Object> {
  @protected
  Function(T args) execute;

  bool get canExecute => _canExecute == null ? true : _canExecute();

  @protected
  Func _canExecute;

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
