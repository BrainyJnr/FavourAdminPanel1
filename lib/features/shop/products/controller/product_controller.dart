import 'dart:math';

import 'package:favour_adminpanel/data/abstract/base_data_table_controller.dart';
import 'package:favour_adminpanel/features/shop/products/model/product_model.dart';
import 'package:favour_adminpanel/features/shop/products/repository/product_repository.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:get/get.dart';

class ProductController extends fBaseController<ProductModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _productRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
        item.stock.toString().contains(query) ||
        item.price.toString().contains(query);
  }

  @override
  Future<void> deleteItem(ProductModel item) async {
    await _productRepository.deleteProduct(item);
  }

  // Sorting related code
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductModel product) => product.title.toLowerCase());
  }

  // Sorting related code
  void sortByPrice(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (ProductModel product) => product.stock);
  }

  void sortBySoldItems(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductModel product) => product.soldQuantity);
  }

  String getProductPrice(ProductModel product) {
    // if no variation exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString() ||
        product.productVariation!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;

      // Calculate the smallest and largest prices among variations
      for (var variation in product.productVariation!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // if smallest and largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // Otherwise, return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  /// -- Calculate Discount Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- Calculate Product Stock
  String getProductStockTotal(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.stock.toString()
        : product.productVariation!
            .fold<int>(
                0, (previousValue, element) => previousValue + element.stock)
            .toString();
  }

  /// -- Calculate Product Sold Quantity
  String getProductSoldQuantity(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.soldQuantity.toString()
        : product.productVariation!
            .fold<int>(
                0,
                (previousValue, element) =>
                    previousValue + element.soldQuantity)
            .toString();
  }

  /// -- Check Product Stock Status
  String getProductStockStatus(ProductModel product) {
    return product.stock > 0 ? "In Stock" : "Out of Stock";
  }
}
