%token <string> IDENT
%token SUB INTER UNION NEGATION
%token LBRACKET RBRACKET
%token COMMA
%token EOL
%left UNION
%left INTER SUB
%nonassoc NEGATION
%start main

%type <string> main
%%

main:
  expr EOL  { $1 }
  ;

expr:
  IDENT  { $1 }
| UNION LBRACKET expr COMMA expr RBRACKET { String.concat "" ["union["; $3; ","; $5; "]"] }
| INTER LBRACKET expr COMMA NEGATION LBRACKET expr RBRACKET RBRACKET { String.concat "" ["subtraction["; $3; ","; $7; "]"] }
| INTER NEGATION LBRACKET expr COMMA LBRACKET expr RBRACKET RBRACKET { String.concat "" ["subtraction["; $7; ","; $3; "]"] }
| INTER LBRACKET expr COMMA expr RBRACKET { String.concat "" ["intersection["; $3; ","; $5; "]"] }
| SUB LBRACKET expr COMMA expr RBRACKET { String.concat "" ["subtraction["; $3; ","; $5; "]"] }
| NEGATION LBRACKET expr RBRACKET { String.concat "" ["negation["; $3; "]"] }
;

