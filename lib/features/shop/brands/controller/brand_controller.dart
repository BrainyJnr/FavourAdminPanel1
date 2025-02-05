import 'package:favour_adminpanel/data/abstract/base_data_table_controller.dart';
import 'package:favour_adminpanel/features/shop/brands/model/brand_model.dart';
import 'package:favour_adminpanel/features/shop/brands/repository/brand_repository.dart';
import 'package:favour_adminpanel/features/shop/controller/category_controller.dart';
import 'package:get/get.dart';

class BrandController extends fBaseController<BrandModel> {
  static BrandController get instance => Get.find();

  final _brandRepository = Get.put(BrandRepository());
  final categoryController = Get.put(CategoryController());

  @override
  Future<List<BrandModel>> fetchItems() async {
    // Fetch Brands
    final fetchedBrands = await _brandRepository.getAllBrands();

    // Fetch Brand Categories Relational Data
    final fetchedBrandCategories = await _brandRepository.getAllBrandsCategory();

    // Fetch all Categories if data does not Already Exist
    if(categoryController.allItems.isNotEmpty) await categoryController.fetchItems();

    // Loop All Brands and Fetch Categories of Each
    for(var brands in fetchedBrands) {
      // Extract Categories from the Documents
      List<String> categoriesIds = fetchedBrandCategories
          .where((brandCategory) => brandCategory.brandId == brands.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();

      brands.brandCategories = categoryController.allItems.where((category) => categoriesIds.contains(category.id)).toList();
    }

    return fetchedBrands;
  }

  @override
  bool containsSearchQuery(BrandModel item, String query) {
    throw UnimplementedError();

  }

  @override
  Future<void> deleteItem(BrandModel item) {
    throw UnimplementedError();

  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (BrandModel b) => b.name.toLowerCase());
  }
}