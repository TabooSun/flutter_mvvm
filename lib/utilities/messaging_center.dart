part of flutter_mvvm.utilities;

typedef void MessageCallBack(MessageData data);

class MessageData {
  final Object sender;
  final Object args;

  MessageData(this.sender, this.args);
}

class MessagingCenter {
  static final Map<String, StreamController<MessageData>> _messages = Map();
  static final Map<String, StreamSubscription<MessageData>> _subscriptions =
      Map();

  static void send(
    String messageKey,
    Object sender, {
    dynamic args,
  }) {
    _messages[messageKey]?.add(MessageData(sender, args));
  }

  static StreamSubscription subscribe(
    String messageKey,
    Object subscriber,
    MessageCallBack callBack,
  ) {
    assert(isNotBlank(messageKey), "messageKey must not be empty");
    assert(subscriber != null, "subscriber must not be null");
    assert(callBack != null, "callBack must not be null");

    _createStreamCtrlByMessageKeyIfAbsent(messageKey);

    String hashedKey = _getHashedKey(messageKey, subscriber);
    assert(
      !_subscriptions.containsKey(hashedKey),
      '''You cannot subscribe to the same event (messageKey) with same 
      subsriber, if you want to do so, please unsubscribe and resubscribe.''',
    );
    var subscription = _messages[messageKey].stream.listen(callBack);
    _subscriptions[hashedKey] = subscription;
    return subscription;
  }

  static Future<void> unsubscribe(String messageKey, Object subscriber) async {
    assert(isNotBlank(messageKey), "messageKey must not be empty");
    assert(subscriber != null, "subscriber must not be null");

    String hashedKey = _getHashedKey(messageKey, subscriber);
    var subscription = _subscriptions.remove(hashedKey);
    await subscription?.cancel();
  }

  static Future<void> unsubscribeAll() async {
    for (var e in _subscriptions.keys) {
      var subscription = _subscriptions.remove(e);
      await subscription?.cancel();
    }
  }

  /// Clean all streams and subscribers
  static Future<void> clean() async {
    var clearMessages = Future.forEach(_messages.entries,
        (MapEntry<String, StreamController<MessageData>> e) async {
      var streamCtrl = _messages.remove(e.key);
      await streamCtrl?.close();
    });

    await Future.wait([unsubscribeAll(), clearMessages]);
  }

  static String _getHashedKey(String messageKey, Object subscriber) {
    var bytes = utf8.encode(messageKey + subscriber?.hashCode?.toString());
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static void _createStreamCtrlByMessageKeyIfAbsent(
    String messageKey,
  ) {
    _messages.putIfAbsent(
      messageKey,
      () => StreamController.broadcast(sync: true),
    );
  }
}
