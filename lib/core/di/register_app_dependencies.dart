import 'package:bitsgap/app/app_shared_dependencies.dart';
import 'package:bitsgap/core/core_dependencies.dart';
import 'package:bitsgap/core/di/dependencies.dart';
import 'package:bitsgap/core/di/di.dart';
import 'package:bitsgap/data/data_dependencies.dart';
import 'package:bitsgap/device/device_dependencies.dart';
import 'package:bitsgap/presentation/presentation_dependencies.dart';

Future<void> registerAppDependencies(
  DI di,
) async {
  final dependenciesList = <Dependencies>[
    CoreDependencies(),
    DeviceDependencies(),
    AppSharedDependencies(),
    DataDependencies(),
    PresentationDependencies(),
  ];

  for (final dependencies in dependenciesList) {
    await dependencies.register(di);
  }
}
