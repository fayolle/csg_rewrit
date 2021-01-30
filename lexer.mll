{
  open Lexing
  open Parser

  exception Eof

  let kwd_tbl =
    ["union", UNION;
     "intersection", INTER;
     "subtraction", SUB;
     "negation", NEGATION;
    ]

  let id_or_kwd =
    let h = Hashtbl.create 17 in
    List.iter (fun (s,t) -> Hashtbl.add h s t) kwd_tbl;
    fun s ->
    let s = String.lowercase s in
    try Hashtbl.find h s with _ -> IDENT s

}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let ident = letter (letter | digit | '_')*
let integer = ['0'-'9']+
let space = [' ' '\t']

rule token = parse
            space+      { token lexbuf }
          | ['\n' ]     { EOL }
          | ident as id { id_or_kwd id }
          | '['         { LBRACKET }
          | ']'         { RBRACKET }
          | ','         { COMMA }
          | eof         { raise Eof }
