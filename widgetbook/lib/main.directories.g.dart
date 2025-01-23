// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _i1;
import 'package:widgetbook_workspace/action/button.dart' as _i4;
import 'package:widgetbook_workspace/action/button_icon_only.dart' as _i3;
import 'package:widgetbook_workspace/action/button_with_icon.dart' as _i2;
import 'package:widgetbook_workspace/action/outlined_button.dart' as _i7;
import 'package:widgetbook_workspace/action/outlined_icon_button.dart' as _i6;
import 'package:widgetbook_workspace/action/small/button_small.dart' as _i5;
import 'package:widgetbook_workspace/navigation/custom_navbar.dart' as _i8;
import 'package:widgetbook_workspace/navigation/top_bar.dart' as _i9;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'commons',
    children: [
      _i1.WidgetbookFolder(
        name: 'action',
        children: [
          _i1.WidgetbookFolder(
            name: 'buttonWithIcon',
            children: [
              _i1.WidgetbookComponent(
                name: 'ButtonWithIcon',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Disabled with Icon',
                    builder: _i2.disabledButtonWithIcon,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Primary with Icon Left',
                    builder: _i2.primaryButtonWithIconLeft,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Primary with Icon Right',
                    builder: _i2.primaryButtonWithIconRight,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Secondary with Icon',
                    builder: _i2.secondaryButtonWithIcon,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Tertiary with Icon',
                    builder: _i2.tertiaryButtonWithIcon,
                  ),
                ],
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'onlyIconButton',
            children: [
              _i1.WidgetbookComponent(
                name: 'IconButtonCustom',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Primary Icon Button',
                    builder: _i3.primaryButtonWithIcon,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Secondary Icon Button',
                    builder: _i3.secondaryButtonWithIcon,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Tertiary Icon Button',
                    builder: _i3.tertiaryButtonWithIcon,
                  ),
                ],
              )
            ],
          ),
          _i1.WidgetbookFolder(
            name: 'withoutIcon',
            children: [
              _i1.WidgetbookComponent(
                name: 'ButtonWithoutIcon',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Disabled',
                    builder: _i4.disabledButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Disabled Small',
                    builder: _i5.disabledSmallButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Primary',
                    builder: _i4.primaryButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Primary Small',
                    builder: _i5.primarySmallButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Secondary',
                    builder: _i4.secondaryButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Secondary Small',
                    builder: _i5.secondarySmallButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Tertiary',
                    builder: _i4.tertiaryButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Tertiary Small',
                    builder: _i5.tertiarySmallButton,
                  ),
                ],
              ),
              _i1.WidgetbookComponent(
                name: 'OutlineButton',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'Disabled Medium',
                    builder: _i6.disabledMediumOutlineButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Disabled Small',
                    builder: _i6.disabledSmallOutlineButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Outlined',
                    builder: _i7.outlinePrimaryButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Outlined Secondary',
                    builder: _i7.outlineSecondaryButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Outlined Tertiary',
                    builder: _i7.outlineTertiaryButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'OutlinedPressed',
                    builder: _i7.outlinePressedPrimaryButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Primary Medium',
                    builder: _i6.primaryMediumOutlineButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Primary Small',
                    builder: _i6.primarySmallOutlineButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Secondary Medium',
                    builder: _i6.secondaryMediumOutlineButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Secondary Small',
                    builder: _i6.secondarySmallOutlineButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Tertiary Medium',
                    builder: _i6.tertiaryMediumOutlineButton,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'Tertiary Small',
                    builder: _i6.tertiarySmallOutlineButton,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'navigation',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'CustomNavbar',
            useCase: _i1.WidgetbookUseCase(
              name: 'Primary',
              builder: _i8.customNavbar,
            ),
          ),
          _i1.WidgetbookFolder(
            name: 'topbar',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'CustomTopBar',
                useCase: _i1.WidgetbookUseCase(
                  name: 'Top Bar',
                  builder: _i9.customNavbar,
                ),
              ),
              _i1.WidgetbookLeafComponent(
                name: 'TopBarCustomizable',
                useCase: _i1.WidgetbookUseCase(
                  name: 'Top Bar with Right Icon Only',
                  builder: _i9.topBarWithRightIconOnly,
                ),
              ),
              _i1.WidgetbookLeafComponent(
                name: 'TopBarWithBlueIcon',
                useCase: _i1.WidgetbookUseCase(
                  name: 'Top Bar With Blue Icon',
                  builder: _i9.topBarWithBlueIconUseCase,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  )
];
