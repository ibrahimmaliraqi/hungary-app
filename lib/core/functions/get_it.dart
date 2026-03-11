import '../utils/pref_helpers.dart';

Future<String> getId() async {
  String? id = await PrefHelpers.getToken();
  return id ?? "";
}
