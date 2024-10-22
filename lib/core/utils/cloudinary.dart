import 'package:cloudinary/cloudinary.dart';

class CloudinaryUtil {
  static Future<String?> uplaodTOCloundinary(
      String path, String email, String folder) async {
    final cloudinary = Cloudinary.signedConfig(
      apiKey: '314639493738266',
      apiSecret: '_BBDkH-rSxAxlg58lec-u6Wu-Ek',
      cloudName: 'dwwzrtzb8',
    );
    final response = await cloudinary.upload(
      file: path,
      // fileBytes: file.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: folder,
      fileName: email,
      progressCallback: (count, total) {
        print('Uploading image from file with progress: $count/$total');
      },
    );

    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
      return response.secureUrl!;
    }
    return null;
  }
}
