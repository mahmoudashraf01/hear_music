import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<String?> pickImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    return image.path;
  } else {
    return null;
  }
}

Future<String?> pickAudioFromDevice() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);

  if (result != null && result.files.single.path != null) {
    return result.files.single.path;
  } else {
    return null;
  }
}

// Helper to sanitize file names
String sanitizeFileName(String name) {
  return name.trim().replaceAll(RegExp(r'[^\w]+'), '_').toLowerCase();
}

// Save file to app directory with a new name
Future<String> saveFileToAppDir(String originalPath, String newFileName) async {
  final appDir = await getApplicationDocumentsDirectory();
  final newPath = p.join(appDir.path, newFileName);
  final file = File(originalPath);
  final newFile = await file.copy(newPath);
  return newFile.path;
}