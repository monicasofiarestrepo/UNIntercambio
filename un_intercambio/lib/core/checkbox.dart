import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.activeColor,
    this.borderColor,
    this.verticalVisualDensity = 0,
    this.scale = 1,
    this.spaceWidth = 0,
    this.shapeType = '',
  });

  final Widget label;
  final bool value;
  final Color activeColor;
  final Color? borderColor;
  final double? scale;
  final double? spaceWidth;
  final double verticalVisualDensity;
  final Function(bool?)? onChanged;
  final String? shapeType;

  @override
  Widget build(BuildContext context) {
    OutlinedBorder? shape;
    if (shapeType == 'circular') {
      shape = const CircleBorder();
    } else {
      shape = const RoundedRectangleBorder(borderRadius: BorderRadius.zero);
    }

    return Wrap(
      children: [
        Row(
          children: [
            Transform.scale(
              scale: scale ?? 1,
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: shape, // Use shape based on shapeType parameter
                side: BorderSide(
                  color:
                      borderColor ?? const Color.fromRGBO(170, 170, 170, 0.5),
                ),
                activeColor: activeColor,
                value: value,
                onChanged: onChanged,
                visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: verticalVisualDensity,
                ),
                splashRadius: 0,
              ),
            ),
            SizedBox(width: spaceWidth),
            label,
          ],
        ),
      ],
    );
  }
}
