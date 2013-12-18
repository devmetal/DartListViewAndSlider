part of poetlib;


class PoetView {
  
  HtmlElement _e;
  
  HtmlElement _title;
  
  HtmlElement _content;
  
  HtmlElement _translates;
  
  PoetController _pc;
  
  bool _contentOpen = false;
  
  String _template = """
<div class='title'></div>
<div class='content animated'>
  <div class='translates'></div>
</div>
""";
  
  Poet _p;
  
  HtmlElement getElement() => this._e;
  Poet getPoet() => this._p;
  
  PoetView(Poet p, PoetController pc) {
    this._p = p;
    this._pc = pc;
    
    this._e = new DivElement();
    this._e.className = "poet";
    this._e.innerHtml = this._template;
    
    this._title = this._e.querySelector('.title');
    this._content = this._e.querySelector('.content');
    this._translates = this._e.querySelector('.translates');
    
    this._e.classes.add('unselectable');
    this._e.onSelectStart.listen((e){
      e.preventDefault();
    });
    this._e.setAttribute('unselectable', 'on');
    
    _render();
    _events();
  }
  
  _render() {
    var title = this._p.title;
    var translates = this._p.translates;
    
    this._title
      ..innerHtml = title;
    
    num cntWidth = 0;
    var translatesCnt = this._translates;
    translates.forEach((e){
      var translateDiv = new DivElement();
      translateDiv
        ..className = 'translate'
        ..innerHtml = "<div class='translator'>${e['translator']}</div>${e['translate']}";      
      
      translatesCnt.append(translateDiv);
      
      cntWidth += 330;
    });
    
    this._translates.style
      ..width = "${cntWidth}px"
      ..marginLeft = "0px";
  }
  
  num _getTranslatesLeftMagrin() {
    String marginLeft = this._translates.style.marginLeft;
    int index = marginLeft.indexOf('px');
    return double.parse(marginLeft.substring(0, index));
  }
  
  _events() {
    this._title.onClick.listen((e) => _toggleContent());
    var slider = new Slider(_content, _translates);
  }
  
  _toggleContent() {
    var h = "";
    if (this._contentOpen == true) {
      h = "0px";
      this._contentOpen = false;
    } else {
      h = "${this._translates.clientHeight + 60}px";
      this._contentOpen = true;
    }
    
    this._content.style.height = h;
  }
  
  
}