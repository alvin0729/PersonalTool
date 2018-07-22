
<p>Click this document to activate the handler.</p>
<script>
  addEventListener("click", function() {
    console.log("You clicked!");
  });
</script>



<button>Click me</button>
<p>No handler here.</p>
<script>
  var button = document.querySelector("button");
  button.addEventListener("click", function() {
    console.log("Button clicked.");
  });
</script>


<button>Act-once button</button>
<script>
  var button = document.querySelector("button");
  function once() {
    console.log("Done.");
    button.removeEventListener("click", once);
  }
  button.addEventListener("click", once);
</script>




<button>Click me any way you want</button>
<script>
  var button = document.querySelector("button");
  button.addEventListener("mousedown", function(event) {
    if (event.which == 1)
      console.log("Left button");
    else if (event.which == 2)
      console.log("Middle button");
    else if (event.which == 3)
      console.log("Right button");
  });
</script>



<p>A paragraph with a <button>button</button>.</p>
<script>
  var para = document.querySelector("p");
  var button = document.querySelector("button");
  para.addEventListener("mousedown", function() {
    console.log("Handler for paragraph.");
  });
  button.addEventListener("mousedown", function(event) {
    console.log("Handler for button.");
    if (event.which == 3)
      event.stopPropagation();
  });
</script>


<button>A</button>
<button>B</button>
<button>C</button>
<script>
  document.body.addEventListener("click", function(event) {
    if (event.target.nodeName == "BUTTON")
      console.log("Clicked", event.target.textContent);
  });
</script>



<a href="https://developer.mozilla.org/">MDN</a>
<script>
  var link = document.querySelector("a");
  link.addEventListener("click", function(event) {
    console.log("Nope.");
    event.preventDefault();
  });
</script>



<p>This page turns violet when you hold the V key.</p>
<script>
  addEventListener("keydown", function(event) {
    if (event.keyCode == 86)
      document.body.style.background = "violet";
  });
  addEventListener("keyup", function(event) {
    if (event.keyCode == 86)
      document.body.style.background = "";
  });
</script>



console.log("Violet".charCodeAt(0));
// → 86
console.log("1".charCodeAt(0));
// → 49




<p>Press Ctrl-Space to continue.</p>
<script>
  addEventListener("keydown", function(event) {
    if (event.keyCode == 32 && event.ctrlKey)
      console.log("Continuing!");
  });
</script>



<p>Focus this page and type something.</p>
<script>
  addEventListener("keypress", function(event) {
    console.log(String.fromCharCode(event.charCode));
  });
</script>



<style>
  body {
    height: 200px;
    background: beige;
  }
  .dot {
    height: 8px; width: 8px;
    border-radius: 4px; /* rounds corners */
    background: blue;
    position: absolute;
  }
</style>
<script>
  addEventListener("click", function(event) {
    var dot = document.createElement("div");
    dot.className = "dot";
    dot.style.left = (event.pageX - 4) + "px";
    dot.style.top = (event.pageY - 4) + "px";
    document.body.appendChild(dot);
  });
</script>




<p>Drag the bar to change its width:</p>
<div style="background: orange; width: 60px; height: 20px">
</div>
<script>
  var lastX; // Tracks the last observed mouse X position
  var rect = document.querySelector("div");
  rect.addEventListener("mousedown", function(event) {
    if (event.which == 1) {
      lastX = event.pageX;
      addEventListener("mousemove", moved);
      event.preventDefault(); // Prevent selection
    }
  });

  function buttonPressed(event) {
    if (event.buttons == null)
      return event.which != 0;
    else
      return event.buttons != 0;
  }
  function moved(event) {
    if (!buttonPressed(event)) {
      removeEventListener("mousemove", moved);
    } else {
      var dist = event.pageX - lastX;
      var newWidth = Math.max(10, rect.offsetWidth + dist);
      rect.style.width = newWidth + "px";
      lastX = event.pageX;
    }
  }
</script>



<p>Hover over this <strong>paragraph</strong>.</p>
<script>
  var para = document.querySelector("p");
  function isInside(node, target) {
    for (; node != null; node = node.parentNode)
      if (node == target) return true;
  }
  para.addEventListener("mouseover", function(event) {
    if (!isInside(event.relatedTarget, para))
      para.style.color = "red";
  });
  para.addEventListener("mouseout", function(event) {
    if (!isInside(event.relatedTarget, para))
      para.style.color = "";
  });
</script>



<style>
  p:hover { color: red }
</style>
<p>Hover over this <strong>paragraph</strong>.</p>



<style>
  .progress {
    border: 1px solid blue;
    width: 100px;
    position: fixed;
    top: 10px; right: 10px;
  }
  .progress > div {
    height: 12px;
    background: blue;
    width: 0%;
  }
  body {
    height: 2000px;
  }
