part of poetlib;


class PoetList extends IterableBase<Poet> {
  
  List<Poet> _list = new List<Poet>();
  
  PoetList();
  
  PoetList.fromList(List<Poet> list) {
    this._list = list;
  }
  
  Future fetchPoets() {
    Completer c = new Completer();
    
    if (!this._list.isEmpty)
      c.complete();
    else {
      var url = "datas.json";
      HttpRequest.getString(url)
        .then((String content){
          List response = JSON.decode(content);
          response.forEach((e){
            this._list.add(new Poet.fromJSON(e));
          });
          c.complete();
      });
    }
    
    return c.future;
  }
  
  Poet searchPoet(String title) {
    var searcher = Poet.getPoetNameSearcher(title);
    return this._list.firstWhere((poet) => searcher(poet));
  }
  
  PoetList getRange(int min, int max) {
    if (min < 0) min = 0;
    if (max <= min || max > this._list.length) max = _list.length;
    List<Poet> l = new List<Poet>();
    l.addAll(this._list.getRange(min, max));
    return new PoetList.fromList(l);
  }
  
  PoetList shuffle() {
    var random = new Random();
    var list = this._list;
    var n = list.length;
    for (var i = 0; i<n; i++) {
      var j = random.nextInt(n);
      
      var tmp = list[i];
      list[i] = list[j];
      list[j] = tmp;
    }
    return new PoetList.fromList(list);
  }
  
  operator [](String title) => searchPoet(title);

  Iterator<Poet> get iterator => _list.iterator;
}