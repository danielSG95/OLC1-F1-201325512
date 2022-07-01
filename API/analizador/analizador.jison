%{
    // aqui se llama al arbol
    const Token = require('./Token').Token;
    const Error = require('./Error').Error;
    const {Literal} = require('../expresiones/Literal');
    const {Type} = require('../symbols/Type');
    const {Declaracion} = require('../instrucciones/Declaracion');
    const {Singleton} = require('../singleton/Singleton');
    const {Bloque} = require('../instrucciones/Bloque');
    const {Asignacion} = require('../instrucciones/Asignacion');
    const {IncDec} = require('../instrucciones/IncDec');
    const {While} = require('../instrucciones/While');
    const {Return} = require('../instrucciones/Return');
    const {Break} = require('../instrucciones/Break');
    const {Continue} = require('../instrucciones/Continue');
    const {If} = require('../instrucciones/If');
    const {DoWhile} = require('../instrucciones/DoWhile');
    const {For} = require('../instrucciones/For');
    const {Funcion, listParams} = require('../instrucciones/Funcion');
    const {Llamada} = require('../instrucciones/Llamada');
    const {Switch, Case } = require('../instrucciones/Switch');
    const { ToLower } = require('../instrucciones/ToLower');
    const { ToUpper } = require('../instrucciones/ToUpper');
    const { Round } = require('../instrucciones/Round');
    const { GraficarTs } = require("../instrucciones/GraficarTs");
    const { Ternario } = require('../instrucciones/Ternario');
    const { Array, arrayContent, arrayLiteral } = require('../instrucciones/Array');
    const { Push } = require('../instrucciones/Push');
    const { Pop } = require('../instrucciones/Pop');
    const { Length } = require('../instrucciones/Length');
    const { ToCharArray} = require('../instrucciones/ToCharArray');
    const { IndexOf } = require('../instrucciones/IndexOf');
    const { AsigArray } = require('../instrucciones/AsigArray');
    const { Splice } = require('../instrucciones/Splice');
// esto es un comentario 
    // expresiones 
    const {Aritmetica, AritmeticOp} = require('../expresiones/Aritmetica');
    const {Relacional, RelacionaOp} = require('../expresiones/Relacional');
    const {Logica, LogicaOp} = require('../expresiones/Logica');
    const { Print } = require('../instrucciones/Print');   
    const { Println } = require('../instrucciones/Println');   
    const { Typeof } = require('../instrucciones/Typeof');   
    
    let sg = Singleton.getInstance();    
    let tokens = [];
    let errores = sg.errores;
%}

%lex

%options case-insensitive


%%
\s+                                     //se ignoran espacios en blanco
"//".*                                  //Comentarios unilinea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]     //comentarios multilinea

// palabras reservadas


