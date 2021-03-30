import 'package:equatable/equatable.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:beep/core/extension/date_time_extensions.dart';
class InventoryFile extends Equatable {
  final String name, id, createdAt;

  InventoryFile({this.name, this.id, this.createdAt});

  factory InventoryFile.fromDriveFile(ga.File file) {
    return InventoryFile(
      name: file.name,
      createdAt: "Criado em: ${file.createdTime.formatDateTimeToBrazilianDateTime()}",
      id: file.id
    );
  }

  @override
  List<Object> get props => [this.name, this.id, this.createdAt];
}
