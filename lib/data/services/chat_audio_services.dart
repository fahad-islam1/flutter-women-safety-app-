import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety_app/res/utils/utils.dart';

class ChatAudioService{
   Future<void> requestAudioPermission() async {
  var status = await Permission.microphone.status;
  if (status.isDenied) {
    status = await Permission.microphone.request();
  }
}

  handleInvalidPermissions(PermissionStatus permission) {
    if (permission == PermissionStatus.denied) {
      showAlertDialog("Permission Denied", "You have denied the permissions");
    } else if (permission == PermissionStatus.permanentlyDenied) {
      showAlertDialog("Permission Denied", "You have denied the permissions");
    }
  }
}