"int"                       { tokens.push(new Token('r_int', yytext, yylloc.first_line, yylloc.first_column)); return 'RINT';}
"double"                    { tokens.push(new Token('r_double', yytext, yylloc.first_line, yylloc.first_column)); return 'RDOUBLE';}
"char"                      { tokens.push(new Token('r_char', yytext, yylloc.first_line, yylloc.first_column)); return 'RCHAR';}
"boolean"                   { tokens.push(new Token('r_boolean', yytext, yylloc.first_line, yylloc.first_column)); return 'RBOOLEAN';}
"String"                    { tokens.push(new Token('r_string', yytext, yylloc.first_line, yylloc.first_column)); return 'RSTRING';}
"const"                     { tokens.push(new Token('r_const', yytext, yylloc.first_line, yylloc.first_column)); return 'RCONST';}
"if"                        { tokens.push(new Token('r_if', yytext, yylloc.first_line, yylloc.first_column)); return 'RIF';}
"else"                      { tokens.push(new Token('r_else', yytext, yylloc.first_line, yylloc.first_column)); return 'RELSE';}
"null"                      { tokens.push(new Token('r_null', yytext, yylloc.first_line, yylloc.first_column)); return 'RNULL';}
"switch"                    { tokens.push(new Token('r_switch', yytext, yylloc.first_line, yylloc.first_column)); return 'RSWITCH';}
"case"                      { tokens.push(new Token('r_case', yytext, yylloc.first_line, yylloc.first_column)); return 'RCASE';}
"default"                   { tokens.push(new Token('r_default', yytext, yylloc.first_line, yylloc.first_column)); return 'RDEFAULT';}
"for"                       { tokens.push(new Token('r_for', yytext, yylloc.first_line, yylloc.first_column)); return 'RFOR';}
"while"                     { tokens.push(new Token('r_while', yytext, yylloc.first_line, yylloc.first_column)); return 'RWHILE';}
"true"                      { tokens.push(new Token('r_true', yytext, yylloc.first_line, yylloc.first_column)); return 'RTRUE';}
"false"                     { tokens.push(new Token('r_false', yytext, yylloc.first_line, yylloc.first_column)); return 'RFALSE';}
"do"                        { tokens.push(new Token('r_do', yytext, yylloc.first_line, yylloc.first_column)); return 'RDO';}
"continue"                  { tokens.push(new Token('r_continue', yytext, yylloc.first_line, yylloc.first_column)); return 'RCONTINUE';}
"void"                      { tokens.push(new Token('r_void', yytext, yylloc.first_line, yylloc.first_column)); return 'RVOID';}
"return"                    { tokens.push(new Token('r_return', yytext, yylloc.first_line, yylloc.first_column)); return 'RRETURN';}
"call"                      { tokens.push(new Token('r_call', yytext, yylloc.first_line, yylloc.first_column)); return 'RCALL';}
"break"                     { tokens.push(new Token('r_break', yytext, yylloc.first_line, yylloc.first_column)); return 'RBREAK';}
"Println"                   { tokens.push(new Token('r_println', yytext, yylloc.first_line, yylloc.first_column)); return 'RPRINTLN';}
"Print"                     { tokens.push(new Token('r_print', yytext, yylloc.first_line, yylloc.first_column)); return 'RPRINT';}
"Typeof"                    { tokens.push(new Token('r_typeof', yytext, yylloc.first_line, yylloc.first_column)); return 'RTYPEOF';}
"null"                      { tokens.push(new Token('r_null', yytext, yylloc.first_line, yylloc.first_column)); return 'RNULL';}
"graficar_ts"               { tokens.push(new Token('r_graficar_ts', yytext, yylloc.first_line, yylloc.first_column)); return 'RGRAFICAR_TS';}
"tolower"                   { tokens.push(new Token('r_tolower', yytext, yylloc.first_line, yylloc.first_column)); return 'RTOLOWER';}
"toupper"                   { tokens.push(new Token('r_toupper', yytext, yylloc.first_line, yylloc.first_column)); return 'RTOUPPER';}
"round"                     { tokens.push(new Token('r_round', yytext, yylloc.first_line, yylloc.first_column)); return 'RROUND';}
"length"                    { tokens.push(new Token('r_length', yytext, yylloc.first_line, yylloc.first_column)); return 'RLENGTH';}
"tochararray"               { tokens.push(new Token('r_tochararray', yytext, yylloc.first_line, yylloc.first_column)); return 'RTOCHARARRAY';}
"indexof"                   { tokens.push(new Token('r_indexof', yytext, yylloc.first_line, yylloc.first_column)); return 'RINDEXOF';}
"push"                      { tokens.push(new Token('r_push', yytext, yylloc.first_line, yylloc.first_column)); return 'RPUSH';}
"pop"                       { tokens.push(new Token('r_pop', yytext, yylloc.first_line, yylloc.first_column)); return 'RPOP';}
"splice"                    { tokens.push(new Token('r_splice', yytext, yylloc.first_line, yylloc.first_column)); return 'RSPLICE';}
"new"                       { tokens.push(new Token('r_new', yytext, yylloc.first_line, yylloc.first_column)); return 'RNEW';}
//simbolos

