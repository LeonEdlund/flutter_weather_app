import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getUserLocation() async {
  PermissionStatus permissionStatus = await Permission.location.request();

  if (permissionStatus.isGranted) {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  } else {
    throw Exception('Location permission is disabled...');
  }
}
