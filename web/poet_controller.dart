part of poetlib;

class PoetController {
  
  PoetList _poetList;
  HtmlElement _base;
  
  PoetController(HtmlElement e) {
    this._base = e;  
    this._poetList = new PoetList();
  }
  
  Future updatePoetList(int max) {
    Completer c = new Completer();
    
    _poetList.fetchPoets().then((_){
      _renderPoets(max);
      c.complete();
    });
    
    return c.future;
  }
  
  void shufflePoetList(int max) {
    _renderPoets(max);
  }
  
  void _renderPoets(int max) {
    _base.children.clear();
    _poetList
      .shuffle()
        .getRange(0, max)
          .forEach((poet) => _base.append(_renderPoet(poet)));
  }
  
  
  HtmlElement _renderPoet(Poet p) => new PoetView(p, this).getElement();
  
}