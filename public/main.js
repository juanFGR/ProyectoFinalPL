$(document).ready(function() {
  $('#parse').click(function() {
    try {
      document.getElementById("arbol_generado").className = 'unhidden';
      function findPos(obj) {
        var curtop = 0;
        if (obj.offsetParent) {
            do {
                curtop += obj.offsetTop;
            } while (obj = obj.offsetParent);
        return [curtop];
        }
      }
      window.scroll(0,findPos(document.getElementById("arbol_generado")));
      var editor = $('.CodeMirror')[0].CodeMirror;
      var source = editor.getValue();
      var result = calculator.parse(source);
      editor_output.setValue(JSON.stringify(result,undefined,2));
      $('#output').html(JSON.stringify(result,undefined,2));
    } catch (e) {
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

});



  


