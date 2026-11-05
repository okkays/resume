import 'package:flutter/material.dart';

class BrightnessToggle extends StatefulWidget {
  final ValueChanged<Brightness> onChanged;
  final Brightness initialBrightness;

  const BrightnessToggle({
    super.key,
    required this.initialBrightness,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _BrightnessToggleState();
}

class _BrightnessToggleState extends State<BrightnessToggle> {
  late Brightness brightness;

  @override
  void initState() {
    brightness = widget.initialBrightness;
    super.initState();
  }

  IconData getIcon() {
    switch (brightness) {
      case .dark:
        return Icons.dark_mode;
      case .light:
        return Icons.light_mode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        if (brightness == .light) {
          setState(() {
            brightness = .dark;
          });
        } else {
          setState(() {
            brightness = .light;
          });
        }
        widget.onChanged(brightness);
      },
      icon: Icon(getIcon()),
    );
  }
}
