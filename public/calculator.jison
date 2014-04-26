/* description: Parses end executes mathematical expressions. */

%{

var idFatherProcedure = [];       /* Lista que va almacenando y eliminando el identificador numerico de cada 
                                 proceso. Me permite saber en cada momento el padre del proceso actual*/
var procedures_sym_table = [];   /* Array de procesos con sus declaraciones */
var actualProcess;               /* Variable que indica la posicion en el array de procedures_sym_table del
                                 proceso actual  */
var declarated; /* Variable que nos sirve para saber si un identificador fue declarado o no */
var IdIsConstant; /* Variable que nos sirve para saber si un identificador es una constante o no */

var finded; /* Variable que nos sirve para saber cuando se ha encontrado un proceso y cuando no */
  
var symbol_table = {};


var addProcess = function(processName) {
  if (processName == "block") {
    procedures_sym_table = procedures_sym_table.concat({name: processName, fatherProcess: "null", numberParams: 0, declarations: []});
    idFatherProcedure = idFatherProcedure.concat(0);
    actualProcess = 0;
    //alert("actualProcess = " + actualProcess);
  } else {
    var father;
    if (idFatherProcedure.length == 1) {
      father = idFatherProcedure[0]; 
    } else { 
      father = idFatherProcedure[idFatherProcedure.length - 1];
    }
    actualProcess = procedures_sym_table.length;
    procedures_sym_table = procedures_sym_table.concat({name: processName, fatherProcess: father, numberParams: 0, declarations: []}); 
    
    //alert("actualProcess = " + actualProcess + " padre: " + father);
  }
}
  
var identificatorDeclarated = function(identificatorName) {
  declarated = false;
  var idProcess = actualProcess;
  //alert("idProcess = " + idProcess);
  while (idProcess != "null") {
    
    for(var i = 0; i < procedures_sym_table[idProcess].declarations.length; i++){
      if (procedures_sym_table[idProcess].declarations[i].type == "identificator") {
        if (procedures_sym_table[idProcess].declarations[i].name == identificatorName) {
          declarated = true;
        }
      }
    }
    idProcess = procedures_sym_table[idProcess].fatherProcess;
    //alert("idProcess = " + idProcess);
  }
}


var identificatorIsConstant = function(identificatorName) {
  IdIsConstant = false;
  var idProcess = actualProcess;
  //alert("idProcess = " + idProcess);
  while (idProcess != "null") {
    for(var i = 0; i < procedures_sym_table[idProcess].declarations.length; i++){
      if (procedures_sym_table[idProcess].declarations[i].type == "constant") {
        if (procedures_sym_table[idProcess].declarations[i].name == identificatorName) {
          IdIsConstant = true;
        }
      }
    }
    idProcess = procedures_sym_table[idProcess].fatherProcess;
    //alert("idProcess = " + idProcess);
  }
}

var findProcess = function(processName) {
  finded = false;
  for(var i = 0; i < procedures_sym_table.length; i++){
    if (procedures_sym_table[i].name == processName) {
      finded = true;
      actualProcess = i;
    }
  }
}

var SetNumParamProcess = function(processName, numParam) {
  for(var i = 0; i < procedures_sym_table.length; i++){
    if (procedures_sym_table[i].name == processName) {
      procedures_sym_table[i].numberParams = numParam;
    }
  }
}

%}

%token NUMBER ID E PI EOF PROCEDURE LEFTPAR RIGHTPAR COLON SEMICOLON ASIGNA FECHAEX PREG RESP FA PALABRA NUM RAIZ FP FF FR  DOT ASIGNA FECHA PREGUNTA RESPUESTA FRR
/* operator associations and precedence */

%right '='
%left '+' '-'
%left '*' '/'
%left '^'
%right '%'
%left UMINUS
%left '!'

%start prog

%% /* language grammar */

/* ------------------------ */

prog  
    : asig fecha bloquePreg DOT
      { 
          $$ = [$1,$2,$3]; 
          return $$;
      }
    ;

asig
    : ASIGNA 
      {  /* Inyectar asignatura en HTML */  
          $$ = $1;
      }
    ;

fecha
    : FECHA
      {              
          $$ = $1;      
      }
    ;


bloquePreg
    : PREGUNTA respuestas 
      { 
         if ($2) $$ = [$1].concat($2); 
         else $$ = $1;
      }
    | PREGUNTA respuestas bloquePreg
      { 
         if ($3)
         {
           $$ = [$1].concat($2); 
           $$ = $$.concat($3); 
         }
         else $$ = $1;
      }
    ;

respuestas
    : /* empty */
    | RESPUESTACORRECTA respuestas
        { 
          if ($2) $$ = [$1].concat($2); 
          else $$ = $1;
        }
    | RESPUESTAINCORRECTA respuestas
        { 
          if ($2) $$ = [$1].concat($2); 
          else $$ = $1;
        }
    ;

enunPreg 
    : PREG math PREG
      { 
          $$ = $2;
      }
    ;

enunResp 
    : math 
      { 
          $$ = $1;
      }
    ;

math
    : NUM 
      {   /* Inyectar numero en HTML*/
          $$ = $1; 
          
      }
    | SENTENCIA
      {   /* Inyectar palabra en HTML*/
          $$ = $1; 
         
      }
    | PREG 
      {   /* Inyectar*/
          $$ = $1; 
          
      }
    | NUM '+' NUM
      {   /* Inyectar suma en HTML*/
          $$ = $1; 
          
      }
    | NUM '-' NUM
      {   /* Inyectar resta en HTML*/
          $$ = $1; 
         
      }
    | NUM '*' NUM
      {   /* Inyectar multiplicación en HTML*/
          $$ = $1; 
         
      }
    | NUM '/' NUM
      {   /* Inyectar división en HTML*/
          $$ = $1; 
          
      }
    | NUM '^' '(' NUM ')'
      {   /* Inyectar elevado en HTML*/
          $$ = $1; 
         
      }
    | '%' NUM
      {   /* Inyectar modulo en HTML*/
          $$ = $1; 
          
      }
    | RAIZ '(' NUM ')'
      {   /* Inyectar modulo en HTML*/
          $$ = $1; 
         
      }
    ;









