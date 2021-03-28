import 'package:equatable/equatable.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:beep/core/extension/date_time_extensions.dart';
class InventoryFile extends Equatable {
  final String name, driveId, createdAt;

  InventoryFile({this.name, this.driveId, this.createdAt});

  factory InventoryFile.fromDriveFile(ga.File file) {
    return InventoryFile(
      name: file.name,
      createdAt: file.createdTime.formatDateTimeToBrazilianDateTime(),
      driveId: file.driveId
    );
  }

  @override
  List<Object> get props => [this.name, this.driveId, this.createdAt];
}
