import 'package:cloud_firestore/cloud_firestore.dart';

String timeToString(Timestamp time) {
  return "${time.toDate().day}/${time.toDate().month}/${time.toDate().year} a ${time.toDate().hour}:${time.toDate().minute}";
}
