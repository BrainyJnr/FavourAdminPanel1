import 'package:favour_adminpanel/common/styles/frounded_container.dart';
import 'package:favour_adminpanel/features/media/controller/media_controller.dart';
import 'package:favour_adminpanel/utilis/constants/colors.dart';
import 'package:favour_adminpanel/utilis/constants/enums.dart';
import 'package:favour_adminpanel/utilis/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import '../../../common/styles/frounded_image.dart';
import '../model/image_model.dart';
import 'folder_dropdown.dart';

class MediaUploaded extends StatelessWidget {
  const MediaUploaded({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;

    return SingleChildScrollView(
      child: Obx(
            () => controller.showImagesUploadSection.value
            ? Column(
          children: [
            // Drag and Drop Area
            fRoundedContainer(
              height: 250,
              showBorder: true,
              borderColor: fColors.borderPrimary,
              backgroundColor: fColors.primaryBackground,
              padding: EdgeInsets.all(fSizes.defaultSpace),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        DropzoneView(
                          mime: const ['image/jpeg', 'image/png'],
                          cursor: CursorType.Default,
                          operation: DragOperation.copy,
                          onLoaded: () => print('Zone Loaded'),
                          onError: (ev) => print('Zone error: $ev'),
                          onDrop: (file) async =>
                          await controller.onDropFile(file),
                          onCreated: (ctrl) =>
                          controller.dropzoneController = ctrl,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg",
                              width: 140,
                              height: 100,
                            ),
                            const SizedBox(height: 5),
                            const Text("Drag and Drop Images Here"),
                            const SizedBox(height: fSizes.spaceBtwItems),
                            OutlinedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Colors.black),
                                backgroundColor: fColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () =>
                                  controller.selectLocalImages(),
                              child: const Text(
                                "Select Images",
                                style: TextStyle(color: fColors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: fSizes.spaceBtwItems),

            // Locally Selected Images
            if (controller.selectImagesToUpload.isNotEmpty)
              fRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Select Folder",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(width: fSizes.spaceBtwItems),
                            MediaFolderDropdown(
                              onChanged: (MediaCategory? newValue) {
                                if (newValue != null) {
                                  controller.selectedPath.value = newValue;
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.selectImagesToUpload.clear();
                              },
                              child: const Text("Remove All"),
                            ),
                            const SizedBox(width: fSizes.spaceBtwItems),
                            SizedBox(
                              width: fSizes.buttonWidth,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: fColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () =>
                                    controller.uploadImageConfirmation(),
                                child: const Text(
                                  "Upload",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: fSizes.spaceBtwSections),
                    Wrap(
                      children: controller.selectImagesToUpload
                          .map(
                            (image) => Container(
                          width: 90,
                          height: 90,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child: image.localImageToDisplay != null
                              ? ClipRRect(
                            borderRadius:
                            BorderRadius.circular(8),
                            child: Image.memory(
                              image.localImageToDisplay!,
                              fit: BoxFit.cover,
                            ),
                          )
                              : const Center(
                            child: Icon(Icons.image,
                                color: Colors.grey),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
          ],
        )
            : const SizedBox.shrink(),
      ),
    );
  }
}
