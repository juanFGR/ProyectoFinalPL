/* lexical grammar */
%{
var reserved_words ={ PI: 'PI', E : 'E', PROCEDURE: 'procedure', VAR: 'var', END: 'end', CONST: 'const', IF: 'if', THEN: 'then', ELSE: 'else', BEGIN: 'begin', CALL: 'call', ODD: 'odd', P: 'p', WHILE: 'while', DO: 'do'}



%}    
%%

\s+|\#.*                                  /*    skip whitespace and comments */
(.)*"/fa"                                 { asig = yytext.replace(/\/[f][a]|\n/g,""); yytext = {asignatura: asig}; return 'ASIGNA'; }
(.)*"/ff"                                 { fe = yytext.replace(/\/[f][f]|\n/g,""); yytext = {fecha: fe}; return 'FECHA'; }
(.)*"/fp"                                 { preg = yytext.replace(/\/[f][p]|\n/g,""); yytext = {pregunta: preg}; return 'PREGUNTA'; }
(.)*"/fr"                                 { resp = yytext.replace(/\/[f][r]|\n/g,""); yytext = {respuesta: resp}; return 'RESPUESTA'; }

\b\d+("."\d*)?([eE][-+]?\d+)?\b                                      return 'NUM'
"sqrt"                                                               return 'RAIZ'
/*\b(\w)\b                                                             return 'PALABRA'*/
/* [<>=!][=]|[<>]                   return 'COMPARISION' */
[-*/+^!%=();]                                                        return yytext;
(.)                                                                  return 'DOT'
<<EOF>>                                                              return 'EOF'






