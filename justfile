[private]
default:
    @just --list --unsorted

tex-dir := "tex"

tex:
    cd {{tex-dir}} && latexmk main.tex

clean-tex:
    cd {{tex-dir}} && latexmk -C main.tex
