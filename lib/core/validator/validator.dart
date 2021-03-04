class Validator {
  static bool isNameValid(String name) {
    return name != null && name.isNotEmpty;
  }

  static bool isPasswordValid(String password) {
    return password != null && password.length >= 6;
  }

  static bool isEmailValid(String email) {
    return email != null &&
        RegExp("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                "(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+")
            .hasMatch(email);
  }
}
