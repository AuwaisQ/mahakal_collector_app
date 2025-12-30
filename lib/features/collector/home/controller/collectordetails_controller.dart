import 'package:collectorapp/services/httpservice.dart';
import 'package:flutter/cupertino.dart';
import '../../../../appconstants.dart';
import '../model/collectordetails_model.dart';

class CollectorDetailsController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CollectorDetailsModel? _collectorDetailsModel;
  CollectorDetailsModel? get collectorDetailsModel => _collectorDetailsModel;

  Future<void> fetchCollectorDetails(String mandirId) async {
    _setLoading(true);
    try {
      final res = await HttpService().getApi(
        AppConstants.collectorDetailsAPI + mandirId,
      );
      print("Collector Details Response is $res");

      if (res != null) {
        _collectorDetailsModel = CollectorDetailsModel.fromJson(res);
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching collector details: $e");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
