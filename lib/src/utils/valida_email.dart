// String? validateEmail(String? value) {
//   String pattern =
//       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
//       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
//       r"{0,253}[a-zA-Z0-9])?)*$";
//   RegExp regex = RegExp(pattern);
//   if (value == null || value.isEmpty || !regex.hasMatch(value))
//     return '';//'Enter a valid email address';  //por defauld es el mensaje
//   else
//     return null;
// }


// bool validateEmail(String? value) {
//   String pattern =
//       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
//       r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
//       r"{0,253}[a-zA-Z0-9])?)*$";
//   RegExp regex = RegExp(pattern);
//   return value != null && value.isNotEmpty && regex.hasMatch(value);
// }

bool validateEmail(String? value) {
  String pattern =
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return value != null && value.isNotEmpty && regex.hasMatch(value);
}