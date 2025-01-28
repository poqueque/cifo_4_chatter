extension DateExtensions on DateTime {
  
  String formatHHMM() {
    String hourStr = hour.toString().padLeft(2, "0");
    String minutesStr = minute.toString().padLeft(2,"0");
    return "$hourStr:$minutesStr";
  }

}