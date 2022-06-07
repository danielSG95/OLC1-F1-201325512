%{
    // aqui se llama al arbol
    const Token = require('./Token').Token;
    const Error = require('./Error').Error;


    let tokens = [];
    let errores = [];
%}

%lex


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
[0-9]+("."[0-9]+)?\b  	    { tokens.push(new Token('tk_decimal', yytext, yylloc.first_line, yylloc.first_column)); return 'DECIMAL'; }
[0-9]+\b				    { tokens.push(new Token('tk_entero', yytext, yylloc.first_line, yylloc.first_column)); return 'ENTERO'; }

\"[^\"]*\"				    {  /*yytext = yytext.substr(1, yyleng-2);*/ tokens.push(new Token('tk_cadena', yytext, yylloc.first_line, yylloc.first_column)); 
                                return 'CADENA';                           
                            }
\'[a-zA-Z]\'			    { yytext = yytext.substr(1, yyleng-2); tokens.push(new Token('tk_char', yytext, yylloc.first_line, yylloc.first_column)); 
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
        return {tk : tokens, err: errores}
    }
;

ini
    : linstrucciones
;

linstrucciones
    : linstrucciones instruccion
    | instruccion
;

instruccion
    : declaracion
    | asignacion 
    | if
    | switch 
    | for
    | while 
    | do
    | return 
    | func
    | bloque
    | call
    | print 
    | println 
    | typeof
    | RBREAK
    | RCONTINUE
;


declaracion
    : tipo ldec PTCOMA
    | RCONST tipo ldec PTCOMA

;

ldec
    : ldec COMA IDENTIFICADOR asig
    | IDENTIFICADOR asig
;

asig
    : %Empty
    | ASIG expresion_logica
;

asignacion
    : IDENTIFICADOR ASIG expresion_logica PTCOMA
;

if
    : RIF PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A linstrucciones LLAVE_C
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C instruccion
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A linstrucciones LLAVE_C RELSE if
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A linstrucciones LLAVE_C RELSE LLAVE_A linstrucciones LLAVE_C

;

switch
    : RSWITCH PARENTESIS_A expresion_numerica PARENTESIS_C LLAVE_A lcase LLAVE_C
;

lcase
    : lcase RCASE dato DOSPTS linstrucciones
    | RDEFAULT DOSPTS linstrucciones
    | RCASE dato DOSPTS linstrucciones
;


for
    : RFOR PARENTESIS_A for_declaracion expresion_logica PTCOMA for_incremento PARENTESIS_C LLAVE_A linstrucciones LLAVE_C
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
    : RWHILE PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A linstrucciones LLAVE_C
;

do
    : RDO LLAVE_A linstrucciones LLAVE_C RWHILE PARENTESIS_A expresion_logica PARENTESIS_C PTCOMA

;

return
    : %Empty
    | RRETURN expresion_numerica PTCOMA

;

func
    : tipo IDENTIFICADOR PARENTESIS_A lparametros PARENTESIS_C LLAVE_A linstrucciones LLAVE_C
    | RVOID IDENTIFICADOR PARENTESIS_A lparametros PARENTESIS_C LLAVE_A linstrucciones LLAVE_C
;

lparametros
    : %Empty
    | lparametros COMA tipo IDENTIFICADOR
    | tipo IDENTIFICADOR
;

bloque
    : LLAVE_A linstrucciones LLAVE_C
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

expresion_logica
    : expresin_relacional AND expresin_relacional
    | expresin_relacional OR expresin_relacional
    | expresin_relacional XOR expresin_relacional
    | NOT expresin_relacional
    | expresin_relacional
;


expresin_relacional
    : expresion_numerica MAYOR expresion_numerica
    | expresion_numerica MENOR expresion_numerica
    | expresion_numerica MAYORI expresion_numerica
    | expresion_numerica MENORI expresion_numerica
    | expresion_numerica IGUAL expresion_numerica
    | expresion_numerica DIF expresion_numerica
    | expresion_numerica
;


expresion_numerica
    : MENOS expresion_numerica %prec UMENOS
    | MAS MAS expresion_numerica
    | MENOS MENOS expresion_numerica
    | expresion_numerica MAS MAS
    | expresion_numerica MENOS MENOS
    | expresion_numerica MAS expresion_numerica
    | expresion_numerica MENOS expresion_numerica
    | expresion_numerica MULT MULT expresion_numerica
    | expresion_numerica MULT expresion_numerica
    | expresion_numerica DIV expresion_numerica
    | expresion_numerica MOD expresion_numerica
    | PARENTESIS_A expresion_numerica PARENTESIS_C
    | IDENTIFICADOR PARENTESIS_A largumentos PARENTESIS_C
    | dato
;


dato
    : IDENTIFICADOR 
    | ENTERO
    | DECIMAL
    | CADENA
    | CHAR
    | RTRUE
    | RFALSE
;


tipo
    : RINT
    | RDOUBLE
    | RCHAR
    | RBOOLEAN
    | RSTRING
;


