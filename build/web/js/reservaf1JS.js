var precioIda = 0;
var precioVuelta = 0;

var vueloida = null;
var vuelovuelta = null;

var numpasajeros;

// AJAX
function AJAXCrearObjeto() {
    if (window.XMLHttpRequest) {
        // navegadores que siguen los estándares
        var objetoAjax = new XMLHttpRequest();
    } else {
        // navegadores obsoletos
        var objetoAjax = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return objetoAjax;
}

function buscarVuelo(idVuelo, pasajeros, tipo) {

    numpasajeros = pasajeros;

    var objetoAjax = AJAXCrearObjeto();

    objetoAjax.open('GET', 'http://localhost:8080/DreamHackAirline/AJAXvuelos?tipo=' + tipo + '&idVuelo=' + idVuelo, true);

    objetoAjax.send();

    objetoAjax.onreadystatechange = function () {
        if (objetoAjax.readyState == 4 && objetoAjax.status == 200) {
            var vuelo = JSON.parse(objetoAjax.responseText);
            console.log(vuelo);
            if (vuelo != "" && tipo === "ida") {
                vueloida = vuelo;
                actualizarVentana();
            }
            if (vuelo != "" && tipo === "vuelta") {
                vuelovuelta = vuelo;
                actualizarVentana();
            }
        }
    };
}

function actualizarVentana() {
    if (vueloida != null) {
        var divida = document.getElementById("vueloida-vflotante");
        divida.innerHTML = "";
        var tabla = document.createElement("table");
            tabla.style.marginBottom = "5px";
            tabla.setAttribute("class", "tabla-interior-vflotante");
            var tr1 = document.createElement("tr");
                var td1 = document.createElement("td");
                    td1.appendChild(document.createTextNode("Vuelo ida"));
                    td1.setAttribute("colspan", "2");
                    td1.style.textAlign = "center";
                    td1.style.fontWeight = "bold";
                    td1.style.borderBottom = "1px solid black";
                tr1.appendChild(td1);
            tabla.appendChild(tr1);
            
            var tr2 = document.createElement("tr");
                var td2 = document.createElement("td");
                    td2.appendChild(document.createTextNode("Num:"));
                tr2.appendChild(td2);
                var td3 = document.createElement("td");
                    td3.style.textAlign = "right";
                    td3.appendChild(document.createTextNode(vueloida.numero));
                tr2.appendChild(td3);
            tabla.appendChild(tr2);
            
            var tr3 = document.createElement("tr");
                var td4 = document.createElement("td");
                    td4.appendChild(document.createTextNode("Precio:"));
                tr3.appendChild(td4);
                var td5 = document.createElement("td");
                    td5.appendChild(document.createTextNode(numpasajeros + "x " + (vueloida.precio) + "€"));
                    td5.style.textAlign = "right";
                tr3.appendChild(td5);
            tabla.appendChild(tr3);
            
            var tr4 = document.createElement("tr");
                var td6 = document.createElement("td");
                    td6.setAttribute("colspan", "2");
                    td6.style.fontWeight = "bold";
                    td6.style.textAlign= "right";
                    td6.appendChild(document.createTextNode((vueloida.precio*numpasajeros) + "€"));
                tr4.appendChild(td6);
            tabla.appendChild(tr4);
            
        divida.appendChild(tabla);
        precioIda = vueloida.precio*numpasajeros;
        actualizarTotal();
        //$("#acordeonvuelo").accordion("refresh");
                    
    }
    if (vuelovuelta != null) {
        var divuelta = document.getElementById("vuelovuelta-vflotante");
        divuelta.innerHTML = "";
        var tabla = document.createElement("table");
        tabla.setAttribute("class", "tabla-interior-vflotante");
            var tr1 = document.createElement("tr");
                var td1 = document.createElement("td");
                    td1.appendChild(document.createTextNode("Vuelo vuelta"));
                    td1.setAttribute("colspan", "2");
                    td1.style.textAlign = "center";
                    td1.style.fontWeight = "bold";
                    td1.style.borderBottom = "1px solid black";
                tr1.appendChild(td1);
            tabla.appendChild(tr1);
            
            var tr2 = document.createElement("tr");
                var td2 = document.createElement("td");
                    td2.appendChild(document.createTextNode("Num:"));
                tr2.appendChild(td2);
                var td3 = document.createElement("td");
                    td3.style.textAlign = "right";
                    td3.appendChild(document.createTextNode(vuelovuelta.numero));
                tr2.appendChild(td3);
            tabla.appendChild(tr2);
            
            var tr3 = document.createElement("tr");
                var td4 = document.createElement("td");
                    td4.appendChild(document.createTextNode("Precio:"));
                tr3.appendChild(td4);
                var td5 = document.createElement("td");
                    td5.appendChild(document.createTextNode(numpasajeros + "x " + (vuelovuelta.precio) + "€"));
                    td5.style.textAlign = "right";
                tr3.appendChild(td5);
            tabla.appendChild(tr3);
            
            var tr4 = document.createElement("tr");
                var td6 = document.createElement("td");
                    td6.setAttribute("colspan", "2");
                    td6.style.fontWeight = "bold";
                    td6.style.textAlign= "right";
                    td6.appendChild(document.createTextNode((vuelovuelta.precio*numpasajeros) + "€"));
                tr4.appendChild(td6);
            tabla.appendChild(tr4);
            
        divuelta.appendChild(tabla);
        precioVuelta = vuelovuelta.precio*numpasajeros;
        actualizarTotal();
        //$("#acordeonvuelo").accordion("refresh");
                    
    }
}

function actualizarTotal(){
    var spantotal = document.getElementById("total");
    
    spantotal.innerHTML = "";
    spantotal.appendChild(document.createTextNode(precioIda+precioVuelta));
    
}


