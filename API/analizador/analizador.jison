%{
    // aqui se llama al arbol
    const Token = require('./Token').Token;
    const Error = require('./Error').Error;
    const {Literal} = require('../expresiones/Literal');
    const {Type} = require('../symbols/Type');
    const {Declaracion} = require('../instrucciones/Declaracion');


    // expresiones 
    const {Aritmetica, AritmeticOp} = require('../expresiones/Aritmetica');
    const {Relacional, RelacionalOp} = require('../expresiones/Relacional');
    const {Logica, LogicaOp} = require('../expresiones/Logica');
    
    
    
    
    let tokens = [];
    let errores = [];
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
"switch"                      { tokens.push(new Token('r_switch', yytext, yylloc.first_line, yylloc.first_column)); return 'RSWITCH';}
"case"                      { tokens.push(new Token('r_case', yytext, yylloc.first_line, yylloc.first_column)); return 'RCASE';}
"default"                      { tokens.push(new Token('r_default', yytext, yylloc.first_line, yylloc.first_column)); return 'RDEFAULT';}
"for"                       { tokens.push(new Token('r_for', yytext, yylloc.first_line, yylloc.first_column)); return 'RFOR';}
"while"                     { tokens.push(new Token('r_while', yytext, yylloc.first_line, yylloc.first_column)); return 'RWHILE';}
"true"                      { tokens.push(new Token('r_true', yytext, yylloc.first_line, yylloc.first_column)); return 'RTRUE';}
"false"                      { tokens.push(new Token('r_false', yytext, yylloc.first_line, yylloc.first_column)); return 'RFALSE';}
"do"                        { tokens.push(new Token('r_do', yytext, yylloc.first_line, yylloc.first_column)); return 'RDO';}
"continue"                      { tokens.push(new Token('r_continue', yytext, yylloc.first_line, yylloc.first_column)); return 'RCONTINUE';}
"void"                      { tokens.push(new Token('r_void', yytext, yylloc.first_line, yylloc.first_column)); return 'RVOID';}
"return"                      { tokens.push(new Token('r_return', yytext, yylloc.first_line, yylloc.first_column)); return 'RRETURN';}
"call"                      { tokens.push(new Token('r_call', yytext, yylloc.first_line, yylloc.first_column)); return 'RCALL';}
"break"                      { tokens.push(new Token('r_break', yytext, yylloc.first_line, yylloc.first_column)); return 'RBREAK';}
"Println"                   { tokens.push(new Token('r_println', yytext, yylloc.first_line, yylloc.first_column)); return 'RPRINTLN';}
"Print"                     { tokens.push(new Token('r_print', yytext, yylloc.first_line, yylloc.first_column)); return 'RPRINT';}
"Typeof"                      { tokens.push(new Token('r_typeof', yytext, yylloc.first_line, yylloc.first_column)); return 'RTYPEOF';}
//simbolos
";"					        { tokens.push(new Token('tk_;', yytext, yylloc.first_line, yylloc.first_column)); return 'PTCOMA';}
","					        { tokens.push(new Token('tk_,', yytext, yylloc.first_line, yylloc.first_column)); return 'COMA';}
"("					        { tokens.push(new Token('tk_(', yytext, yylloc.first_line, yylloc.first_column)); return 'PARENTESIS_A';}
")"					        { tokens.push(new Token('tk_)', yytext, yylloc.first_line, yylloc.first_column)); return 'PARENTESIS_C';}
"{"					        { tokens.push(new Token('tk_{', yytext, yylloc.first_line, yylloc.first_column)); return 'LLAVE_A';}
"}"					        { tokens.push(new Token('tk_}', yytext, yylloc.first_line, yylloc.first_column)); return 'LLAVE_C';}
":"					        { tokens.push(new Token('tk_:', yytext, yylloc.first_line, yylloc.first_column)); return 'DOSPTS';}

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


// Expresiones Regulares
([a-zA-Z])[a-zA-Z0-9_]*	    { tokens.push(new Token('tk_identificador', yytext, yylloc.first_line, yylloc.first_column)); return 'IDENTIFICADOR'; }
[0-9]+\b				    { tokens.push(new Token('tk_entero', yytext, yylloc.first_line, yylloc.first_column)); return 'ENTERO'; }
[0-9]+("."[0-9]+)?\b  	    { tokens.push(new Token('tk_decimal', yytext, yylloc.first_line, yylloc.first_column)); return 'DECIMAL'; }

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
%left 'MAS' 'MENOS'
%left 'MULT' 'DIV'
%left 'POW', 'MOD'
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
;

ini
    : linstrucciones {$$ = $1; }
;

linstrucciones
    : linstrucciones instruccion { $1.push($2); $$ = $1; }
    | instruccion { $$ = [$1]}
;

instruccion
    : declaracion { $$ = $1;}
    | asignacion { $$ = $1; }
    | if { $$ = $1; }
    | switch{ $$ = $1; } 
    | for{ $$ = $1; }
    | while { $$ = $1; }
    | do{ $$ = $1; }
    | return { $$ = $1; /*tener especial cuidado en como manejo esto*/}
    | func{ $$ = $1; }
    | bloque{ $$ = $1; }
    | call{ $$ = $1; }
    | print { $$ = $1; }
    | println { $$ = $1; }
    | typeof{ $$ = $1; }
    | RBREAK PTCOMA{ $$ = $1; /*estos deben ser casos especiales. Porque son instrucciones de una linea. */}
    | RCONTINUE PTCOMA{ $$ = $1; }
    | incdec PTCOMA{ $$ = $1; }
;


declaracion
    : tipo ldec asig PTCOMA { $$ = new Declaracion($2, $1, $3,false, @1.first_line, @1.first_column) }
    | RCONST tipo ldec asig PTCOMA { $$ = new Declaracion($3, $2, $4,true, @1.first_line, @1.first_column) }

;

ldec
    : ldec COMA IDENTIFICADOR { $1.push($3); $$=$1; }
    | IDENTIFICADOR { $$ = [$1];}
;

asig
    : %Empty
    | ASIG expresion_logica {$$ = $2;}
;

asignacion
    : IDENTIFICADOR ASIG expresion_logica PTCOMA
;

if
    : RIF PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A bodyBlock LLAVE_C
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C instruccion
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A bodyBlock LLAVE_C RELSE if
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A bodyBlock LLAVE_C RELSE LLAVE_A bodyBlock LLAVE_C

;

switch
    : RSWITCH PARENTESIS_A expresion_numerica PARENTESIS_C LLAVE_A lcase LLAVE_C
;

lcase
    : lcase RCASE dato DOSPTS bodyBlock
    | RDEFAULT DOSPTS bodyBlock
    | RCASE dato DOSPTS bodyBlock
;


for
    : RFOR PARENTESIS_A for_declaracion expresion_logica PTCOMA for_incremento PARENTESIS_C LLAVE_A bodyBlock LLAVE_C
;

for_declaracion
    : declaracion
    | asignacion
;

for_incremento
    : expresion_numerica
    | asignacion
;

while
    : RWHILE PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A bodyBlock LLAVE_C
;

do
    : RDO LLAVE_A bodyBlock LLAVE_C RWHILE PARENTESIS_A expresion_logica PARENTESIS_C PTCOMA

;

return
    : %Empty
    | RRETURN expresion_numerica PTCOMA

;

func
    : tipo IDENTIFICADOR PARENTESIS_A lparametros PARENTESIS_C LLAVE_A bodyBlock LLAVE_C
    | RVOID IDENTIFICADOR PARENTESIS_A lparametros PARENTESIS_C LLAVE_A bodyBlock LLAVE_C
;

lparametros
    : %Empty
    | lparametros COMA tipo IDENTIFICADOR
    | tipo IDENTIFICADOR
;

bloque
    : LLAVE_A bodyBlock LLAVE_C
;

call
    : RCALL IDENTIFICADOR PARENTESIS_A largumentos PARENTESIS_C PTCOMA
;

largumentos
    : largumentos COMA expresion_numerica
    | expresion_numerica
;

print
    : RPRINT PARENTESIS_A expresion_numerica PARENTESIS_C PTCOMA
;

println
    : RPRINTLN PARENTESIS_A expresion_numerica PARENTESIS_C PTCOMA
;

typeof
    : RTYPEOF PARENTESIS_A dato PARENTESIS_C PTCOMA
;


bodyBlock
    : linstrucciones
    | %Empty
;

expresion_logica
    : expresin_relacional AND expresin_relacional {$$ = new Logica($1, $3, LogicaOp.and,@1.first_line, @1.first_column);}
    | expresin_relacional OR expresin_relacional{$$ = new Logica($1, $3, LogicaOp.or,@1.first_line, @1.first_column);}
    | expresin_relacional XOR expresin_relacional{$$ = new Logica($1, $3, LogicaOp.xor,@1.first_line, @1.first_column);}
    | NOT expresin_relacional %prec UMENOS{$$ = new Logica(null, $3, LogicaOp.not,@1.first_line, @1.first_column);}
    | expresin_relacional {$$ = $1;}
;


expresin_relacional
    : expresion_numerica MAYOR expresion_numerica {$$ = new Relacional($1, $3, RelacionalOp.mayor, @1.first_line, @1.first_column);}
    | expresion_numerica MENOR expresion_numerica{$$ = new Relacional($1, $3, RelacionalOp.menor, @1.first_line, @1.first_column);}
    | expresion_numerica MAYORI expresion_numerica{$$ = new Relacional($1, $3, RelacionalOp.mayori, @1.first_line, @1.first_column);}
    | expresion_numerica MENORI expresion_numerica{$$ = new Relacional($1, $3, RelacionalOp.menori, @1.first_line, @1.first_column);}
    | expresion_numerica IGUAL expresion_numerica{$$ = new Relacional($1, $3, RelacionalOp.igual, @1.first_line, @1.first_column);}
    | expresion_numerica DIF expresion_numerica{$$ = new Relacional($1, $3, RelacionalOp.dif, @1.first_line, @1.first_column);}
    | expresion_numerica {$$ = $1;}
;


expresion_numerica
    : MENOS expresion_numerica %prec UMENOS {$$ = new Aritmetica($2, -1, AritmeticOp.UMENOS, @1.first_line, @1.first_column)}
    | expresion_numerica MAS expresion_numerica { $$ = new Aritmetica($1, $3, AritmeticOp.MAS,@1.first_line, @1.first_column )}
    | expresion_numerica MENOS expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.MENOS,@1.first_line, @1.first_column )}
    | expresion_numerica MULT MULT expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.POW,@1.first_line, @1.first_column )}
    | expresion_numerica MULT expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.MULT,@1.first_line, @1.first_column )}
    | expresion_numerica DIV expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.DIV,@1.first_line, @1.first_column )}
    | expresion_numerica MOD expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.MOD,@1.first_line, @1.first_column )}
    | PARENTESIS_A expresion_logica PARENTESIS_C
    | incdec {$$ = $1;}
    | expresion_logica { $$ = $1;}
    | IDENTIFICADOR PARENTESIS_A largumentos PARENTESIS_C
    | dato {$$= $1;}
