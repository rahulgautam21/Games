var title = sessionStorage.getItem("title");

var content = getStory(title);
console.log(content);
document.getElementById("span_1").innerHTML = content.title;
document.getElementById("hero_1").innerHTML = content.hero;
document.getElementById("villain_1").innerHTML = content.villain;
document.getElementById("location_1").innerHTML = content.location;
document.getElementById("save_1").value = content.title;

console.log(content.text)
document.getElementById("sprompt_1").value = content.text.split("######")[0];
document.getElementById("eprompt_1").value = content.text.split("######")[1];
getImage();



function getStory(title){
    var params = {
        "title": title
    };
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", 'http://152.7.177.129:8000/story' + formatParams(params), false); // false for synchronous request
    xmlHttp.send(null);
    return JSON.parse(xmlHttp.response);
};

function formatParams(params) {
    return "?" + Object
        .keys(params)
        .map(function (key) {
            return key + "=" + encodeURIComponent(params[key])
        })
        .join("&")
}

function getImage() {
    var params = {
        "story": content.hero + " and " + content.villain + " in " + content.location
    };

    fetch('http://152.7.177.129:8000/getImage' + formatParams(params))
        .then(response => response.json())
        .then(response => {
            var sprompt = document.getElementById('temp_div_1');
            sprompt.style.background = 'url(' + response + ') no-repeat center center';
            sprompt.style.backgroundSize = 'contain';
            console.log(response);
        });
}

function evaluateStory() {
    removeAllChildNodes(document.getElementById("lg_1"));
    var count = countSetting();
    div1 = document.getElementById("lg_1").appendChild(document.createElement("li"));
    div1.appendChild(document.createTextNode("You covered " + count + " setting(s) in your story"));
    div1.className += 'list-group-item';
    div2 = document.getElementById("lg_1").appendChild(document.createElement("li"));
    div2.appendChild(document.createTextNode("Cohesion score: " + getCohesion()));
    div2.className += 'list-group-item';
}
function getCohesion() {
    console.log("hit");
    var params = {
        "text": document.getElementById('sprompt_1').value + document.getElementById('eprompt_1').value
    };
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", 'http://152.7.177.129:8000/getCohesion' + formatParams(params), false); // false for synchronous request
    xmlHttp.send(null);
    return JSON.parse(xmlHttp.response);
}
function removeAllChildNodes(parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild);
    }
}
function countSetting() {
    var s = document.getElementById('sprompt_1').value;
    var count = 0;
    if (s.includes(content.hero)) {
        count += 1;
    }
    if (s.includes(content.villain)) {
        count += 1;
    }
    if (s.includes(content.location)) {
        count += 1;
    }
    return count;
}
function startGenerateHTML() {
    function getOptions(params) {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open("GET", 'http://152.7.177.129:8000/getChoices' + formatParams(params), false); // false for synchronous request
        xmlHttp.send(null);
        return JSON.parse(xmlHttp.response);
    }
    var firstPrompts = {
        "start_prompt": document.getElementById('sprompt_1').value,
        "end_prompt": document.getElementById('eprompt_1').value,
    }
    var options = getOptions(firstPrompts);
    removeAllChildNodes(document.getElementById("div1_1"));

    if (options.length == 0) {
        div = document.getElementById("div1_1").appendChild(document.createElement("div"));
        div.appendChild(document.createTextNode("No more suggestions available from AI. Kindly add more to the starting prompt."));
    }
    var set = new Set();

    for (obj of options) {
        if (set.has(obj) == false) {
            set.add(obj);
            div = document.getElementById("div1_1").appendChild(document.createElement("button"));
            div.appendChild(document.createTextNode(obj));
            div.className += 'btn btn-outline-primary'
            div.addEventListener('click', function (event) {
                document.getElementById("sprompt_1").value = document.getElementById('sprompt_1').value + event.srcElement.childNodes[0].data;
            });
        }
    }
}
function saveStory() {
    var params = {
        "title": document.getElementById('save_1').value,
        "text": document.getElementById('sprompt_1').value + "######" + document.getElementById('eprompt_1').value,
        "hero": content.hero,
        "villain": content.villain,
        "location": content.location
    };
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("POST", 'http://152.7.177.129:8000/story', true);
    xmlHttp.setRequestHeader("Content-Type", "application/json");
    xmlHttp.onreadystatechange = function () {//Call a function when the state changes.
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            console.log(xmlHttp.responseText);
        }
    }
    xmlHttp.send(JSON.stringify(params));
    document.location.href = "./stories.html"
}

function generateComicStrip() {
    var params = {
        "story": document.getElementById('sprompt_1').value + document.getElementById('eprompt_1').value
    };

    fetch('http://152.7.177.129:8000/comic' + formatParams(params))
        .then(function (response) {
            return response.blob();
        }).then(function (myBlob) {
            var objectURL = URL.createObjectURL(myBlob);
            const a = document.createElement('a');
            a.style.display = 'none';
            a.href = objectURL;
            a.download = "comic_strip.png";
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(objectURL);
        });
}