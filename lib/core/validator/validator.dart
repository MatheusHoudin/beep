class Validator {
  static bool isNameValid(String name) {
    return name != null && name.isNotEmpty;
  }

  static bool isPasswordValid(String password) {
    return password != null && password.length >= 6;
  }

  static bool isEmailValid(String email) {
    return email != null && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