;



incdec
    : MAS MAS expresion_numerica { $$ = new Aritmetica($3, 1, AritmeticOp.MAS,@1.first_line, @1.first_column )}
    | MENOS MENOS expresion_numerica { $$ = new Aritmetica($3, 1, AritmeticOp.MENOS,@1.first_line, @1.first_column )}
    | expresion_numerica MAS MAS{ $$ = new Aritmetica($1, 1, AritmeticOp.MAS,@1.first_line, @1.first_column )}
    | expresion_numerica MENOS MENOS{ $$ = new Aritmetica($1, 1, AritmeticOp.MENOS,@1.first_line, @1.first_column )}
;

dato
    : IDENTIFICADOR{$$ = new Literal($1, Type.IDENTIFICADOR, @1.first_line, @1.first_column);}
    | ENTERO{$$ = new Literal($1, Type.NUMBER, @1.first_line, @1.first_column);}
    | DECIMAL{$$ = new Literal($1, Type.DECIMAL, @1.first_line, @1.first_column);}
    | CADENA {$$ = new Literal($1, Type.STRING, @1.first_line, @1.first_column);}
    | CHAR {$$ = new Literal($1, Type.CHAR, @1.first_line, @1.first_column);}
    | RTRUE {$$ = new Literal($1, Type.BOOLEAN, @1.first_line, @1.first_column);}
    | RFALSE { $$ = new Literal($1, Type.BOOLEAN, @1.first_line, @1.first_column);}
;


tipo
    : RINT { $$ = Type.NUMBER;}
    | RDOUBLE{ $$ = Type.DECIMAL;}
    | RCHAR{ $$ = Type.CHAR;}
    | RBOOLEAN{ $$ = Type.BOOLEAN;}
    | RSTRING{ $$ = Type.STRING;}
;


