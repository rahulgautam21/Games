var setting = getSetting();
getImage();


document.getElementById("hero").innerHTML = setting.hero;
document.getElementById("villain").innerHTML = setting.villain;
document.getElementById("location").innerHTML = setting.location;


function formatParams(params) {
    return "?" + Object
        .keys(params)
        .map(function (key) {
            return key + "=" + encodeURIComponent(params[key])
        })
        .join("&")
}

function removeAllChildNodes(parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild);
    }
}

function countSetting() {
    var s = document.getElementById('sprompt').value;
    var count = 0;
    if (s.includes(setting.hero)) {
        count += 1;
    }
    if (s.includes(setting.villain)) {
        count += 1;
    }
    if (s.includes(setting.location)) {
        count += 1;
    }
    return count;
}

function getCohesion() {
    var params = {
        "text": document.getElementById('sprompt').value + document.getElementById('eprompt').value
    };
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", 'http://152.7.177.129:8000/getCohesion' + formatParams(params), false); // false for synchronous request
    xmlHttp.send(null);
    return JSON.parse(xmlHttp.response);
}


function evaluateStory() {
    removeAllChildNodes(document.getElementById("lg"));
    var count = countSetting();
    div1 = document.getElementById("lg").appendChild(document.createElement("li"));
    div1.appendChild(document.createTextNode("You covered " + count + " setting(s) in your story"));
    div1.className += 'list-group-item';
    div2 = document.getElementById("lg").appendChild(document.createElement("li"));
    div2.appendChild(document.createTextNode("Cohesion score: " + getCohesion()));
    div2.className += 'list-group-item';
}

function startGenerateHTML() {
    function getOptions(params) {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open("GET", 'http://152.7.177.129:8000/getChoices' + formatParams(params), false); // false for synchronous request
        xmlHttp.send(null);
        return JSON.parse(xmlHttp.response);
    }
    var firstPrompts = {
        "start_prompt": document.getElementById('sprompt').value,
        "end_prompt": document.getElementById('eprompt').value,
    }
    var options = getOptions(firstPrompts);

    console.log(typeof options, options);

    removeAllChildNodes(document.getElementById("div1"));

    if (options.length == 0) {
        div = document.getElementById("div1").appendChild(document.createElement("div"));
        div.appendChild(document.createTextNode("No more suggestions available from AI. Kindly add more to the starting prompt."));
    }
    var set = new Set();

    for (obj of options) {
        if (set.has(obj) == false) {
            set.add(obj);
            div = document.getElementById("div1").appendChild(document.createElement("button"));
            div.appendChild(document.createTextNode(obj));
            div.className += 'btn btn-outline-primary'
            console.log(div)
            div.addEventListener('click', function (event) {
                document.getElementById("sprompt").value = document.getElementById('sprompt').value + event.srcElement.childNodes[0].data;
            });
            console.log(div);
        }
    }
}

function getSetting() {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", 'http://152.7.177.129:8000/getSetting', false); // false for synchronous request
    xmlHttp.send(null);
    return JSON.parse(xmlHttp.response);
}

function getImage() {
    var params = {
        "story": setting.hero + " and " + setting.villain + " in " + setting.location
    };

    fetch('http://152.7.177.129:8000/getImage' + formatParams(params))
        .then(response => response.json())
        .then(response => {
            console.log(response);
            var sprompt = document.getElementById('temp_div');
            sprompt.style.background = 'url(' + response + ') no-repeat center center';
            sprompt.style.backgroundSize = 'contain';
            console.log(response);
        });
}

function saveStory() {
    var params = {
        "title": document.getElementById('save').value,
        "text": document.getElementById('sprompt').value + "######" + document.getElementById('eprompt').value,
        "hero": setting.hero,
        "villain": setting.villain,
        "location": setting.location
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
        "story": document.getElementById('sprompt').value + document.getElementById('eprompt').value
    };
    if (params.story.length > 0) {
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
            })
    } else {
        alert("Cannot Generate Comic Strip for Empty Story")
    }
}
