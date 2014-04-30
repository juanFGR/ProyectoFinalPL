/* lexical grammar */
   
%%

\s+|\#.*                            /*    skip whitespace and comments */
(.)*"/fa"                          { asig = yytext.replace(/\/[f][a]|\n/g,""); yytext = {asignatura: asig}; return 'ASIGNA'; }
(.)*"/ff"                          { fe = yytext.replace(/\/[f][f]|\n/g,""); yytext = {fecha: fe}; return 'FECHA'; }
(.)*"/fp"                          { preg = yytext.replace(/\/[f][p]|\n/g,""); yytext = {pregunta: preg}; return 'PREGUNTA'; }
(.)*"/rc"                          { resp = yytext.replace(/\/[r][c]|\n/g,""); yytext = {respuesta: resp, type: "correct"}; return 'RESPUESTACORRECTA'; }
(.)*"/ri"                          { resp = yytext.replace(/\/[r][i]|\n/g,""); yytext = {respuesta: resp, type: "incorrect"}; return 'RESPUESTAINCORRECTA'; }
[-*/+^!%=();]                      return yytext;
(.)                                return 'DOT'
<<EOF>>                            return 'EOF'

/* Programa ejemplo
    procesadores /fa 
    21-02-1991 /ff
    ¿quien descubrio america? /fp
    Fue colon /rc
    Fue Paris Hilton /ri
    ¿Donde vives? /fp
    En la palma /ri
    En tenerife /rc
    En la gomera /ri .  
*/




