import '../models/models.dart';

class CategoryProvider {
  final List<MCategory> _categories;
  final String _searchKey;

  CategoryProvider(this._categories, this._searchKey)
      : assert(_categories != null && _searchKey != null);

  List<MCategory> get categories => this
      ._categories
      .where((MCategory cat) =>
          cat.name.toLowerCase().startsWith(_searchKey.toLowerCase()))
      .toList();
}
