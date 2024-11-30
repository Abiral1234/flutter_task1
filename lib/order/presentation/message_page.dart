import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _sendNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'contact_channel_id',
      'Contact Notifications',
      channelDescription: 'This channel is for contact notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Message Sent',
      'Thank you for Contacting Us!',
      notificationDetails,
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      // You can send the message to your backend or use it as needed.
      _controller.clear(); // Clear the text field
      _sendNotification(); // Trigger notification
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Write your message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}
