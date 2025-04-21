import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants/color_constants.dart';

class IdProofUpload extends StatefulWidget {
  const IdProofUpload({super.key});

  @override
  _IdProofUploadState createState() => _IdProofUploadState();
}

class _IdProofUploadState extends State<IdProofUpload> {
  TextEditingController controller = TextEditingController();
  File? selectedIdProofImage;

  Future<void> _pickIdProofImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedIdProofImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: _pickIdProofImage,
        child: Container(
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorConstants.primaryRed.withOpacity(  0.2),
          ),
          child: Center(
            child: selectedIdProofImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(File(selectedIdProofImage!.path),
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.fitWidth),
                  )
                : Icon(Icons.image, size: 50, color: ColorConstants.grey),
          ),
        ),
      ),
    );
  }
}
