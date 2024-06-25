class ApiPaths {
  static String user(String uid) => 'users/$uid';
  static String workers() => 'workers';
  static String categories() => 'categories';
  static String messages(String userId, String workerId) =>
      'chats/${userId}_$workerId/messages';
  static String chatRooms() => 'chats';
  static String ratingsAndReviews(String workerID) => 'workers/$workerID/customersReviews';
}
