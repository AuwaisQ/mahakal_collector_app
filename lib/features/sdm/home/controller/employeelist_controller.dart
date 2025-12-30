import 'package:collectorapp/appconstants.dart';
import 'package:collectorapp/services/httpservice.dart';
import 'package:flutter/cupertino.dart';
import '../model/sdmemployeelist_model.dart';

class EmployeeListController extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  SdmEmployeeListModel? _employeeListModel;
  SdmEmployeeListModel? get employeeListModel => _employeeListModel;

  List<EmployeeList> _filterEmployeeList = [];
  List<EmployeeList>  get filterEmployeeList => _filterEmployeeList;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Future<void> fetchEmployeeList() async {
    _setLoading(true);
    try{
      final res = await HttpService().getApi("${AppConstants.sdmEmployeeListAPI}");
      print("SDM Employee List $res");

      if(res !=null){
        _employeeListModel = SdmEmployeeListModel.fromJson(res);
        _filterEmployeeList = _employeeListModel!.employeeList;
      }
    }catch (e, stackTrace) {
      debugPrint("Error fetching collector details: $e");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _setLoading(false);
    }
  }

  void searchEmployeeList(String query) {
    _searchQuery = query;

    if (_employeeListModel?.employeeList != null) {
      if (query.isEmpty) {
        _filterEmployeeList = _employeeListModel?.employeeList ?? [];
      } else {
        _filterEmployeeList = _employeeListModel!.employeeList
            .where(
              (temple) =>
              temple.name.toLowerCase().contains(query.toLowerCase()),
        )
            .toList();
      }
    } else {
      _filterEmployeeList = [];
    }

    notifyListeners();
  }

  void _setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

}


