import '../models/models.dart';

class CategoryProvider {
  List<MCategory> _categories = [];
  CategoryProvider(this._categories);
  List<MCategory> get categories => this._categories;
}
