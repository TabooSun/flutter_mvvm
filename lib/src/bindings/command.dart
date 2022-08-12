part of flutter_mvvm.bindings;

typedef CanExecutePredicate = bool Function();
typedef InputFactory<TReturn, TInput> = TReturn Function(
  TInput args,
);
typedef ResultCallback<TReturn> = TReturn Function();

class AppCommand<TReturn, TInput> extends Command<TReturn, TInput> {
  AppCommand.withArgument(
    InputFactory<TReturn, TInput> execute, {
    CanExecutePredicate? canExecute,
  }) : super(
          execute,
          canExecute: canExecute,
        );

  AppCommand(
    TReturn Function() execute, {
    CanExecutePredicate? canExecute,
  }) : this.withArgument(
          (_) => execute(),
          canExecute: canExecute,
        );
}

typedef TResultCallback<TReturn, TInput> = TReturn Function(
  TInput? args,
);

abstract class Command<TReturn, TInput> {
  static void Function() get defaultVoidCallback => () {};

  static Future<void> Function() get defaultFutureVoidCallback =>
      () => Future.value();

  final InputFactory<TReturn, TInput> _execute;

  bool get canExecute => _canExecute == null ? true : _canExecute!();

  final CanExecutePredicate? _canExecute;

  Command(
    InputFactory<TReturn, TInput> execute, {
    CanExecutePredicate? canExecute,
  })  : _execute = execute,
        _canExecute = canExecute;

  /// Convert [Command] to [ResultCallback]<[TReturn]>.
  ///
  /// If [handleCanExecute] is true, disable Flutter widget when [canExecute]
  /// return false. Default to false.
  ///
  /// {@template command.Command.toResultCallback}
  ///
  /// Trigger [executeIfCan] when Flutter executes the returning function.
  ///
  /// Provide [fallback] so that when [canExecute] return false, we can use the
  /// [fallback] to get a default value.
  ///
  /// Provide [customHandler] to take over the [executeIfCan] handling.
  ///
  /// {@endtemplate}
  ///
  /// See also:
  /// - [toResultWithInputCallback] - returns a function that accepts an input.
  ResultCallback<TReturn>? toResultCallback({
    bool handleCanExecute = false,
    required TInput args,
    required TReturn Function() fallback,
    TReturn Function(
      ResultCallback<TReturn>,
    )?
        customHandler,
  }) {
    if (handleCanExecute && !canExecute) {
      return null;
    }

    TReturn executeIfCanHandler() => executeIfCan(
          args: args,
          fallback: fallback,
        );

    if (customHandler != null) {
      return () => customHandler.call(executeIfCanHandler);
    }

    return executeIfCanHandler;
  }

  /// Convert [Command] to [InputFactory]<[TReturn], [TInput]>.
  ///
  /// {@macro command.Command.toResultCallback}
  ///
  /// See also:
  /// - [toResultCallback] - returns a function that accepts no input.
  InputFactory<TReturn, TInput> toResultWithInputCallback({
    required TReturn Function() fallback,
    TReturn Function(
      InputFactory<TReturn, TInput>,
    )?
        customHandler,
  }) {
    TReturn executeIfCanHandler(TInput args) => executeIfCan(
          args: args,
          fallback: fallback,
        );

    if (customHandler != null) {
      return (args) => customHandler.call(executeIfCanHandler);
    }
    return executeIfCanHandler;
  }

  TReturn executeIfCan({
    required TInput args,
    required TReturn Function() fallback,
  }) {
    if (canExecute) {
      return _execute(args);
    }

    return fallback();
  }
}
