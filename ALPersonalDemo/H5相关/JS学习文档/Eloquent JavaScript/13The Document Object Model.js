
<!doctype html>
<html>
  <head>
    <title>My home page</title>
  </head>
  <body>
    <h1>My home page</h1>
    <p>Hello, I am Marijn and this is my home page.</p>
    <p>I also wrote a book! Read it
      <a href="http://eloquentjavascript.net">here</a>.</p>
  </body>
</html>



function talksAbout(node, string) {
  if (node.nodeType == document.ELEMENT_NODE) {
    for (var i = 0; i < node.childNodes.length; i++) {
      if (talksAbout(node.childNodes[i], string))
        return true;
    }
    return false;
  } else if (node.nodeType == document.TEXT_NODE) {
    return node.nodeValue.indexOf(string) > -1;
  }
}

console.log(talksAbout(document.body, "book"));
// → true


var link = document.body.getElementsByTagName("a")[0];
console.log(link.href);



<p>My ostrich Gertrude:</p>
<p><img id="gertrude" src="img/ostrich.png"></p>

<script>
  var ostrich = document.getElementById("gertrude");
  console.log(ostrich.src);
</script>



<p>One</p>
<p>Two</p>
<p>Three</p>

<script>
  var paragraphs = document.body.getElementsByTagName("p");
  document.body.insertBefore(paragraphs[2], paragraphs[0]);
</script>



<p>The <img src="img/cat.png" alt="Cat"> in the
  <img src="img/hat.png" alt="Hat">.</p>

<p><button onclick="replaceImages()">Replace</button></p>

<script>
  function replaceImages() {
    var images = document.body.getElementsByTagName("img");
    for (var i = images.length - 1; i >= 0; i--) {
      var image = images[i];
      if (image.alt) {
        var text = document.createTextNode(image.alt);
        image.parentNode.replaceChild(text, image);
      }
    }
  }
</script>



var arrayish = {0: "one", 1: "two", length: 2};
var real = Array.prototype.slice.call(arrayish, 0);
real.forEach(function(elt) { console.log(elt); });
// → one
//   two



<blockquote id="quote">
  No book can ever be finished. While working on it we learn
  just enough to find it immature the moment we turn away
  from it.
</blockquote>

<script>
  function elt(type) {
    var node = document.createElement(type);
    for (var i = 1; i < arguments.length; i++) {
      var child = arguments[i];
      if (typeof child == "string")
        child = document.createTextNode(child);
      node.appendChild(child);
    }
    return node;
  }

  document.getElementById("quote").appendChild(
    elt("footer", "—",
        elt("strong", "Karl Popper"),
        ", preface to the second editon of ",
        elt("em", "The Open Society and Its Enemies"),
        ", 1950"));
</script>



<p data-classified="secret">The launch code is 00000000.</p>
<p data-classified="unclassified">I have two feet.</p>

<script>
  var paras = document.body.getElementsByTagName("p");
  Array.prototype.forEach.call(paras, function(para) {
    if (para.getAttribute("data-classified") == "secret")
      para.parentNode.removeChild(para);
  });
</script>



function highlightCode(node, keywords) {
  var text = node.textContent;
  node.textContent = ""; // Clear the node

  var match, pos = 0;
  while (match = keywords.exec(text)) {
    var before = text.slice(pos, match.index);
    node.appendChild(document.createTextNode(before));
    var strong = document.createElement("strong");
    strong.appendChild(document.createTextNode(match[0]));
    node.appendChild(strong);
    pos = keywords.lastIndex;
  }
  var after = text.slice(pos);
  node.appendChild(document.createTextNode(after));
}



var languages = {
  javascript: /\b(function|return|var)\b/g /* … etc */
};

function highlightAllCode() {
  var pres = document.body.getElementsByTagName("pre");
  for (var i = 0; i < pres.length; i++) {
    var pre = pres[i];
    var lang = pre.getAttribute("data-language");
    if (languages.hasOwnProperty(lang))
      highlightCode(pre, languages[lang]);
  }
}



<p>Here it is, the identity function:</p>
<pre data-language="javascript">
function id(x) { return x; }
</pre>

<script>highlightAllCode();</script>



<p style="border: 3px solid red">
  I'm boxed in
</p>

<script>
  var para = document.body.getElementsByTagName("p")[0];
  console.log("clientHeight:", para.clientHeight);
  console.log("offsetHeight:", para.offsetHeight);
</script>



<p><span id="one"></span></p>
<p><span id="two"></span></p>

<script>
  function time(name, action) {
    var start = Date.now(); // Current time in milliseconds
    action();
    console.log(name, "took", Date.now() - start, "ms");
  }

  time("naive", function() {
    var target = document.getElementById("one");
    while (target.offsetWidth < 2000)
      target.appendChild(document.createTextNode("X"));
  });
  // → naive took 32 ms

  time("clever", function() {
    var target = document.getElementById("two");
    target.appendChild(document.createTextNode("XXXXX"));
    var total = Math.ceil(2000 / (target.offsetWidth / 5));
    for (var i = 5; i < total; i++)
      target.appendChild(document.createTextNode("X"));
  });
  // → clever took 1 ms
