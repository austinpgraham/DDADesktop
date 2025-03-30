class User {
  DateTime createdAt;
  String email;
  String familyName;
  String givenName;
  String id;
  String? phoneNumber;
  String? profilePicture;

  User(
    this.createdAt,
    this.email,
    this.familyName,
    this.givenName,
    this.id,
    this.phoneNumber,
    this.profilePicture,
  );
}

class AuthToken {
  String token;
  User user;

  AuthToken(this.token, this.user);
}
