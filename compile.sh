#!/usr/bin/sh

ocamllex lexer.mll
ocamlyacc parser.mly
ocamlc -c parser.mli
ocamlc -c lexer.ml
ocamlc -c parser.ml
ocamlc -c rewrite.ml
ocamlc -o rewrite lexer.cmo parser.cmo rewrite.cmo

