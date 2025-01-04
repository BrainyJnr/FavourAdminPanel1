import 'package:favour_adminpanel/features/media/controller/media_controller.dart';
import 'package:favour_adminpanel/features/media/model/image_model.dart';
import 'package:get/get.dart';

class ProductImageController extends GetxController {
  static ProductImageController get instance => Get.find();

  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  final RxList<String> additionalProductImageUrls = <String>[].obs;

  // Pick ThumbnailImage from Media

  void selectedThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImage = await controller.selectedImageFromMedia();

    // Handle the selected images
    if (selectedImage != null && selectedImage.isNotEmpty) {
      // Get selected image to the main image or perform any other action
      ImageModel selectedImages = selectedImage.first;
      // Update the main image using the selectedImage
      selectedThumbnailImageUrl.value = selectedImages.url;
    }
  }

  // Pick Multiple Images from Media

  void selectedMultipleProductImages() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages =
    await controller.selectedImageFromMedia(
      multipleSelection: true, selectedUrls: additionalProductImageUrls
    );

    if(selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImageUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }

  // Function to remove Product Image
  Future<void> removeImage(int index) async {
    additionalProductImageUrls.removeAt(index);
  }
}