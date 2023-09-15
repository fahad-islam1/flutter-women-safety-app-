import 'package:women_safety_app/res/const/firebase_const.dart';
import 'package:women_safety_app/res/utils/utils.dart';

class ChatMessageService {
  final currentUserUid = auth.currentUser!.uid;

  Future<void> sendMessage(
      {String? friendId, String? message, String? type}) async {
    try {
      final currentTime = DateTime.now();
      final messageData = {
        'senderid': currentUserUid,
        'friendid': friendId,
        'time': currentTime,
        'message': message,
        'type': type,
      };

      // Sender's message
      // final messageDocRef =
      await firestore
          .collection(chatcollection)
          .doc(currentUserUid)
          .collection(allmsgcollection)
          .doc(friendId)
          .collection(msgcollection)
          .add(messageData);
      // await messageDocRef.update({'messageId': messageDocRef.id});
    } catch (e) {
      // Handle and log errors

      showError("Error sending message: $e");
    }
  }

  // delete msg

  Future<void> deleteMessage({
    String? docId,
    String? friendId,
  }) async {
    try {
      final currentUserUid = auth.currentUser!.uid;

      // Get the message document
      final messageDoc = await firestore
          .collection(chatcollection)
          .doc(currentUserUid)
          .collection(allmsgcollection)
          .doc(friendId)
          .collection(msgcollection)
          .doc(docId)
          .get();

      // Check if the message exists and if it was sent by the current user
      if (messageDoc.exists && messageDoc['senderid'] == currentUserUid) {
        // Delete the message document using its unique ID
        await firestore
            .collection(chatcollection)
            .doc(currentUserUid)
            .collection(allmsgcollection)
            .doc(friendId)
            .collection(msgcollection)
            .doc(docId)
            .delete()
            .then((value) {
          showSuccess('Message Deleted Successfully', '');
        });
      } else {
        showError('You can only delete your own messages.');
      }
    } catch (e) {
      // Handle and log errors
      showError("Error deleting message: $e");
    }
  }
}
