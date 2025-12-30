import 'package:collectorapp/services/httpservice.dart';
import 'package:flutter/cupertino.dart';
import '../../../../appconstants.dart';
import '../model/sdmdetails_model.dart';

class SDMDetailsController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SdmDetailsModel? _sdmDetailsModel;
  SdmDetailsModel? get sdmDetailsModel => _sdmDetailsModel;

  Future<void> fetchCollectorDetails(String mandirId) async {
    _setLoading(true);
    try {
      final res = await HttpService().getApi(
        AppConstants.sdmDetailsAPI + mandirId,
      );
      print("SDM Details Response is $res");

      if (res != null) {
        _sdmDetailsModel = SdmDetailsModel.fromJson(res);
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching SDM details: $e");
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
