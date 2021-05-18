class ToolValidateonMixin{
  String validateToolName(String value){
    if(value.length>10) return "İsim 10 karakterden uzun olmamalıdır.";
  }
  String validateTopicName(String value){
   
  }
}