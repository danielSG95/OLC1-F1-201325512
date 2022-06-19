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
    const {Incremento} = require('../instrucciones/Incremento');
    const {Decremento} = require('../instrucciones/Decremento'); 
    const {While} = require('../instrucciones/While');
    const {Return} = require('../instrucciones/Return');
    const {Break} = require('../instrucciones/Break');
    const {Continue} = require('../instrucciones/Continue');
    const {If} = require('../instrucciones/If');
    const {DoWhile} = require('../instrucciones/DoWhile');
    const {For} = require('../instrucciones/For');
    const {Funcion} = require('../instrucciones/Funcion');
    const {Llamada} = require('../instrucciones/Llamada');
    const {Switch, Case } = require('../instrucciones/Switch');
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
        console.log(e);
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
    : declaracion { $$ = $1;} // listo
    | asignacion { $$ = $1; } // listo
    | if { $$ = $1; } // listo 
    | switch{ $$ = $1; } 
    | for{ $$ = $1; } // listo
    | while { $$ = $1; } // listo
    | do{ $$ = $1; } // listo 
    | return { $$ = $1; } // listo 
    | func{ $$ = $1; } // listo 
    | bloque{ $$ = $1; } // listo 
    | call{ $$ = $1; } // listo
    | print { $$ = $1; } // listo
    | println { $$ = $1; } // listo 
    | typeof PTCOMA { $$ = $1; } // listo 
    | RBREAK PTCOMA{ $$ = new Break(@1.first_line, @1.first_column); } // listo 
    | RCONTINUE PTCOMA{ $$ = new Continue(@1.first_line, @1.first_column); } // listo 
    | incdec PTCOMA{ $$ = $1; } // listo 
    | error PTCOMA { 
        var e = new Error(err_lexema, this._$.first_line, this._$.first_column, esperados, "Error sintactico");
        console.log(e);
    }
    | error LLAVE_C {
        //this._$.first_line, this._$.first_column
        var e = new Error(err_lexema, this._$.first_line, this._$.first_column, esperados, "Error sintactico");
        console.log(e);
    }
    
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
    : IDENTIFICADOR ASIG expresion_logica PTCOMA { $$ = new Asignacion($1, $3, @1.first_line, @1.first_column);}
;

if
    : RIF PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A bodyBlock LLAVE_C { $$ = new If($3, $6, null, null, @1.first_line, @1.first_column);}
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A bodyBlock LLAVE_C RELSE if { $$ = new If($3, $6, null, $9, @1.first_line, @1.first_column);}
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C LLAVE_A bodyBlock LLAVE_C RELSE LLAVE_A bodyBlock LLAVE_C { $$ = new If($3, $6, $10, null, @1.first_line, @1.first_column);}

    | RIF PARENTESIS_A expresion_logica PARENTESIS_C instruccion { $$ = new If($3, [$5], null, null, @1.first_line, @1.first_column);}
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C instruccion RELSE if { $$ = new If($3, [$5], null, $7, @1.first_line, @1.first_column);}
    | RIF PARENTESIS_A expresion_logica PARENTESIS_C instruccion RELSE instruccion { $$ = new If($3, [$5], [$6], null, @1.first_line, @1.first_column);}
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
    : RFOR PARENTESIS_A for_declaracion expresion_logica PTCOMA for_incremento PARENTESIS_C LLAVE_A bodyBlock LLAVE_C {
        $$ = new For($3, $4, $6, $9, @1.first_line, @1.first_column);
        console.log('reconociendo un for')
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
    : %Empty
    | lparametros COMA tipo IDENTIFICADOR { $1.push({value: $4, type: $3}); $$ = $1;}
    | tipo IDENTIFICADOR { $$ = [{value: $2, type: $1}]}
;

bloque
    : LLAVE_A bodyBlock LLAVE_C { $$ = new Bloque($2, @1.first_line, @1.first_column); }
;

call
    : RCALL IDENTIFICADOR PARENTESIS_A largumentos PARENTESIS_C PTCOMA { $$ = new Llamada($2, $4, @1.first_line, @1.first_column); }
;

largumentos
    : largumentos COMA expresion_numerica { $1.push($3); $$ = $1;}
    | expresion_numerica { $$ = [$1]}
    | %Empty { $$ = []}
;

print
    : RPRINT PARENTESIS_A expresion_logica PARENTESIS_C PTCOMA { $$ = new Print($3, @1.first_line, @1.first_column);}
;

println
    : RPRINTLN PARENTESIS_A expresion_logica PARENTESIS_C PTCOMA { $$ = new Println($3, @1.first_line, @1.first_column);}
;

typeof
    : RTYPEOF PARENTESIS_A expresion_logica PARENTESIS_C { $$ = new Typeof($3, @1.first_line, @1.first_column); }
;


bodyBlock
    : linstrucciones { $$ = $1;}
    | %Empty
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
    | expresion_numerica MAS expresion_numerica { $$ = new Aritmetica($1, $3, AritmeticOp.MAS,@1.first_line, @1.first_column )}
    | expresion_numerica MENOS expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.MENOS,@1.first_line, @1.first_column )}
    | expresion_numerica MULT MULT expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.POW,@1.first_line, @1.first_column )}
    | expresion_numerica MULT expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.MULT,@1.first_line, @1.first_column )}
    | expresion_numerica DIV expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.DIV,@1.first_line, @1.first_column )}
    | expresion_numerica MOD expresion_numerica{ $$ = new Aritmetica($1, $3, AritmeticOp.MOD,@1.first_line, @1.first_column )}
    | PARENTESIS_A expresion_logica PARENTESIS_C { $$ = $2;}
    | incdec {$$ = $1;}
    | expresion_logica { $$ = $1;}
    | IDENTIFICADOR PARENTESIS_A largumentos PARENTESIS_C { $$ = new Llamada($1, $3, @1.first_line, @1.first_column);}
    | dato {$$= $1;}
    | typeof { $$ = $1; } // probando si esto funciona  
;



incdec
    : MAS MAS expresion_numerica { $$ = new Incremento($3, @1.first_line, @1.first_column);}
    | MENOS MENOS expresion_numerica { $$ = new Decremento($3, @1.first_line, @1.first_column);}
    | expresion_numerica MAS MAS{ $$ = new Incremento($1, @1.first_line, @1.first_column);}
    | expresion_numerica MENOS MENOS{ $$ = new Decremento($1, @1.first_line, @1.first_column);}
;

dato
    : IDENTIFICADOR{$$ = new Literal($1, Type.IDENTIFICADOR, @1.first_line, @1.first_column);}
    | ENTERO {$$ = new Literal($1, Type.NUMBER, @1.first_line, @1.first_column);}
    | DECIMAL {$$ = new Literal($1, Type.NUMBER, @1.first_line, @1.first_column);}
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


