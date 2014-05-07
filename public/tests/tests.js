var assert = chai.assert;

suite('Comprobación de la correcta creación del arbol', function(){
    test('Comprobación de la asignatura', function() {
        var aux = calculator.parse("procesadores /fa 21-02-1991 /ff ¿quien descubrio america? /fp Fue colon /rc Fue Paris Hilton /ri .")
        assert.equal(aux[0].asignatura, "procesadores ")
    });
    test('Comprobación de la fecha', function() {
        var aux = calculator.parse("procesadores /fa 21-02-1991 /ff ¿quien descubrio america? /fp Fue colon /rc Fue Paris Hilton /ri .")
        assert.equal(aux[1].fecha, "21-02-1991 ")
    });
    
    test('Comprobación de pregunta', function() {
        var aux = calculator.parse("procesadores /fa 21-02-1991 /ff ¿quien descubrio america? /fp Fue colon /rc Fue Paris Hilton /ri .")
        assert.equal(aux[2][0].pregunta, "¿quien descubrio america? ")
    });
    
    test('Comprobación de respuesta correcta', function() {
        var aux = calculator.parse("procesadores /fa 21-02-1991 /ff ¿quien descubrio america? /fp Fue colon /rc Fue Paris Hilton /ri .")
        assert.equal(aux[2][1].type, "correct")
    });
    
    test('Comprobación de respuesta incorrecta', function() {
        var aux = calculator.parse("procesadores /fa 21-02-1991 /ff ¿quien descubrio america? /fp Fue colon /rc Fue Paris Hilton /ri .")
        assert.equal(aux[2][2].type, "incorrect")
    });
});
