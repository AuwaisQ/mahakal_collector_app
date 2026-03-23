import 'package:flutter/foundation.dart';
import '../../../../appconstants.dart';
import '../../../../services/httpservice.dart';
import '../model/collectordashboard_model.dart';

class CollectorDashboardController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CollectorDashModel? _collectorDashModel;
  CollectorDashModel? get collectorDashModel => _collectorDashModel;

  List<TemplesDetail> _filteredTemples = [];
  List<TemplesDetail> get filteredTemples => _filteredTemples;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  /// Fetch Collector Dashboard Data
  Future<void> fetchCollectorDashboard() async {
    _setLoading(true);

    try {
      final res = await HttpService().postApi(
        AppConstants.collectorDashboardAPI,
      );

      debugPrint("Collector Dashboard API Response: $res");

      if (res != null) {
        _collectorDashModel = CollectorDashModel.fromJson(res);
        _filteredTemples = _collectorDashModel?.data?.temples ?? [];
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching collector dashboard: $e");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _setLoading(false);
    }
  }

  /// Filter temples based on search query
  void upDateSearchQuery(String query) {
    _searchQuery = query;

    if (_collectorDashModel?.data?.temples != null) {
      if (query.isEmpty) {
        _filteredTemples = _collectorDashModel?.data?.temples?? [];
      } else {
        _filteredTemples = _collectorDashModel!.data!.temples
            .where(
              (temple) =>
                  temple.name!.toLowerCase().contains(query.toLowerCase()),
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
