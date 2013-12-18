part of poetlib;

class Poet {
  String _titleHun = "";
  int _num;
  List<Map<String, String>> _translates = new List<Map<String, String>>();
  
  Poet.fromJSON(Map json) {
    this._titleHun = json['title']['hun'];
    this._num = int.parse(json['num']);
    
    if (json.containsKey('translates')) {
      List<Map<String,String>> translates = json['translates'];
      translates.forEach((e) => _addTranslate(e));
    }
  }
  
  void _addTranslate(Map<String, String> translate) {
    translate['translate'].replaceAll(new RegExp(r'\\n'), '<br>');
    if (translate['translator'] == "undefined")
      translate['translator'] = "";
    _translates.add(translate);
  }
  
  String get title => _titleHun;
  int get num => _num;
  Iterable<Map<String,String>> get translates => _translates;
  
  String getTranslateByTranslator(String translator) {
   var translate = _translates.firstWhere((e) => e['translator'] == translator);
   return translate['translate'];
  }
  
  String toString() {
    return this._titleHun;
  }
  
  static Function getPoetNameSearcher(String name) {
    return (Poet p) => p.title == name;
  }
}
