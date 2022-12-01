function getTitles() {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", 'http://152.7.177.129:8000/titles', false); // false for synchronous request
    xmlHttp.send(null);
    return JSON.parse(xmlHttp.response);
}
var titles = getTitles();
div = document.getElementById("titles");

titles.forEach(e => {
    div = document.getElementById("titles").appendChild(document.createElement("button"));
    div.appendChild(document.createTextNode(e));
    div.className += 'btn btn-outline-dark w-100 btn-lg mt-1 mb-1 cust'
    div.addEventListener('click', function (event) {
        document.location.href = './story.html';
        sessionStorage.setItem("title", event.srcElement.childNodes[0].data);
    });
});


