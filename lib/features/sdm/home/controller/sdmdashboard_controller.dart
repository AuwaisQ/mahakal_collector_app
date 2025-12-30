import 'package:flutter/foundation.dart';
import '../../../../appconstants.dart';
import '../../../../services/httpservice.dart';
import '../model/sdmdashboard_model.dart';

class SDMDashboardController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SdmDashboardModel? _SDMDashModel;
  SdmDashboardModel? get SDMDashModel => _SDMDashModel;

  List<SDMTemplesDetail> _filteredTemples = [];
  List<SDMTemplesDetail> get filteredTemples => _filteredTemples;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  /// Fetch SDM Dashboard Data
  Future<void> fetchSDMDashboard() async {
    _setLoading(true);

    try {
      final res = await HttpService().getApi(
        AppConstants.sdmDashboardAPI,
      );

      debugPrint("SDM Dashboard API Response: $res");

      if (res != null) {
        _SDMDashModel = SdmDashboardModel.fromJson(res);
        print("SDM Model Data:$_SDMDashModel");

        _filteredTemples = _SDMDashModel?.sdmDetail?.templesDetail ?? [];
        print("SDM Temple:$_filteredTemples");
        notifyListeners();
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching SDM dashboard: $e");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _setLoading(false);
    }
  }

  /// Filter temples based on search query
  void upDateSearchQuery(String query) {
    _searchQuery = query;

    if (_SDMDashModel?.sdmDetail?.templesDetail != null) {
      if (query.isEmpty) {
        _filteredTemples = _SDMDashModel?.sdmDetail?.templesDetail ?? [];
      } else {
        _filteredTemples = _SDMDashModel!.sdmDetail!.templesDetail!.where(
              (temple) =>
              temple.name.toLowerCase().contains(query.toLowerCase()),
        )
            .toList();
      }
    } else {
      _filteredTemples = [];
    }

    notifyListeners();
  }

  /// Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
