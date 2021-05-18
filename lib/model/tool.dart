
class Tool {

  String _toolName = "";
  String _topicName = ""; 
  String type; 
  bool value =false;
  String text = "";
  get toolName => _toolName;

  get topicName => _topicName;

  set toolName(String value) => _toolName = value;

  set topicName(String value) => _topicName = value;

  Tool.empty() {
    this.toolName = "";
    this.topicName = "";
  }
}
