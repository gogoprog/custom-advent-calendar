package cac;

import js.Browser.document;
import js.Browser.window;

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
                    gift.className = "gift opened-gift";
                } else {
                    gift.className = "gift closed-gift";
                }

                {
                    var span = document.createElement("span");
                    span.innerText = (i + 1) + "";
                    gift.appendChild(span);
                }

                gift.addEventListener("click", function(e) {
                    trace(i);
                });
                e.appendChild(gift);
            }
            root.appendChild(e);
        }

        loadData();
    }

    static public function getParameter(name:String):String {
        var urlString = window.location.href;
        var url = new js.html.URL(urlString);
        return url.searchParams.get(name);
    }

    static private function loadData() {
        var data = getParameter("data");

        var http = new haxe.Http(data);
        http.onData = function(text) {
            var data = haxe.Json.parse(text);

            applyData(data);
        };

        http.request();
    }

    static private function applyData(data) {
        document.getElementById("title").innerText = data.title;
    }
}
