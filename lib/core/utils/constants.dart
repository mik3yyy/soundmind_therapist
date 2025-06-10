class Constants {
  static List<String> genders = ["Male", "Female", "Others"];
  static int convertGender(String gender) {
    switch (gender) {
      case 'Male':
        return 1;
      case 'Female':
        return 2;
      case 'Others':
        return 3;
      default:
        return 1;
    }
  }

  static String Naira = '₦';
  static Function delayed = () {
    Future.delayed(Duration(seconds: 3), () {});
  };
}
