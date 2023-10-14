extension ValidationExtension on String {
  String validateEmail() {
    const pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,4})$';
    final regExp = RegExp(pattern);
    if (isEmpty) {
      return 'Please write your email';
    } else if (!regExp.hasMatch(this)) {
      return 'Email is invalid';
    }

    return '';
  }

  String validatePassword() {
    if (isEmpty) {
      return 'Please write your password';
    } else if (length < 8) {
      return 'Password is too short,please use a password that is at least 8 characters long.';
    }

    return '';
  }
}
