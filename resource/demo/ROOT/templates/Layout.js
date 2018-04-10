/*
 * Utility script that performs fragment substitutions in static mode, to keep templates natural.
 * 
 * Works by default in Firefox, but Chrome needs the --allow-file-access-from-files command-line
 * argument or it'll block the request for security reasons.
 */

function doRequest(uri) {
    var request = new XMLHttpRequest();

    request.open("GET", uri, false);
    request.send();

    return request.responseText;
}

function doLayout() {
    var html = document.getElementsByTagName("html")[0];
    var body = document.getElementsByTagName("body")[0].cloneNode(true);
    var styles = document.getElementsByTagName("style");
    var style = styles.length ? styles[0].cloneNode(true) : null;
    var title = document.title;

    html.innerHTML = doRequest("fragments/Layout.html");

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
}

function getFragmentReplacements() {
    return document.querySelectorAll("html *[data-th-replace^=fragments]");
}

function doFragments() {
    var elements = getFragmentReplacements();
    
    for (var i = 0; i < elements.length; i++) {
        var element = elements[i];
        var fragmentExpression = element.attributes["data-th-replace"].value;
        var tokens = fragmentExpression.split("::");
        var uri = tokens[0].trim();
        var fragment = tokens[1].trim();
        
        if (uri == "fragments/formControls.html") {
            doFormControls(element, uri, fragment);
        }
    }
}

function getFragmentName(fragment) {
    return fragment.split("(")[0];
}

function getFragmentArguments(fragment) {
    var argumentList = fragment.substring(fragment.indexOf("(") + 1, fragment.lastIndexOf(")"));
    var arguments = argumentList.split(",");
    
    for (var i = 0; i < arguments.length; i++) {
        var argument = arguments[i].trim();
        
        if (argument.startsWith("'") && argument.endsWith("'")) {
            argument = argument.substring(1, argument.length - 1);
        }
        
        arguments[i] = argument;
    }
    
    return arguments;
}

function doFormControls(destination, uri, fragment) {
    var fragmentName = getFragmentName(fragment);
    var fragmentArguments = getFragmentArguments(fragment);
    var html = document.createElement("html");
    
    html.innerHTML = doRequest(uri);
        
    var element = html.querySelector("[data-th-fragment^=" + fragmentName + "]");

    if (fragmentName == "text") {
        var label = element.querySelector("label");
        var input = element.querySelector("input");
        
        label.innerHTML = fragmentArguments[0] + ":";
        label.htmlFor = fragmentArguments[1];
        input.id = fragmentArguments[1];
        input.name = fragmentArguments[1];
    } else if (fragmentName == "select") {
        var label = element.querySelector("label");
        var select = element.querySelector("select");
        
        label.innerHTML = fragmentArguments[0] + ":";
        label.htmlFor = fragmentArguments[1];
        select.id = fragmentArguments[1];
        select.name = fragmentArguments[1];
    } else if (fragmentName == "submit") {
        var button = element.querySelector("button");
        
        button.innerHTML = fragmentArguments[0];
    }
    
    destination.parentNode.replaceChild(element, destination);
}

doLayout();

doFragments();

