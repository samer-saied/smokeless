class FirebaseServerException with Exception {
  final String msg;

  FirebaseServerException(this.msg);

  @override
  String toString() {
    return msg.toString();
  }
}
