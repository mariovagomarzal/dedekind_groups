[private]
default:
    @just --list --unsorted

tex-dir := "tex"
tables-dir := "tex/tables"

# Generate LaTeX tables from computational experiments
generate-tables:
    julia --project=. src/experiments/baer_dedekind.jl

# Compile the LaTeX document
tex:
    cd {{tex-dir}} && latexmk main.tex

# Build everything: generate tables then compile document
build: generate-tables tex

# Watch mode for continuous LaTeX compilation
watch:
    cd {{tex-dir}} && latexmk -pvc main.tex

# Clean LaTeX auxiliary files
clean-tex:
    cd {{tex-dir}} && latexmk -C main.tex

# Clean everything including generated tables
clean-all: clean-tex
    rm -rf {{tables-dir}}

# Run a specific experiment by name
experiment NAME:
    julia --project=. src/experiments/{{NAME}}.jl
