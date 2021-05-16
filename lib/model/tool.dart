
class Tool {

  String _toolName = "";
  String _topicName = ""; 
  String type; 
  bool value =false;
  String text = "Patates Plavi guzel mi olur Patates Plavi guzel mi olur";
  get toolName => _toolName;

  get topicName => _topicName;

  set toolName(String value) => _toolName = value;

  set topicName(String value) => _topicName = value;

  Tool.empty() {
    this.toolName = "";
    this.topicName = "";
  }
}