</script>



<p><a href=".">Normal link</a></p>
<p><a href="." style="color: green">Green link</a></p>



This text is displayed <strong>inline</strong>,
<strong style="display: block">as a block</strong>, and
<strong style="display: none">not at all</strong>.



<p id="para" style="color: purple">
  Pretty text
</p>

<script>
  var para = document.getElementById("para");
  console.log(para.style.color);
  para.style.color = "magenta";
</script>



<style>
  strong {
    font-style: italic;
    color: gray;
  }
</style>
<p>Now <strong>strong text</strong> is italic and gray.</p>



<p>And if you go chasing
  <span class="animal">rabbits</span></p>
<p>And you know you're going to fall</p>
<p>Tell 'em a <span class="character">hookah smoking
  <span class="animal">caterpillar</span></span></p>
<p>Has given you the call</p>

<script>
  function count(selector) {
    return document.querySelectorAll(selector).length;
  }
  console.log(count("p"));           // All <p> elements
  // → 4
  console.log(count(".animal"));     // Class animal
  // → 2
  console.log(count("p .animal"));   // Animal inside of <p>
  // → 2
  console.log(count("p > .animal")); // Direct child of <p>
  // → 1
</script>




<p style="text-align: center">
  <img src="img/cat.png" style="position: relative">
</p>
<script>
  var cat = document.querySelector("img");
  var angle = 0, lastTime = null;
  function animate(time) {
    if (lastTime != null)
      angle += (time - lastTime) * 0.001;
    lastTime = time;
    cat.style.top = (Math.sin(angle) * 20) + "px";
    cat.style.left = (Math.cos(angle) * 200) + "px";
    requestAnimationFrame(animate);
  }
  requestAnimationFrame(animate);
</script>




<!doctype html><script src="code/mountains.js"></script><script src="code/chapter/13_dom.js"></script><style>  /* Defines a cleaner look for tables */  table  { border-collapse: collapse; }  td, th { border: 1px solid black; padding: 3px 8px; }  th     { text-align: left; }</style><body><script>  function buildTable(data) {    var table = document.createElement("table");      var fields = Object.keys(data[0]);    var headRow = document.createElement("tr");    fields.forEach(function(field) {      var headCell = document.createElement("th");      headCell.textContent = field;      headRow.appendChild(headCell);    });    table.appendChild(headRow);    data.forEach(function(object) {      var row = document.createElement("tr");      fields.forEach(function(field) {        var cell = document.createElement("td");        cell.textContent = object[field];        if (typeof object[field] == "number")          cell.style.textAlign = "right";        row.appendChild(cell);      });      table.appendChild(row);    });    return table;  }  document.body.appendChild(buildTable(MOUNTAINS));</script></body>




<!doctype html><script src="code/mountains.js"></script><script src="code/chapter/13_dom.js"></script><h1>Heading with a <span>span</span> element.</h1><p>A paragraph with <span>one</span>, <span>two</span>  spans.</p><script>  function byTagName(node, tagName) {    var found = [];    tagName = tagName.toUpperCase();    function explore(node) {      for (var i = 0; i < node.childNodes.length; i++) {        var child = node.childNodes[i];        if (child.nodeType == document.ELEMENT_NODE) {          if (child.nodeName == tagName)            found.push(child);          explore(child);        }      }    }    explore(node);    return found;  }  console.log(byTagName(document.body, "h1").length);  // → 1  console.log(byTagName(document.body, "span").length);  // → 3  var para = document.querySelector("p");  console.log(byTagName(para, "span").length);  // → 2</script>



<!doctype html><script src="code/mountains.js"></script><script src="code/chapter/13_dom.js"></script><body style="min-height: 200px"><img src="img/cat.png" id="cat" style="position: absolute"><img src="img/hat.png" id="hat" style="position: absolute"><script>  var cat = document.querySelector("#cat");  var hat = document.querySelector("#hat");  var angle = 0, lastTime = null;  function animate(time) {    if (lastTime != null)      angle += (time - lastTime) * 0.0015;    lastTime = time;    cat.style.top = (Math.sin(angle) * 50 + 80) + "px";    cat.style.left = (Math.cos(angle) * 200 + 230) + "px";    // By adding π to the angle, the hat ends up half a circle ahead of the cat    var hatAngle = angle + Math.PI;    hat.style.top = (Math.sin(hatAngle) * 50 + 80) + "px";    hat.style.left = (Math.cos(hatAngle) * 200 + 230) + "px";    requestAnimationFrame(animate);  }  requestAnimationFrame(animate);</script></body>













