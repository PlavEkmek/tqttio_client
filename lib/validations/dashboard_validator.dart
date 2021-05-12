class DashboardValidatoronMixin {
  String validateHostName(String value) {
    // TODO hostname resolve yaptirilabilir.
    if (value.length > 30) {
      return "Maximum 30 karakter girilebilir";
    }
    return null;
  }

  String validateDashboardName(String value) {
    if (value.length > 15) {
      return "Maximum 15 karakter girilebilir";
    }
    return null;
  }
  String validatePortNumber(String value){
    if(value.contains(RegExp(r'a-zA-Z'))) return "Port numarası harf olamaz";
    int port = int.tryParse(value);
    if(port<0 || port >25565) return "Geçersiz port numarası";
    return null;
  }
}
