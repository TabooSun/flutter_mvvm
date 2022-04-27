part of flutter_mvvm.bindings;

class ViewSignalData {
  final String signalName;

  final dynamic data;

  const ViewSignalData({
    required this.signalName,
    this.data,
  });
}
