import 'package:beep/core/constants/assets.dart';
import 'package:beep/core/constants/colors.dart';
import 'package:beep/core/constants/texts.dart';
import 'package:beep/features/inventorydetails/presentation/widgets/action_button.dart';
import 'package:beep/features/inventorydetails/presentation/widgets/animated_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExpandableFab extends StatefulWidget {
  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin {
  bool _open = false;
  double optionsVerticalPosition = 0.0;

  @override
  void initState() {
    super.initState();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        optionsVerticalPosition = 70.0;
      } else {
        optionsVerticalPosition = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        _buildTapToCloseFab(),
        AnimatedActionButton(
          child: ActionButton(
            onPressed: () => null,
            icon: inventoryDetailsProductsFabIcon,
            text: importProducts,
            isVisible: _open,
          ),
          progress: optionsVerticalPosition,
          position: 3,
        ),
        AnimatedActionButton(
          child: ActionButton(
            onPressed: () => null,
            icon: inventoryDetailsAddressesFabIcon,
            text: manageAddresses,
            isVisible: _open,
          ),
          progress: optionsVerticalPosition,
          position: 2,
        ),
        AnimatedActionButton(
          child: ActionButton(
            onPressed: () => null,
            icon: inventoryDetailsEmployeeFabIcon,
            text: manageEmployees,
            isVisible: _open,
          ),
          progress: optionsVerticalPosition,
          position: 1,
        ),
        _buildTapToOpenFab(),
      ],
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: finishedInventoryBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.3 : 1.0,
          _open ? 0.3 : 1.0,
          1.0,
        ),
        duration: Duration(milliseconds: 250),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          duration: Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: primaryColor,
            child: SvgPicture.asset(inventoryDetailsFabIcon),
          ),
        ),
      ),
    );
  }
}
