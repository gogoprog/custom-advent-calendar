package cac;

import js.Browser.document;

@:expose("cac")
class Lib {
    static public function initialize(root:js.html.Element) {
        var currentDay = 5;

        for(i in 0...24) {
            var e = document.createElement("div");
            e.className = "day";
            {
                var gift = document.createElement("div");

                if(i < currentDay) {
                    gift.className = "opened-gift";
                } else {
                    gift.className = "gift";
                }

                e.appendChild(gift);
            }
            {
                var span = document.createElement("span");
                span.innerText = (i + 1) +"";
                e.appendChild(span);
            }
            root.appendChild(e);
        }
    }
}
