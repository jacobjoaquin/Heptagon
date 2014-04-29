class ConsoleWrite extends MoonCodeEvent {
  String s;
  
  ConsoleWrite(String s_) {
    s = s_;
  }
  
  void exec() {
    println(s);
  } 
}
