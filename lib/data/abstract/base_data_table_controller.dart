import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/ffull_screenloader.dart';
import '../../common/widgets/loaders/floaders.dart';
import '../../features/shop/categories/model/category_model.dart';
import '../../utilis/constants/sizes.dart';

abstract class fBaseController<f> extends GetxController{
  RxBool isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<f> allItems = <f>[].obs;
  RxList<f> filteredItems = <f>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

  Future<void> deleteItem(f item);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<List<f>> fetchItems();

  bool containsSearchQuery(f item, String query);

  /// Common method for fetching data.
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<f> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      fLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }


  void searchQuery(String query) {
    filteredItems.assignAll(
      allItems.where((item) => containsSearchQuery(item, query))
    ); }

  void sortByProperty(int sortColumnIndex, bool ascending, Function(f) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a, b) {
      if(ascending) {
      return property(a).compareTo(property(b));
    } else {
      return property(b).compareTo(property(a));
    }
  });}

  void searchProperty(int sortColumnIndex, bool ascending, Function(f) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a, b) {
      if(ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  confirmDelete(f category) {
    Get.defaultDialog(
        title: "Delete Item",
        content: const Text("Are you sure you want to delete this item?"),
        confirm: SizedBox(
          width: 60,
          child: ElevatedButton(
              onPressed: () async => await deleteOnConfirm(category),
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: fSizes.buttonHeight / 2),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(fSizes.buttonRadius * 5))),
              child: Text("OK")),
        ),
        cancel: SizedBox(
          width: 80,
          child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: fSizes.buttonHeight / 2),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(fSizes.buttonRadius * 5))),
              child: Text("Cancel")),
        ));
  }

  Future<void> deleteOnConfirm(f items) async {
    try {
      // Remove the Confirmation Dialog
      fFullScreenLoader.stopLoading();

      // Start the loader
      fFullScreenLoader.PopUpCircular();

      // Delete Firestore Data
      await deleteItem(items);

      removeItemFromLists(items);

      fFullScreenLoader.stopLoading();
      fLoaders.successSnackBar(
          title: "Item Deleted", message: "Your Item has been Deleted");
    } catch (e) {
      fFullScreenLoader.stopLoading();
      fLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  // Method for removing an item from the lists.
  void removeItemFromLists(f item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));

  }

  void addItemToLists(f item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));

  }

  void updateItemFromLists(f item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if(itemIndex != -1) allItems[itemIndex] = item;
    if(filteredItemIndex != -1) filteredItems[itemIndex] = item;

    //Refresh the UI to reflect the changes
  }
}

