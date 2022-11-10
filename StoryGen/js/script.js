
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

function countSetting(){
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
    xmlHttp.open("GET", 'http://152.7.176.41:8000/getCohesion' + formatParams(params), false); // false for synchronous request
    xmlHttp.send(null);
    return JSON.parse(xmlHttp.response);
}


function evaluateStory() {
    removeAllChildNodes(document.getElementById("div2"));
    var count  = countSetting();
    div1 = document.getElementById("div2").appendChild(document.createElement("div"));
    div1.appendChild(document.createTextNode("You covered " + count  + " settings in your story"));
    div2 = document.getElementById("div2").appendChild(document.createElement("div"));
    div2.appendChild(document.createTextNode("Cohesion score " + getCohesion()));
}

function startGenerateHTML(){
    function getOptions(params) {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open("GET", 'http://152.7.176.41:8000/getChoices' + formatParams(params), false); // false for synchronous request
        xmlHttp.send(null);
        return JSON.parse(xmlHttp.response);
    }
    var firstPrompts = {
        "start_prompt" : document.getElementById('sprompt').value,
        "end_prompt": document.getElementById('eprompt').value,
    }
    var options  = getOptions(firstPrompts);
    
    console.log(typeof options, options);

    removeAllChildNodes(document.getElementById("div1"));

    if(options.length == 0){
        div = document.getElementById("div1").appendChild(document.createElement("div"));
        div.appendChild(document.createTextNode("No more suggestions available from AI. Kindly add more to the starting prompt."));
    }

    for(obj of options){
        div = document.getElementById("div1").appendChild(document.createElement("button"));
        div.appendChild(document.createTextNode(obj));
        
        div.addEventListener('click', function (event) {
            document.getElementById("sprompt").value = document.getElementById('sprompt').value + event.srcElement.childNodes[0].data;
        });
        console.log(div)
    }
    


    // var split_options = options.split(",")
    // console.log(split_options);

    // var set = new Set();
    
    // if(split_options.length > 1){
    //     for(var i = 0; i< split_options.length; i++){
    //         set.add(split_options[i]);
    //     }
    // }



    // if(set.size  == 3){
    //     document.getElementById("foption_sg").innerHTML = "";
         
    // }
}

function getSetting(){
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", 'http://152.7.176.41:8000/getSetting', false); // false for synchronous request
    xmlHttp.send(null);
    return JSON.parse(xmlHttp.response);
}

function getImage() {
    var params = {
        "story": setting.hero + " and " + setting.villain + " in " + setting.location
    };

    fetch('http://152.7.176.41:8000/getImage' + formatParams(params))
        .then(response => response.json())
        .then(response => {
            console.log(response);
            var sprompt = document.getElementById('sprompt');
            sprompt.style.backgroundImage = 'url('+response+')';
            sprompt.style.backgroundSize = 'contain';
            sprompt.style.backgroundRepeat = 'no-repeat';


            sprompt.style.opacity = 0.5;
            // sprompt.style.zIndex = -1;
            console.log(response);
        });
    // var xmlHttp = new XMLHttpRequest();
    // xmlHttp.open("GET", 'http://152.7.176.41:8000/getImage' + formatParams(params), false); // false for synchronous request
    // xmlHttp.send(null);
    // // return JSON.parse(xmlHttp.response);
    // return xmlHttp.responseText
}



