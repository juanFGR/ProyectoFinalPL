var assert = chai.assert;

suite('Detección correcta de códigos simples', function() {
  /*test('Comprobación de asignación', function(){
    var aux = calculator.parse("var variable; variable = 150 .");
    assert.equal(aux[1][0], "ASSIGN")
    assert.equal(aux[1][1][1].ID, "variable")
  });*/

  test('Comprobación de suma', function(){
    var aux = calculator.parse("var variable; variable = 100 + 50 .")
    assert.equal(aux[1][3][0], "+")
  });

  test('Comprobación de multiplicación', function(){
    var aux = calculator.parse("var variable; variable = 5 * 10 .")
    assert.equal(aux[1][3][0], "*")
  });

  test('Comprobación de división', function(){
    var aux = calculator.parse("var variable; variable = 100 / 2 .")
    assert.equal(aux[1][3][0], "/")
  });

  test('Comprobación de precedencia de operadores', function(){
    var aux = calculator.parse("var variable; variable = 10 + 20 * 2 .")
    assert.equal(aux[1][3][0], "+")
    assert.equal(aux[1][3][1][3][0], "*")
  });

  test('Comprobación de comparación', function(){
    var aux = calculator.parse("var variable1, variable2; if variable1 == 100 then variable2 = 200 end;.")
    assert.equal(aux[1][0].condition[0].comparision, "==")
  });

  test('Comprobación de recursividad a izquierdas', function(){
    var aux = calculator.parse("var variable; variable = 10 - 5 - 1 .");
    assert.equal(aux[0], "ASSIGN")
    assert.equal(aux[1][3][0], "-")
    assert.equal(aux[1][3][1][1][0], "-")
  });

  test('Comprobación de detección de errores', function(){
    assert.throws(function() { calculator.parse("variable = %&~€!;.."); }, /Parse error/);
  });

});

suite('Detección correcta de códigos complejos', function(){
  test('Comprobación de IF', function(){
    var aux = calculator.parse("var variable1, variable2; if variable1 == 100 then variable2 = 200 end;.")
    assert.equal(aux[0], "If-Then")
  });
  
   test('Comprobación de IF-ELSE', function(){
    var aux = calculator.parse("var variable1, variable2, variable3; if variable1 == 100 then variable2 = 200 else variable3 = 300 end;.")
    assert.equal(aux[0], "If-Then-Else")
  });

  test('Comprobación de BEGIN-END', function(){
    var aux = calculator.parse("var variable1, variable2; begin variable1 = 150; variable2  = 200; end; .")
    assert.equal(aux[0], "BEGIN-END")
  });

  test('Comprobación de WHILE-DO', function(){
    var aux = calculator.parse("var variable1, variable2, variable3; while variable1 == 250 do variable2 = variable3 - 1 end; .")
    assert.equal(aux[0], "WHILE")
  });

  test('Comprobación de CALL', function(){
    var aux = calculator.parse("procedure mifuncion: end; call mifuncion;.")
    assert.equal(aux.statements[0], "CALL")
  });

  test('Comprobación de paso de argumentos en CALL', function(){
    var aux = calculator.parse("procedure miFuncion(var1, var2, var3): end; call miFuncion(a, b, c); .")
    assert.equal(aux.statements[0], "CALL")
    assert.equal(aux.statements[1][0].arguments[0].name[0], "a")
    assert.equal(aux.statements[1][0].arguments[1].name[0], "b")
    assert.equal(aux.statements[1][0].arguments[2].name[0], "c")
  });
  
  test('Comprobación de paso de argumentos en PROCEDURE', function(){    
    var aux = calculator.parse("var a, b, x; procedure miFuncion(a, b): begin a = 1; b = 2; end;end; x = 7 - 1; .")
    //$('#output').html(JSON.stringify(aux,undefined,2));
    assert.equal(aux.procedures[0], "process")
    assert.equal(aux.procedures[2].parameters[0].name[0], "a")
    assert.equal(aux.procedures[2].parameters[1].name[0], "b")
  });
});
