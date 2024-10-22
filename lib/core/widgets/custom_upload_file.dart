import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soundmind_therapist/core/extensions/context_extensions.dart';
import 'package:soundmind_therapist/core/extensions/widget_extensions.dart';
import 'package:soundmind_therapist/core/gen/assets.gen.dart';
import 'package:soundmind_therapist/core/utils/image_util.dart';
import 'package:soundmind_therapist/features/Authentication/presentation/views/create_account/verification_info.dart';

class Uploadfile extends StatefulWidget {
  const Uploadfile({super.key, required this.title, required this.onTap});
  final String title;
  final Function(File? file, int type) onTap;

  @override
  State<Uploadfile> createState() => _UploadfileState();
}

class _UploadfileState extends State<Uploadfile> {
  File? imageFile;

  File? pdfFile;
  PDFDocument? pdfDocument;
  onImagePicker() async {
    imageFile = await ImageUtils.pickImage();

    if (imageFile != null) {
      pdfFile = null;
    }
    setState(() {});
    widget.onTap(imageFile, 2);
  }

  addFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    if (result != null) {
      if (result.paths.first != null) {
        pdfFile = File(result.paths.first!);
        if (pdfFile != null) {
          imageFile = null;
          pdfDocument = await PDFDocument.fromFile(File(pdfFile!.path));
          setState(() {});
          widget.onTap(pdfFile, 1);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget loadDisplay() {
      if (imageFile != null) {
        return Image.asset(
          imageFile!.path,
          fit: BoxFit.cover,
        );
      } else if (pdfFile != null && pdfDocument != null) {
        return PDFViewer(
          document: pdfDocument!,
        );
      } else {
        return EmptyUpload();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const Gap(5),
        DottedBorder(
          color: context.colors.black,
          strokeWidth: 1,
          dashPattern: const [4, 10],
          borderType: BorderType.Rect,
          child: SizedBox(
            width: context.screenWidth * .9,
            height: 120,
            child: loadDisplay(),
          ),
        ).withOnTap(() {
          showModalBottomSheet(
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10),
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: context.secondaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.image_sharp,
                            color: context.primaryColor,
                            // size: 40,
                          ).toCenter().withPadding(const EdgeInsets.all(10)),
                        ).withOnTap(() {
                          onImagePicker();
                        }),
                        Text(
                          "Add Image",
                          style: context.textTheme.bodyLarge,
                        )
                      ],
                    ),
                    const Gap(50),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: context.secondaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.file_present,
                            color: context.primaryColor,
                            // size: 40,
                          ).toCenter().withPadding(const EdgeInsets.all(10)),
                        ).withOnTap(() {
                          addFilePicker();
                        }),
                        Text(
                          "Add File",
                          style: context.textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        })
      ],
    );
  }
}

class EmptyUpload extends StatelessWidget {
  const EmptyUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: context.secondaryColor,
          radius: 25,
          child:
              Assets.application.assets.svgs.upload.svg(height: 24, width: 24),
        ),
        const Gap(5),
        const Text("Upload file")
      ],
    );
  }
}
