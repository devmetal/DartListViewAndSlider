import 'dart:html';
import 'poetlib.dart';

void main() {
  HtmlElement e = querySelector("#poet-container");
  var controller = new PoetController(e);
  controller.updatePoetList(20).then((_){
    var cpanel = querySelector("#cpanel");
    cpanel.style.display = "block";
    cpanel.querySelector("#shuffle").onClick.listen((_) => controller.shufflePoetList(20));
  });
}