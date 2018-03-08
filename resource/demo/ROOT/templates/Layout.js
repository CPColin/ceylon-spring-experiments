/*
 * Utility script that performs the Layout fragment substitution in static mode, to keep template natural.
 * 
 * Works by default in Firefox, but Chrome needs the --allow-file-access-from-files command-line argument.
 */

var html = document.getElementsByTagName("html")[0];
var body = document.getElementsByTagName("body")[0].cloneNode(true);
var styles = document.getElementsByTagName("style");
var style = styles.length ? styles[0].cloneNode(true) : null;
var title = document.title;
var request = new XMLHttpRequest();

request.open("GET", "fragments/Layout.html", false);
request.send();

html.innerHTML = request.responseText;

var content = document.getElementById("content");

while (body.childNodes.length > 0)
{
   content.appendChild(body.childNodes[0]);
}

if (style)
{
   var head = html.getElementsByTagName("head")[0];
   
   head.appendChild(style);
}

document.title = title;

