library slider;

import 'dart:html';
import 'dart:async';

class Slider {
  
  HtmlElement _elem;
  
  HtmlElement _container;
  
  StreamSubscription _moveSub;
  StreamSubscription _touchSub;
  
  Slider(this._container,this._elem) {
    _elem.onMouseDown.listen(_moveStart);
    _container.onMouseUp.listen((_) => _moveEnd());
    _container.onMouseOut.listen((_) => _moveEnd());
    
    _container.onTouchStart.listen(_moveStart);
    _container.onTouchEnd.listen((_) => _moveEnd());
    
    _elem.onTransitionEnd.listen(
        (_) => _elem.classes.remove('roller-move-animated')
    );
  }
  
  num _getMarginLeft() {
    String marginLeft = this._elem.style.marginLeft;
    if (marginLeft.isEmpty) return 0;
    
    int index = marginLeft.indexOf('px');
    return double.parse(marginLeft.substring(0, index));
  }
  
  void _setMarginLeft(num left) {
    this._elem.style.marginLeft = "${left}px";
  }
  
  void _moveStart(e) {
    if (_moveSub == null && _touchSub == null) {
      _elem.classes.remove("roller-move-animated");
      
      Point start = e.client;
      num marginLeft = _getMarginLeft();
      _moveSub = _elem.onMouseMove.listen(
          (e) => _move(e, start, marginLeft)
      );
      _touchSub = _elem.onTouchMove.listen(
          (e) => _move(e,start,marginLeft)
      );
    }
  }
  
  void _move(MouseEvent e, Point startFrom, num marginLeft) {
    Point current = e.client;
    num dist = current.x - startFrom.x;
    _setMarginLeft(marginLeft + dist * 0.8);
  }
  
  void _moveEnd() {
    if (_moveSub == null && _touchSub == null)
      return;
    
    if (_moveSub != null) {
      _moveSub.cancel();
      _moveSub = null;
    }
    
    if (_touchSub != null) {
      _touchSub.cancel();
      _touchSub = null;
    }
    
    num left = _getMarginLeft();
    if (left > 0) {
      this._elem.classes.add('roller-move-animated');
      _setMarginLeft(0); 
    } else {
      var trWidth = this._elem.clientWidth;
      var trLeftAbs = left * -1;
      var cntWidth = this._container.clientWidth;
      
      if (trLeftAbs + cntWidth > trWidth) {
        var margin = (cntWidth - trWidth);
        this._elem.classes.add('roller-move-animated');
        if (margin > 0) {
          _setMarginLeft(0);
        } else {
          _setMarginLeft(margin);
        }
      }
    }
  }
  
}