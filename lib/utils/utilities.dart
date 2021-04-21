class Utils{
  
  static String getUserName(String email){
    return "live:${email.split('@')[0]}";
  }

  static String getInitials(String name){
    List<String> nameIni = name.split(" ");
    return nameIni[0][0] + nameIni[1][0];
  }

}