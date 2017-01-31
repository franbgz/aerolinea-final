function añadirBebe(numero) {
    var checkbox = document.getElementById("servicio3-" + numero).checked;
    var objdiv = document.getElementById("divbebe"+numero);
    if (checkbox === true) {
        var objtabla = document.createElement("table");
            objtabla.setAttribute("class", "tablabebe");
            var objtr1 = document.createElement("tr");
                var objtd1 = document.createElement("td");
                    objtd1.appendChild(document.createTextNode("Nombre"));
                objtr1.appendChild(objtd1);
                var objtd2 = document.createElement("td");
                    var objinput1 = document.createElement("input");
                        objinput1.type = "text";
                        objinput1.setAttribute("placeholder", "Nombre");
                        objinput1.setAttribute("name", "nombreBebe"+numero);
                        objinput1.setAttribute("required", "");
                        objinput1.setAttribute("class", "form-control");
                    objtd2.appendChild(objinput1);
                objtr1.appendChild(objtd2);
            objtabla.appendChild(objtr1);
            var objtr2 = document.createElement("tr");
                var objtd3 = document.createElement("td");
                    objtd3.appendChild(document.createTextNode("Apellidos"));
                objtr2.appendChild(objtd3);
                var objtd4 = document.createElement("td");
                    var objinput2 = document.createElement("input");
                        objinput2.type = "text";
                        objinput2.setAttribute("placeholder", "Apellidos");
                        objinput2.setAttribute("name", "apellidosBebe"+numero);
                        objinput2.setAttribute("required", "");
                        objinput2.setAttribute("class", "form-control");
                    objtd4.appendChild(objinput2);
                objtr2.appendChild(objtd4);
            objtabla.appendChild(objtr2);
            var objtr3 = document.createElement("tr");
                var objtd5 = document.createElement("td");
                    objtd5.appendChild(document.createTextNode("DNI"));
                objtr3.appendChild(objtd5);
                var objtd6 = document.createElement("td");
                    var objinput3 = document.createElement("input");
                        objinput3.type = "text";
                        objinput3.setAttribute("placeholder", "DNI");
                        objinput3.setAttribute("name", "dniBebe"+numero);
                        objinput3.setAttribute("required", "");
                        objinput3.setAttribute("class", "form-control");
                    objtd6.appendChild(objinput3);
                objtr3.appendChild(objtd6);
            objtabla.appendChild(objtr3);
        objdiv.appendChild(objtabla);
    }else{
        objdiv.innerHTML = "";
    }
    console.log(checkbox);
}

