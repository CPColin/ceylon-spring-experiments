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
        var fragmentReplacement = element.attributes["data-th-replace"].value;
        var tokens = fragmentReplacement.split("::");
        var uri = tokens[0].trim();
        var fragmentExpression = tokens[1].trim();
        
        doFragment(element, uri, fragmentExpression);
    }
}

function doFragment(destination, uri, fragmentExpression) {
    var html = document.createElement("html");
    
    html.innerHTML = doRequest(uri);
        
    var fragmentName = getFragmentName(fragmentExpression);
    var element = html.querySelector("[data-th-fragment^=" + fragmentName + "]");
    var firstChild = element.childNodes[0];
    var secondChild = element.childNodes[1];
    var comment;
    
    if (firstChild && firstChild.nodeType == 8) {
        comment = firstChild;
    } else if (secondChild && secondChild.nodeType == 8) {
        comment = secondChild;
    }

    if (comment) {
        var parameters = getFragmentParameters(element.attributes["data-th-fragment"].value);
        var arguments = getFragmentArguments(fragmentExpression);
        var statement = "((element, " + parameters + ") => { " + comment.nodeValue + " })"
            + "(element, " + arguments + ")";

        eval(statement);
        
        element.removeChild(comment);
    }

    destination.parentNode.replaceChild(element, destination);
}

function getFragmentName(fragmentExpression) {
    return fragmentExpression.split("(")[0];
}

function getFragmentParameters(fragmentExpression) {
    return fragmentExpression.substring(
        fragmentExpression.indexOf("(") + 1, fragmentExpression.lastIndexOf(")"));
}

function getFragmentArguments(fragmentExpression) {
    var argumentList = getFragmentParameters(fragmentExpression);
    var arguments = argumentList.split(",");
    var filteredArguments = "";
    
    for (var i = 0; i < arguments.length; i++) {
        if (filteredArguments.length) {
            filteredArguments += ", ";
        }

        var argument = arguments[i].trim();
        
        if (argument.startsWith("$")) {
            filteredArguments += "null";
        } else {
            filteredArguments += argument;
        }
    }
    
    return filteredArguments;
}

doLayout();

doFragments();

