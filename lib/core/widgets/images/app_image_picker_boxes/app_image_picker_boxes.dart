import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_file_picker/app_file_picker.dart';
import 'package:poochcare/core/widgets/images/app_image_picker_boxes/image_slot.dart';

class AppImagePickerBoxes extends StatefulWidget {
  const AppImagePickerBoxes({
    super.key,
    this.totalSlots = 3,
    this.slotSpacing = 12,

    this.onChanged,
  }) : assert(totalSlots > 0);

  final int totalSlots;
  final double slotSpacing;
  final ValueChanged<List<File?>>? onChanged;

  @override
  State<AppImagePickerBoxes> createState() => _AppImagePickerBoxesState();
}

class _AppImagePickerBoxesState extends State<AppImagePickerBoxes> {
  late final List<File?> _images;

  @override
  void initState() {
    super.initState();
    _images = List<File?>.filled(widget.totalSlots, null);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final spacing = widget.slotSpacing.w;
        final totalSpacing = spacing * (widget.totalSlots - 1);
        final rawSize = (availableWidth - totalSpacing) / widget.totalSlots;
        final itemSize = rawSize.clamp(90.0, 140.0);

        return SizedBox(
          height: itemSize,
          child: Row(
            children: List.generate(widget.totalSlots, (index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: index == widget.totalSlots - 1 ? 0 : spacing,
                ),
                child: SizedBox(
                  width: itemSize,
                  height: itemSize,
                  child: ImageSlot(
                    imageFile: _images[index],
                    title: 'Photo ${index + 1}',
                    onTap: () => _onSlotTapped(index),
                    onDelete: () => _onDeleteTapped(index),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Future<void> _onSlotTapped(int tappedIndex) async {
    final int nextEmptyIndex = _images.indexWhere((file) => file == null);

    if (nextEmptyIndex == -1) {
      await _pickAndAssignAt(tappedIndex);
      return;
    }

    await _pickAndAssignAt(nextEmptyIndex);
  }

  Future<void> _pickAndAssignAt(int index) async {
    final selectedImages = await AppFilePicker.openImagePickerSheet(
      context: context,
    );

    final pickedFile = selectedImages?.firstOrNull;
    if (!mounted || pickedFile == null) {
      return;
    }

    setState(() {
      _images[index] = pickedFile;
    });
    widget.onChanged?.call(List<File?>.from(_images));
  }

  void _onDeleteTapped(int index) {
    if (_images[index] == null) {
      return;
    }

    setState(() {
      for (var i = index; i < _images.length - 1; i++) {
        _images[i] = _images[i + 1];
      }
      _images[_images.length - 1] = null;
    });
    widget.onChanged?.call(List<File?>.from(_images));
  }
}
