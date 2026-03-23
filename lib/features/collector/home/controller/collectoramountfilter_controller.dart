import 'package:collectorapp/appconstants.dart';
import 'package:collectorapp/services/httpservice.dart';
import 'package:flutter/cupertino.dart';
import '../model/amountfilter_model.dart';
import 'package:intl/intl.dart';

class CollectorAmountFilterController extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CollectorAmountFilterModel? _amountFilterModel;
  CollectorAmountFilterModel? get amountFilterModel => _amountFilterModel;

  // Helper method to get date range based on filter type
  Map<String, String> _getDateRange(FilterType filterType, DateTime selectedDate,) {
    switch (filterType) {
      case FilterType.daily:
        final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);
        return {
          'startDate': dateStr,
          'endDate': dateStr
        };

      case FilterType.weekly:
      // Get Monday of the week
        final startOfWeek = selectedDate.subtract(
            Duration(days: selectedDate.weekday - 1)
        );
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return {
          'startDate': DateFormat('yyyy-MM-dd').format(startOfWeek),
          'endDate': DateFormat('yyyy-MM-dd').format(endOfWeek)
        };

      case FilterType.monthly:
        final startOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
        final endOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
        return {
          'startDate': DateFormat('yyyy-MM-dd').format(startOfMonth),
          'endDate': DateFormat('yyyy-MM-dd').format(endOfMonth)
        };

      case FilterType.yearly:
        final startOfYear = DateTime(selectedDate.year, 1, 1);
        final endOfYear = DateTime(selectedDate.year, 12, 31);
        return {
          'startDate': DateFormat('yyyy-MM-dd').format(startOfYear),
          'endDate': DateFormat('yyyy-MM-dd').format(endOfYear)
        };
    }
  }

  Future<void> fetchAmountFilter({
    required FilterType filterType,
    required DateTime selectedDate,
    required String templeId
  }) async {
    _setLoading(true);
    try {
      // Get date range based on filter type
      final dateRange = _getDateRange(filterType, selectedDate);

      Map<String, dynamic> data = {
        "start_date": "${dateRange['startDate']}",
        "end_date": "${dateRange['endDate']}",
        "temple_id": templeId
      };

      // Create API URL with start and end date
      final apiUrl = '${AppConstants.collectorAmountFilterAPI}';

      print("Amount Filter API URL: $apiUrl");

      final res = await HttpService().postApi(apiUrl,data);
      print("Amount Filter Response $res");

      if(res != null){
        _amountFilterModel = CollectorAmountFilterModel.fromJson(res);
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching amount filter: $e");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _setLoading(false);
    }
  }

  void clearFilter() {
    _amountFilterModel = null;
    notifyListeners();
  }

  void _setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
}

// Define FilterType enum
enum FilterType {
  daily,
  weekly,
  monthly,
  yearly
}