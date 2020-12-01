package cac;

import js.Browser.document;
import js.Browser.window;

@:expose("cac")
class Lib {
    static private var data:Dynamic;

    static function main() {
        initialize(document.getElementById("root"));
    }

    static private function getCurrentDay():Int {
        var currentDay = -666;
        var today = Date.now();

        if(today.getMonth() == 11) {
            currentDay = today.getDate() - 1;
        }

        if(untyped window.hack != null) {
            return untyped window.hack - 1;
        }

        return currentDay;
    }

    static public function initialize(root:js.html.Element) {
        var currentDay = getCurrentDay();

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
                    if(i <= getCurrentDay()) {
                        openDay(i);
                        gift.className = "gift opened-gift";
                        e.stopPropagation();
                    }
                });
                e.appendChild(gift);
            }
            root.appendChild(e);
        }

        loadData();
        document.addEventListener("click", closeMessage);
    }

    static private function getParameter(name:String):String {
        if(untyped window[name] != null) {
            return untyped window[name];
        }
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
        Lib.data = data;

        if(data.music != null) {
            var audio = new js.html.Audio(data.music);
            audio.loop = true;
            document.addEventListener("click", () -> {
                audio.play();
            });
        }
    }

    static private function openDay(index:Int) {
        var message = document.getElementById("message");
        var span = document.querySelector(".message span");
        span.innerText = "" + (index+1);
        var p = document.querySelector(".message p");
        p.innerHTML = data.days[index];
        message.style.display = "flex";
        haxe.Timer.delay(function() {
            message.className = "message appear";
        }, 0);
    }

    static private function closeMessage(e) {
        var message = document.getElementById("message");
        message.style.display = "none";
        message.className = "message";
    }
}
