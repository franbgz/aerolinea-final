var lugares = ["Valencia", "Estocolmo", "Cluj-Napoca", "Moscu"]

function cargaPagina() {
    var selectdestino = document.getElementById('destino');
    for (var x = 1; x < lugares.length; x++) {
        var destino = document.createElement('option');
        destino.value = lugares[x];
        destino.appendChild(document.createTextNode(lugares[x]));
        selectdestino.appendChild(destino);
    }
}

function cambiaDestino(origen) {
    var selectdestino = document.getElementById('destino');
    selectdestino.innerHTML = "";
    for (var x in lugares) {
        if (origen != lugares[x]) {
            var destino = document.createElement('option');
            destino.value = lugares[x];
            destino.appendChild(document.createTextNode(lugares[x]));
            selectdestino.appendChild(destino);
        }
    }
}

function bebe(numero){
    console.log(numero);
}

$(document).ready(function () {


    (function (factory) {
        if (typeof define === "function" && define.amd) {

            // AMD. Register as an anonymous module.
            define(["../widgets/datepicker"], factory);
        } else {

            // Browser globals
            factory(jQuery.datepicker);
        }
    }(function (datepicker) {

        datepicker.regional.es = {
            closeText: "Cerrar",
            prevText: "&#x3C;Ant",
            nextText: "Sig&#x3E;",
            currentText: "Hoy",
            monthNames: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
                "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
            ],
            monthNamesShort: ["ene", "feb", "mar", "abr", "may", "jun",
                "jul", "ago", "sep", "oct", "nov", "dic"
            ],
            dayNames: ["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"],
            dayNamesShort: ["dom", "lun", "mar", "mié", "jue", "vie", "sáb"],
            dayNamesMin: ["D", "L", "M", "X", "J", "V", "S"],
            weekHeader: "Sm",
            dateFormat: "dd/mm/yy",
            firstDay: 1,
            isRTL: false,
            showMonthAfterYear: false,
            yearSuffix: ""
        };
        datepicker.setDefaults(datepicker.regional.es);

        return datepicker.regional.es;

    }));

    $("input.fecha").datepicker({
        beforeShowDay: $.datepicker.noWeekends,
        firstDay: 1,
        minDate: new Date(),
        maxDate: '+1Y',
        changeMonth: true,
        beforeShow: function () {
            setTimeout(function () {
                $('.ui-datepicker').css('z-index', 999);
            }, 0);
        }
    });
    
    $("input.fechalib").datepicker({
        firstDay: 1,
        changeYear: true,
        changeMonth: true
    })
    
    $("input.fechanacAdulto").datepicker({
        firstDay: 1,
        maxDate: "-18y",
        changeYear: true,
        changeMonth: true
    });
    
    

    $("#viajeros").spinner({
        min: 1,
        max: 6
    });
    //$("select.selectpicker").selectmenu();

    $("#accordion").accordion({
        collapsible: true
    });

    $("#acordeonvuelo").accordion({
        collapsible: true,
        heightStyle: "content"
    });

    $("#acordeonpasajero").accordion({
        collapsible: true,
        heightStyle: "content",
        active: 1
    });
    
    $("#acordeonservicios").accordion({
        collapsible: true,
        active: 2
    });

    $("input.fechanac").datepicker({
        firstDay: 1,
        maxDate: new Date(),
        changeYear: true,
        changeMonth: true
    });
    
    $("input#fechanac1").datepicker({
        firstDay:1,
        maxDate: "-18y",
        changeYear: true,
        changeMonth: true
        
    });
    
    var selectmes = document.getElementById("mesCaducidad");
    for (var i = 1; i <= 12; i++) {
        var option = document.createElement("option");
            option.value = i;
            option.appendChild(document.createTextNode(i));
            selectmes.appendChild(option);
    }
    
    var selectaño = document.getElementById("añoCaducidad");
    for (var i = 2016; i <= 2020; i++) {
        var option = document.createElement("option");
            option.value = i;
            option.appendChild(document.createTextNode(i));
            selectaño.appendChild(option);
    }
});

