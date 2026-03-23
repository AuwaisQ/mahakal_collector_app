import 'package:collectorapp/appconstants.dart';
import 'package:collectorapp/services/httpservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/collectortemplelist_model.dart';
import 'package:intl/intl.dart';

class CollectorTempleListController extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CollectorTempleListModel? _collectorTempleListModel;
  CollectorTempleListModel? get collectorTempleListModel => _collectorTempleListModel;

  List<TempleList> _filterCollectorTempleList = [];
  List<TempleList>  get filterTempleList => _filterCollectorTempleList;

  List<TempleList> _originalTempleList = []; // Store original list

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String _selectedFilter = 'All';
  String get selectedFilter => _selectedFilter;

  final List<String> _availableFilters = ['All', 'Open Now', 'Closed Now', 'Morning', 'Evening'];
  List<String> get availableFilters => _availableFilters;

  Future<void> fetchCollectorTempleList(String templeId) async {
    _setLoading(true);

    print("Collector Id $templeId");

    try{
      final res = await HttpService().getApi("${AppConstants.collectorTempleListAPI}$templeId/temples");
      print("Collector Temple List $res");

      if(res !=null){
        _collectorTempleListModel = CollectorTempleListModel.fromJson(res);
        _originalTempleList = _collectorTempleListModel!.data!.temples;
        _filterCollectorTempleList = _originalTempleList;
      }
    }catch (e, stackTrace) {
      debugPrint("Error fetching temple list: $e");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _setLoading(false);
    }
  }

  void searchTempleList(String query) {
    _searchQuery = query;
    _applyFilter(_selectedFilter, searchQuery: query);
  }

  void applyFilter(String filter) {
    _selectedFilter = filter;
    _applyFilter(filter, searchQuery: _searchQuery);
  }

  void _applyFilter(String filter, {String? searchQuery}) {
    if (_originalTempleList.isEmpty) {
      _filterCollectorTempleList = [];
      notifyListeners();
      return;
    }

    // First apply search filter
    List<TempleList> tempList = _originalTempleList;

    if (searchQuery != null && searchQuery.isNotEmpty) {
      tempList = _originalTempleList
          .where((temple) =>
          temple.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Then apply time filter
    switch (filter) {
      case 'All':
        _filterCollectorTempleList = tempList;
        break;

      case 'Open Now':
        _filterCollectorTempleList = tempList.where((temple) {
          return checkIfOpenNow(temple);
        }).toList();
        break;

      case 'Closed Now':
        _filterCollectorTempleList = tempList.where((temple) {
          return !checkIfOpenNow(temple);
        }).toList();
        break;

      case 'Morning':
        _filterCollectorTempleList = tempList.where((temple) {
          return _isMorningTemple(temple);
        }).toList();
        break;

      case 'Evening':
        _filterCollectorTempleList = tempList.where((temple) {
          return _isEveningTemple(temple);
        }).toList();
        break;

      default:
        _filterCollectorTempleList = tempList;
    }

    notifyListeners();
  }

  // Helper function to check if temple is open now
  bool checkIfOpenNow(TempleList temple) {
    try {
      final openingTime = temple.openingTime ?? '05:00:00';
      final closingTime = temple.closeingTime ?? '19:00:00';

      final now = TimeOfDay.now();
      final openTime = _parseTime(openingTime);
      final closeTime = _parseTime(closingTime);

      if (openTime == null || closeTime == null) return false;

      final nowInMinutes = now.hour * 60 + now.minute;
      final openInMinutes = openTime.hour * 60 + openTime.minute;
      final closeInMinutes = closeTime.hour * 60 + closeTime.minute;

      return nowInMinutes >= openInMinutes && nowInMinutes <= closeInMinutes;
    } catch (e) {
      return false;
    }
  }

  // Parse time string to TimeOfDay
  TimeOfDay? _parseTime(String timeString) {
    try {
      final time = DateFormat('HH:mm:ss').parse(timeString);
      return TimeOfDay.fromDateTime(time);
    } catch (e) {
      return null;
    }
  }

  // Helper function to check if it's a morning temple (opens before 12 PM)
  bool _isMorningTemple(TempleList temple) {
    try {
      final openingTime = temple.openingTime ?? '05:00:00';
      final time = _parseTime(openingTime);
      if (time == null) return false;

      // Morning temples: Open before 12 PM
      return time.hour < 12;
    } catch (e) {
      return false;
    }
  }

  // Helper function to check if it's an evening temple (opens after 12 PM)
  bool _isEveningTemple(TempleList temple) {
    try {
      final openingTime = temple.openingTime ?? '17:00:00';
      final time = _parseTime(openingTime);
      if (time == null) return false;

      // Evening temples: Open at or after 12 PM
      return time.hour >= 12;
    } catch (e) {
      return false;
    }
  }

  void _setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  // Format time helper for UI
  String formatTime(String timeString) {
    try {
      final time = DateFormat('HH:mm:ss').parse(timeString);
      return DateFormat('hh:mm a').format(time);
    } catch (e) {
      return timeString;
    }
  }
}