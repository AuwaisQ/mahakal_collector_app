import 'package:collectorapp/appconstants.dart';
import 'package:collectorapp/services/httpservice.dart';
import 'package:flutter/cupertino.dart';
import '../model/collectorsdmlist_model.dart';

class CollectorSDMListController extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CollectorSdmListModel? _collectorSdmListModel;
  CollectorSdmListModel? get collectorSdmListModel => _collectorSdmListModel;

  List<SdmList> _filterCollectorSdmList = [];
  List<SdmList>  get filterCollectorSdmList => _filterCollectorSdmList;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Future<void> fetchCollectorSDMList() async {
    _setLoading(true);
    try{
      final res = await HttpService().getApi("${AppConstants.collectorSDMListAPI}");
      print("Collector SDM List $res");

      if(res !=null){
        _collectorSdmListModel = CollectorSdmListModel.fromJson(res);
        _filterCollectorSdmList = _collectorSdmListModel!.sdmList;
      }
    }catch (e, stackTrace) {
      debugPrint("Error fetching collector details: $e");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _setLoading(false);
    }
  }

  void searchSDMList(String query) {
    _searchQuery = query;

    if (_collectorSdmListModel?.sdmList != null) {
      if (query.isEmpty) {
        _filterCollectorSdmList = _collectorSdmListModel?.sdmList ?? [];
      } else {
        _filterCollectorSdmList = _collectorSdmListModel!.sdmList
            .where(
              (temple) =>
              temple.name.toLowerCase().contains(query.toLowerCase()),
        )
            .toList();
      }
    } else {
      _filterCollectorSdmList = [];
    }

    notifyListeners();
  }

  void _setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

}