";"					        { tokens.push(new Token('tk_;', yytext, yylloc.first_line, yylloc.first_column)); return 'PTCOMA';}
","					        { tokens.push(new Token('tk_,', yytext, yylloc.first_line, yylloc.first_column)); return 'COMA';}
"("					        { tokens.push(new Token('tk_(', yytext, yylloc.first_line, yylloc.first_column)); return 'PARENTESIS_A';}
")"					        { tokens.push(new Token('tk_)', yytext, yylloc.first_line, yylloc.first_column)); return 'PARENTESIS_C';}
"{"					        { tokens.push(new Token('tk_{', yytext, yylloc.first_line, yylloc.first_column)); return 'LLAVE_A';}
"}"					        { tokens.push(new Token('tk_}', yytext, yylloc.first_line, yylloc.first_column)); return 'LLAVE_C';}
":"					        { tokens.push(new Token('tk_:', yytext, yylloc.first_line, yylloc.first_column)); return 'DOSPTS';}
"?"					        { tokens.push(new Token('tk_?', yytext, yylloc.first_line, yylloc.first_column)); return 'INTERROGACION';}
"["					        { tokens.push(new Token('tk_[', yytext, yylloc.first_line, yylloc.first_column)); return 'CORCHETE_A';}
"]"					        { tokens.push(new Token('tk_]', yytext, yylloc.first_line, yylloc.first_column)); return 'CORCHETE_C';}
"."					        { tokens.push(new Token('tk_.', yytext, yylloc.first_line, yylloc.first_column)); return 'PUNTO';}
// Relacionales
">="                        { tokens.push(new Token('tk_>=', yytext, yylloc.first_line, yylloc.first_column)); return 'MAYORI'; }
"<="                        { tokens.push(new Token('tk_<=', yytext, yylloc.first_line, yylloc.first_column)); return 'MENORI'; }
"=="                        { tokens.push(new Token('tk_==', yytext, yylloc.first_line, yylloc.first_column)); return 'IGUAL'; }
"!="                        { tokens.push(new Token('tk_!=', yytext, yylloc.first_line, yylloc.first_column)); return 'DIF'; }
">"                         { tokens.push(new Token('tk_>', yytext, yylloc.first_line, yylloc.first_column)); return 'MAYOR'; }
"<"                         { tokens.push(new Token('tk_<', yytext, yylloc.first_line, yylloc.first_column)); return 'MENOR'; }
"="                         { tokens.push(new Token('tk_=', yytext, yylloc.first_line, yylloc.first_column)); return 'ASIG'; }

// Logicos
"&&"                        { tokens.push(new Token('tk_and', yytext, yylloc.first_line, yylloc.first_column)); return 'AND'; }
"||"                        { tokens.push(new Token('tk_or', yytext, yylloc.first_line, yylloc.first_column)); return 'OR'; }
"!"                         { tokens.push(new Token('tk_not', yytext, yylloc.first_line, yylloc.first_column)); return 'NOT'; }
"^"                         { tokens.push(new Token('tk_xor', yytext, yylloc.first_line, yylloc.first_column)); return 'XOR'; }

// aritmeticos
"+"                         { tokens.push(new Token('tk_+', yytext, yylloc.first_line, yylloc.first_column)); return 'MAS'; }
"-"                         { tokens.push(new Token('tk_-', yytext, yylloc.first_line, yylloc.first_column)); return 'MENOS'; }
"*"                         { tokens.push(new Token('tk_*', yytext, yylloc.first_line, yylloc.first_column)); return 'MULT'; }
"/"                         { tokens.push(new Token('tk_/', yytext, yylloc.first_line, yylloc.first_column)); return 'DIV'; }
"**"                        { tokens.push(new Token('tk_**', yytext, yylloc.first_line, yylloc.first_column)); return 'POW'; }
"%"                         { tokens.push(new Token('tk_%', yytext, yylloc.first_line, yylloc.first_column)); return 'MOD'; }
"--"                        { tokens.push(new Token('tk_--', yytext, yylloc.first_line, yylloc.first_column)); return 'DEC'; }

