$(document).ready(function() {
  var responseID = {}; 
  $('#verArbol').click(function() {
    document.getElementById("arbol").className = 'unhidden';
  });
  $('#parse').click(function() {
    try {
      document.getElementById("savepdf").className = 'btn';
      document.getElementById("verArbol").className = 'btn';
      document.getElementById("corregir").className = 'btn';
      function findPos(obj) {
        var curtop = 0;
        if (obj.offsetParent) {
            do {
                curtop += obj.offsetTop;
            } while (obj = obj.offsetParent);
        return [curtop];
        }
      }
      window.scroll(0,findPos(document.getElementById("examen")));
      var editor = $('.CodeMirror')[0].CodeMirror;
      var source = editor.getValue();
      var result = calculator.parse(source);

	    var preguntaCont=0;

      $("#asignatura").html(result[0].asignatura).addClass("SubjectStyle");
      $("#fecha").html("Fecha: " + result[1].fecha).addClass("DateStyle");
      $("#preguntas").empty();
      var numResp = 1;
      for (i = 0; i < result[2].length; i++) {	
          var pregunta = result[2][i].pregunta;
          var respuesta = result[2][i].respuesta;
          if (pregunta) {
	          preguntaCont++;
	          $("#preguntas").append("<div class ='questionStyle' id=Question"+preguntaCont+"></div>");   
            $("#Question"+preguntaCont+"").append('<h2>\n' + pregunta + '\n</h2>');
          } else if (respuesta) {
            var tipo = result[2][i].type;
            var Idcheck = "check" + numResp; 
            if (tipo == "correct") {     
	              $("#Question"+preguntaCont+"").append('<div id=div'+numResp+'><input id=' + Idcheck + ' type="checkbox">' + respuesta + '</div><br>');  
	              responseID[Idcheck]=1;
                numResp++;
            } else if (tipo == "incorrect") {
	              responseID[Idcheck]=0;
                $("#Question"+preguntaCont+"").append('<div id=div'+numResp+'><input id=' + Idcheck + ' type="checkbox">' + respuesta + '</div><br>');
                numResp++;
            }
          }    
      }
      
      editor_output.setValue(JSON.stringify(result,undefined,2));
      $('#output').html(JSON.stringify(result,undefined,2));
    } catch (e) {
      document.getElementById("savepdf").className = 'hidden';
      document.getElementById("verArbol").className = 'hidden';
      document.getElementById("corregir").className = 'hidden';
      document.getElementById("arbol").className = 'unhidden';

      $('#output').html('<div class="error"><pre>\n' + String(e) + '\n</pre></div>');
      editor_output.setValue(String(e));
    }
  });

  $("#examples").change(function(ev) {
    var f = ev.target.files[0]; 
    var r = new FileReader();
    r.onload = function(e) { 
      var contents = e.target.result;   
      //input.innerHTML = contents;
      var editor = $('.CodeMirror')[0].CodeMirror;
      editor.setValue(contents);
    }
    r.readAsText(f);
  });

  
  $("#corregir").click(function(){
/*
  var val = [];
   var result=0,cont=0;
        $("input:checked").each(function(i){
	    if($(this).parent().get(0).className === "RespCorr"){
	      cont++;
	     $(this).css( "color:#00FF00; !important" );
	    }
		
	    result++;
	   
	  });
	 
      alert("resultado = "+cont+"/"+result);
		 });
*/
    var pregCorrec = [];
    var val = [];
    var numPreg;
    var cont=0;
    $('.questionStyle').each(function(j){
      val[j] = $(this).html();
      numPreg = j;  // almaceno el número de pregunta en el que estoy
      pregCorrec[numPreg] = true; // supongo que la pregunta esta correcta
      var checkboxId = [];  // array con los identificadores de los checkboxes de cada pregunta
      checkboxId = val[numPreg].match(/(check\d+)/g); // Guardo en el array todos los identificadores de checkboxes de esa pregunta
     
      for (i = 0; i < checkboxId.length; i++) {
        if (document.getElementById(checkboxId[i]).checked) { // Si esta pulsado y la respuesta es incorrecta pongo la pregunta a mal
          if (responseID[checkboxId[i]] == 0) { 
            pregCorrec[numPreg] = false;
	    $("#div"+(i+cont+1)).removeClass().addClass("RespIncorr");
          }else{
	       $("#div"+(i+cont+1)).removeClass().addClass("RespCorr");
	  } 
        } else if (responseID[checkboxId[i]] == 1) {   // Si no esta pulsado y la respuesta es correcta también pongo la pregunta a mal
          pregCorrec[numPreg] = false;
	      $("#div"+(i+cont+1)).removeClass().addClass("RespCorr");
	    
        } // Si recorro todos lo checkboxes y no se cumple ninguno de los casos anteriores la pregunta se queda en correcta = true
        else if(responseID[checkboxId[i]] == 0){
	   $("#div"+(i+cont+1)).removeClass().addClass("RespIncorr");
	}
	
      }
       cont+=checkboxId.length;
    });
    numPreg = val.length; // Almaceno el número de preguntas totales
    var numPregCorrec = 0;
    for (i = 0; i < numPreg; i++) {
      if (pregCorrec[i] == true) {
        numPregCorrec++;
	 
      }
    }
    
    alert("Resultado = " + numPregCorrec + "/" + numPreg);
  });
  
});



  


