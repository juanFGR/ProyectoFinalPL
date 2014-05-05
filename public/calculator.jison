
%token ASIGNA FECHAEX PREG RESP FA PALABRA NUM RAIZ FP FF FR  DOT ASIGNA FECHA PREGUNTA RESPUESTA FRR
/* operator associations and precedence */

%right '='
%left '+' '-'
%left '*' '/'
%left '^'
%right '%'
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