// Expresiones Regulares
([a-zA-Z])[a-zA-Z0-9_]*	    { tokens.push(new Token('tk_identificador', yytext, yylloc.first_line, yylloc.first_column)); return 'IDENTIFICADOR'; }




[0-9]+("."[0-9]+)?\b  	    { tokens.push(new Token('tk_decimal', yytext, yylloc.first_line, yylloc.first_column)); return 'DECIMAL'; }
[0-9]+\b				    { tokens.push(new Token('tk_entero', yytext, yylloc.first_line, yylloc.first_column)); return 'ENTERO'; }

\"((\\\")|[^\"\n])*\"				    {  /*yytext = yytext.substr(1, yyleng-2);*/ tokens.push(new Token('tk_cadena', yytext, yylloc.first_line, yylloc.first_column)); 
                                return 'CADENA';                           
                            }
((\'([^]|\\\\|\\t|\\n|\\r|\\")\')|\'\')			    { yytext = yytext.substr(1, yyleng-2); tokens.push(new Token('tk_char', yytext, yylloc.first_line, yylloc.first_column)); 
                                return 'CHAR'; 
                            }


<<EOF>>                     return 'EOF';
.					        { 
                                errores.push(new Error(yytext, yylloc.first_line, yylloc.first_column, 'Caracter Desconocido', 'Error Lexico'));
                            }


/lex

%start s

%left 'OR'
%left 'AND'
%left 'XOR'
%left 'TEST'
%left 'MAYORI', 'MAYOR', 'IGUAL', 'DIF', 'MENORI', 'MENOR'
%left 'MAS' 'MENOS'
%left 'MULT' 'DIV', 'MOD'
%left 'POW' 
%right 'NOT'
%left 'UMENOS'

%% 
// empieza definicion de la gramatica.
s
    : ini EOF {
        return {
            tk : tokens, 
            err: errores, 
            ast: $1,
        };
    } 
    | error EOF {
        var e = new Error(err_lexema, this._$.first_line, this._$.first_column, esperados, "Error sintactico");
        errores.push(e);
    }
;

ini
    : linstrucciones {$$ = $1; }
;

linstrucciones
    : linstrucciones instruccion { $1.push($2); $$ = $1; }
    | instruccion { $$ = [$1]}
;

instruccionB
    : if { $$ = $1; } // listo 
    | switch{ $$ = $1; } 
    | for{ $$ = $1; } // listo
    | while { $$ = $1; } // listo
    | do{ $$ = $1; } // listo 
    | return { $$ = $1; } // listo 
    | func{ $$ = $1; } // listo 
    | bloque{ $$ = $1; } // listo 
    | error LLAVE_C {
        console.log(`Se ha encontrado un error con: ${err_lexema} linea : ${this._$.first_line} columna: ${this._$.first_column} Esperados: ${esperados} `);
        errores.push(new Error(err_lexema, this._$.first_line, this._$.first_column, esperados, "Error sintactico"));
    }
;

instruccionL
    : RBREAK PTCOMA{ $$ = new Break(@1.first_line, @1.first_column); } // listo 
    | RCONTINUE PTCOMA{ $$ = new Continue(@1.first_line, @1.first_column); } // listo 
    | call PTCOMA{ $$ = $1; } // listo
    | print PTCOMA { $$ = $1; } // listo
    | println PTCOMA { $$ = $1; } // listo 
    | typeof PTCOMA { $$ = $1; } // listo 
    | incdec PTCOMA{ $$ = $1; } // listo 
    | splice PTCOMA { $$ = $1; }
    | pop PTCOMA { $$ = $1; }
    | push PTCOMA { $$ = $1; }
    | graficarts PTCOMA { $$ = $1;}
    | tolower { $$ = $1;}
    | toupper PTCOMA { $$ = $1;}
    | round PTCOMA { $$ = $1;}
    | declaracionArray PTCOMA { $$ = $1;} // pendiente de implementar 
    | asignacion PTCOMA { $$ = $1; } // listo
    | declaracion PTCOMA { $$ = $1;} // listo
    | ternario PTCOMA { $$ = $1; } // esto podria generar errores, dado que una funcion inLine es invocada por una declaracion | asignacion 
    | error PTCOMA { 
        
        errores.push(new Error(err_lexema, this._$.first_line, this._$.first_column, esperados, "Error sintactico"));
        console.log(`Se ha encontrado un error con: ${err_lexema} linea : ${this._$.first_line} columna: ${this._$.first_column} Esperados: ${esperados} `);
    }
;

instruccion
   : instruccionB { $$ = $1;}
   | instruccionL { $$ = $1;} 
;
declaracion
    : tipo ldec asig { $$ = new Declaracion($2, $1, $3,false, @1.first_line, @1.first_column) }
    | RCONST tipo ldec asig { $$ = new Declaracion($3, $2, $4,true, @1.first_line, @1.first_column) }

;

declaracionArray
    : tipo IDENTIFICADOR CORCHETE_A CORCHETE_C ASIG asignacionArray{
        $$ = new Array($2,$1, $6, @1.first_line, @1.first_column);
    }
    | tipo IDENTIFICADOR CORCHETE_A CORCHETE_C CORCHETE_A CORCHETE_C ASIG  asignacionMatriz
    {

    }
;

asignacionArray
    :  RNEW tipo CORCHETE_A expresion_logica CORCHETE_C  { 
        $$ = new arrayContent($2, $4);
    }
    |  CORCHETE_A lAsigArray CORCHETE_C { $$ = new arrayContent(Type.NULL, $2)}
    | tocharArray { $$ = $1; }
;

lAsigArray
    : lAsigArray COMA expresion_logica {        
        $1.push($3);
        $$ = $1;
    }
    | expresion_logica { 
        $$ = [$1];
    }
;

asignacionMatriz
    : RNEW tipo CORCHETE_A expresion_logica CORCHETE_C CORCHETE_A expresion_logica CORCHETE_C 
    | CORCHETE_A lAsigMatriz CORCHETE_C
;

lAsigMatriz
    : lAsigMatriz COMA CORCHETE_A lAsigArray CORCHETE_C
    | CORCHETE_A lAsigArray CORCHETE_C
;

ldec
    : ldec COMA IDENTIFICADOR { $1.push($3); $$=$1; }
    | IDENTIFICADOR { $$ = [$1];}
;

asig
    : ASIG expresion_logica {$$ = $2;}
;


asignacion
    : IDENTIFICADOR ASIG expresion_logica { $$ = new Asignacion($1, $3, @1.first_line, @1.first_column);}
    | IDENTIFICADOR CORCHETE_A expresion_numerica CORCHETE_C ASIG expresion_logica { 
        $$ = new AsigArray($1, $3, $6, @1.first_line, @1.first_column);
    } 
    | IDENTIFICADOR CORCHETE_A expresion_numerica CORCHETE_C CORCHETE_A expresion_numerica CORCHETE_C ASIG expresion_logica // falta implementar 
;

if
    : RIF PARENTESIS_A expresion_logica PARENTESIS_C ifAux { $$ = new If($3, $5, null, null, @1.first_line, @1.first_column);}
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C ifAux RELSE if { $$ = new If($3, $5, null, $7, @1.first_line, @1.first_column);}
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C ifAux RELSE ifAux { $$ = new If($3, $5, $7, null, @1.first_line, @1.first_column);}
;

ifAux
    : LLAVE_A bodyBlock LLAVE_C { $$ = $2;}
    | instruccionL { $$ = [$1];}
;

switch
    : RSWITCH PARENTESIS_A expresion_numerica PARENTESIS_C LLAVE_A lcase LLAVE_C {
        $$ = new Switch($3, $6, @1.first_line, @1.first_column);
    }
;

lcase
    : lcase RCASE dato DOSPTS bodyBlock cdefault {
        $1.push(new Case($3, $5, $6)); $$ = $1;
    }
    | RCASE dato DOSPTS bodyBlock cdefault { 
        $$ = [new Case($2, $4, $5)];
    }
;

cdefault
    : RDEFAULT DOSPTS bodyBlock { $$ = $3; } 
    | %Empty
; 

for
    : RFOR PARENTESIS_A for_declaracion PTCOMA expresion_logica PTCOMA for_incremento PARENTESIS_C LLAVE_A bodyBlock LLAVE_C {
        $$ = new For($3, $5, $7, $10, @1.first_line, @1.first_column);
    }
;

for_declaracion
    : declaracion { $$ = $1;}
    | asignacion { $$ = $1;}
;

for_incremento
    : expresion_numerica { $$ = $1;}
    | IDENTIFICADOR ASIG expresion_logica { $$ = new Asignacion($1, $3, @1.first_line, @1.first_column);}
;

while
    : RWHILE PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A bodyBlock LLAVE_C { $$ = new While($3, $6, @1.first_line, @1.first_column);}
;

do
    : RDO LLAVE_A bodyBlock LLAVE_C RWHILE PARENTESIS_A expresion_logica PARENTESIS_C PTCOMA { $$ = new DoWhile($7, $3, @1.first_line, @1.first_column);}

;

return
    : RRETURN expresion_numerica PTCOMA { $$ = new Return($2, @1.first_line, @1.first_column);}
    | RRETURN PTCOMA { $$ = new Return(null, @1.first_line, @1.first_column);}

;

func
    : tipo IDENTIFICADOR PARENTESIS_A lparametros PARENTESIS_C LLAVE_A bodyBlock LLAVE_C {
        $$ = new Funcion($2, $1, $4, $7, @1.first_line, @1.first_column);
    }
    | RVOID IDENTIFICADOR PARENTESIS_A lparametros PARENTESIS_C LLAVE_A bodyBlock LLAVE_C { 

        $$ = new Funcion($2, $1, $4, $7, @1.first_line, @1.first_column);
    }
;

lparametros
    : %Empty { $$ = []}
    | lparametros COMA tipo IDENTIFICADOR {
         $1.push(new listParams($4, $3));
         $$ = $1;
    }
    | tipo IDENTIFICADOR { 
        $$ = [new listParams($2, $1)]
    
    }
;

bloque
    : LLAVE_A bodyBlock LLAVE_C { $$ = new Bloque($2, @1.first_line, @1.first_column); }
;

call
    : RCALL IDENTIFICADOR PARENTESIS_A largumentos PARENTESIS_C  { $$ = new Llamada($2, $4, @1.first_line, @1.first_column); }
;

largumentos
    : largumentos COMA expresion_numerica { $1.push($3); $$ = $1;}
    | expresion_numerica { $$ = [$1]}
    | %Empty { $$ = []}
;

print
    : RPRINT PARENTESIS_A expresion_logica PARENTESIS_C  { $$ = new Print($3, @1.first_line, @1.first_column);}
;

println
    : RPRINTLN PARENTESIS_A expresion_logica PARENTESIS_C  { $$ = new Println($3, @1.first_line, @1.first_column);}
;

typeof
    : RTYPEOF PARENTESIS_A expresion_logica PARENTESIS_C { $$ = new Typeof($3, @1.first_line, @1.first_column); }
;

length
    : RLENGTH PARENTESIS_A expresion_logica PARENTESIS_C { 
        $$ = new Length($3, @1.first_line, @1.first_column);
    }
;

tocharArray
    : RTOCHARARRAY PARENTESIS_A expresion_logica PARENTESIS_C { 
        $$ = new ToCharArray($3, @1.first_line, @1.first_column);
    }
;

indexOf
    : IDENTIFICADOR PUNTO RINDEXOF PARENTESIS_A expresion_logica PARENTESIS_C { 
        $$ = new IndexOf($1, $5, @1.first_line, @1.first_column); 
    }
;

push
    : IDENTIFICADOR PUNTO RPUSH PARENTESIS_A expresion_logica PARENTESIS_C { 
        $$ = new Push($1, $5, @1.first_line, @1.first_column);
    }
;

pop
    : IDENTIFICADOR PUNTO RPOP PARENTESIS_A PARENTESIS_C { 
        $$ = new Pop($1, @1.first_line, @1.first_column);
    }
;

splice
    : IDENTIFICADOR PUNTO RSPLICE PARENTESIS_A expresion_logica COMA expresion_logica PARENTESIS_C { 
        $$ = new Splice($1,$5, $7, @1.first_line, @1.first_column);
    }
;

bodyBlock
    : linstrucciones { $$ = $1;}
    | %Empty { $$ = []}
;
// aqui se implementan las funcionalidades de la segunda fase 
ternario
    : expresion_logica INTERROGACION cuerpoTernario DOSPTS cuerpoTernario {
        $$ = new Ternario($1, $3, $5, @1.first_line, @1.first_column);
    }
;

cuerpoTernario
    : expresion_logica { $$ = $1;}
    | println { $$ = $1;} 
    | print { $$ = $1;}   
    | asignacion { $$ = $1;}
    | call { $$ = $1;}
;

graficarts
    : RGRAFICAR_TS PARENTESIS_A PARENTESIS_C { $$ = new GraficarTs(@1.first_line, @1.first_column);}
;

tolower
    : RTOLOWER PARENTESIS_A expresion_logica PARENTESIS_C {
        $$ = new ToLower($3, @1.first_line, @1.first_column);
    }
;

toupper
    : RTOUPPER PARENTESIS_A expresion_logica PARENTESIS_C  { 
        $$ = new ToUpper($3, @1.first_line, @1.first_column);
    }
;

roud
    : RROUND PARENTESIS_A expresion_logica PARENTESIS_C {
        $$ = new Round($3, @1.first_line, @1.first_column);
    }
;

expresion_logica
    : expresin_relacional AND expresin_relacional {$$ = new Logica($1, $3, LogicaOp.and,@1.first_line, @1.first_column);}
    | expresin_relacional OR expresin_relacional{$$ = new Logica($1, $3, LogicaOp.or,@1.first_line, @1.first_column);}
    | expresin_relacional XOR expresin_relacional{$$ = new Logica($1, $3, LogicaOp.xor,@1.first_line, @1.first_column);}
    | NOT expresin_relacional %prec UMENOS {$$ = new Logica($2, $2, LogicaOp.not,@1.first_line, @1.first_column);}
    | expresin_relacional {$$ = $1;}
;


expresin_relacional
    : expresion_numerica MAYOR expresion_numerica {$$ = new Relacional($1, $3, RelacionaOp.mayor, @1.first_line, @1.first_column);}
    | expresion_numerica MENOR expresion_numerica{$$ = new Relacional($1, $3, RelacionaOp.menor, @1.first_line, @1.first_column);}
    | expresion_numerica MAYORI expresion_numerica{$$ = new Relacional($1, $3, RelacionaOp.mayori, @1.first_line, @1.first_column);}
    | expresion_numerica MENORI expresion_numerica{$$ = new Relacional($1, $3, RelacionaOp.menori, @1.first_line, @1.first_column);}
    | expresion_numerica IGUAL expresion_numerica{$$ = new Relacional($1, $3, RelacionaOp.igual, @1.first_line, @1.first_column);}
    | expresion_numerica DIF expresion_numerica{$$ = new Relacional($1, $3, RelacionaOp.dif, @1.first_line, @1.first_column);}
    | expresion_numerica {$$ = $1;}
;



expresion_numerica
    : MENOS expresion_numerica %prec UMENOS {
        $$ = new Aritmetica($2, new Literal(-1, Type.NUMBER, 0, 0) , AritmeticOp.UMENOS, @1.first_line, @1.first_column)
    }
    // | DEC expresion_numerica PTCOMA %prec UMENOS  { $$ = new IncDec($2, AritmeticOp.MENOS, @1.first_line, @1.first_column);} // probar si esto funciona correctamente
    | expresion_numerica MAS expresion_numerica { $$ = new Aritmetica($1, $3, AritmeticOp.MAS,@1.first_line, @1.first_column )}
    | expresion_numerica MENOS expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.MENOS,@1.first_line, @1.first_column )}
    | expresion_numerica MULT MULT expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.POW,@1.first_line, @1.first_column )}
    | expresion_numerica MULT expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.MULT,@1.first_line, @1.first_column )}
    | expresion_numerica DIV expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.DIV,@1.first_line, @1.first_column )}
    | expresion_numerica MOD expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.MOD,@1.first_line, @1.first_column )}
    | PARENTESIS_A expresion_logica PARENTESIS_C { $$ = $2;}
    | IDENTIFICADOR PARENTESIS_A largumentos PARENTESIS_C { $$ = new Llamada($1, $3, @1.first_line, @1.first_column);}
    | expresion_logica %prec TEST { $$ = $1; } // lo agrego de nuevo para ver si eso soluciona el problema 
    | dato {$$= $1;}
    | typeof { $$ = $1; } // probando si esto funciona  
    | incdec {$$ = $1;}
    | toupper { $$ = $1; }
    | tolower  { $$ = $1; }
    | roud { $$ = $1; }
    | length { $$ = $1; }
    | tocharArray { $$ = $1; }
    | push { $$ = $1; }
    | indexOf { $$ = $1; }
    | pop { $$ = $1; }
    | splice { $$ = $1; }
    | ternario{ $$ = $1; }