</style>
<div class="progress"><div></div></div>
<p>Scroll me...</p>
<script>
  var bar = document.querySelector(".progress div");
  addEventListener("scroll", function() {
    var max = document.body.scrollHeight - innerHeight;
    var percent = (pageYOffset / max) * 100;
    bar.style.width = percent + "%";
  });
</script>



<p>Name: <input type="text" data-help="Your full name"></p>
<p>Age: <input type="text" data-help="Age in years"></p>
<p id="help"></p>

<script>
  var help = document.querySelector("#help");
  var fields = document.querySelectorAll("input");
  for (var i = 0; i < fields.length; i++) {
    fields[i].addEventListener("focus", function(event) {
      var text = event.target.getAttribute("data-help");
      help.textContent = text;
    });
    fields[i].addEventListener("blur", function(event) {
      help.textContent = "";
    });
  }
</script>




addEventListener("message", function(event) {
  postMessage(event.data * event.data);
});



var squareWorker = new Worker("code/squareworker.js");
squareWorker.addEventListener("message", function(event) {
  console.log("The worker responded:", event.data);
});
squareWorker.postMessage(10);
squareWorker.postMessage(24);


<script>
  document.body.style.background = "blue";
  setTimeout(function() {
    document.body.style.background = "yellow";
  }, 2000);
</script>



var bombTimer = setTimeout(function() {
  console.log("BOOM!");
}, 500);

if (Math.random() < 0.5) { // 50% chance
  console.log("Defused.");
  clearTimeout(bombTimer);
}



var ticks = 0;
var clock = setInterval(function() {
  console.log("tick", ticks++);
  if (ticks == 10) {
    clearInterval(clock);
    console.log("stop.");
  }
}, 200);



<textarea>Type something here...</textarea>
<script>
  var textarea = document.querySelector("textarea");
  var timeout;
  textarea.addEventListener("keydown", function() {
    clearTimeout(timeout);
    timeout = setTimeout(function() {
      console.log("You stopped typing.");
    }, 500);
  });
</script>



<script>
  function displayCoords(event) {
    document.body.textContent =
      "Mouse at " + event.pageX + ", " + event.pageY;
  }

  var scheduled = false, lastEvent;
  addEventListener("mousemove", function(event) {
    lastEvent = event;
    if (!scheduled) {
      scheduled = true;
      setTimeout(function() {
        scheduled = false;
        displayCoords(lastEvent);
      }, 250);
    }
  });
</script>




<!doctype html><input type="text"><script>  var field = document.querySelector("input");  field.addEventListener("keydown", function(event) {    if (event.keyCode == "Q".charCodeAt(0) ||        event.keyCode == "W".charCodeAt(0) ||        event.keyCode == "X".charCodeAt(0))      event.preventDefault();  });</script>



<!doctype html><style>  .trail { /* className for the trail elements */    position: absolute;    height: 6px; width: 6px;    border-radius: 3px;    background: teal;  }  body {    height: 300px;  }</style><body><script>  var dots = [];  for (var i = 0; i < 12; i++) {    var node = document.createElement("div");    node.className = "trail";    document.body.appendChild(node);    dots.push(node);  }  var currentDot = 0;    addEventListener("mousemove", function(event) {    var dot = dots[currentDot];    dot.style.left = (event.pageX - 3) + "px";    dot.style.top = (event.pageY - 3) + "px";    currentDot = (currentDot + 1) % dots.length;  });</script></body>



<!doctype html><div id="wrapper">  <div data-tabname="one">Tab one</div>  <div data-tabname="two">Tab two</div>  <div data-tabname="three">Tab three</div></div><script>  function asTabs(node) {    var tabs = [];    for (var i = 0; i < node.childNodes.length; i++) {      var child = node.childNodes[i];      if (child.nodeType == document.ELEMENT_NODE)        tabs.push(child);    }    var tabList = document.createElement("div");    tabs.forEach(function(tab, i) {      var button = document.createElement("button");      button.textContent = tab.getAttribute("data-tabname");      button.addEventListener("click", function() { selectTab(i); });      tabList.appendChild(button);    });    node.insertBefore(tabList, node.firstChild);    function selectTab(n) {      tabs.forEach(function(tab, i) {        if (i == n)          tab.style.display = "";        else          tab.style.display = "none";      });      for (var i = 0; i < tabList.childNodes.length; i++) {        if (i == n)          tabList.childNodes[i].style.background = "violet";        else          tabList.childNodes[i].style.background = "";      }    }    selectTab(0);  }  asTabs(document.querySelector("#wrapper"));</script>