;

negacionDec
    : MENOS MENOS dato{ $$ = new IncDec($3,AritmeticOp.MENOS, @1.first_line, @1.first_column);}
   
;

incdec
    : MAS MAS expresion_numerica { $$ = new IncDec($3, AritmeticOp.MAS, @1.first_line, @1.first_column);}
    | expresion_numerica tipoDec{ $$ = new IncDec($1, $2, @1.first_line, @1.first_column);}
;

tipoDec
    : MAS MAS { $$ = AritmeticOp.MAS }
    | MENOS MENOS { $$ = AritmeticOp.MENOS}
;

dato
    : IDENTIFICADOR{$$ = new Literal($1, Type.IDENTIFICADOR, @1.first_line, @1.first_column);}
    | ENTERO {$$ = new Literal($1, Type.NUMBER, @1.first_line, @1.first_column);}
    | DECIMAL {$$ = new Literal($1, Type.NUMBER, @1.first_line, @1.first_column);}
    | CADENA {$$ = new Literal($1, Type.STRING, @1.first_line, @1.first_column);}
    | CHAR {$$ = new Literal($1, Type.CHAR, @1.first_line, @1.first_column);}
    | RTRUE {$$ = new Literal($1, Type.BOOLEAN, @1.first_line, @1.first_column);}
    | RFALSE { $$ = new Literal($1, Type.BOOLEAN, @1.first_line, @1.first_column);}
    // aqui pondre la asignacion desde un array. a = b[exp]
    | IDENTIFICADOR CORCHETE_A expresion_numerica CORCHETE_C { $$ = new Literal(new arrayLiteral($1, $3), Type.ARRAY, @1.first_line, @1.first_column);}
    | IDENTIFICADOR CORCHETE_A expresion_numerica CORCHETE_C CORCHETE_A expresion_numerica CORCHETE_C { }
;


tipo
    : RINT { $$ = Type.NUMBER;}
    | RDOUBLE{ $$ = Type.DECIMAL;}
    | RCHAR{ $$ = Type.CHAR;}
    | RBOOLEAN{ $$ = Type.BOOLEAN;}
    | RSTRING{ $$ = Type.STRING;}
;


