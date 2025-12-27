"""
DedekindPrinting module

Display and output functions for analyzing and presenting information about
Dedekind groups.

This module provides:
- analyze_group: Comprehensive group analysis with formatted text output
- generate_latex_report: Generate LaTeX tables for group analysis (Spanish)
- save_latex_report: Save LaTeX content to files

Note: This module expects DedekindGroups to be already loaded in the parent
scope.
"""
module DedekindPrinting

using GAP

export analyze_group, generate_latex_report, save_latex_report

"""
    analyze_group(G, name::String)

Perform a comprehensive analysis of group G and print the results.

This function displays:
- Basic properties (order, structure description)
- Classification (abelian, Dedekind, Hamiltonian)
- Subgroup information (count, normality)
- Center properties
- Commutator subgroup properties
- Advanced properties (nilpotency class, derived length, exponent, center index)
"""
function analyze_group(G, name::String)
    # Import functions from parent module scope.
    get_order = Main.DedekindGroups.get_order
    get_structure_description = Main.DedekindGroups.get_structure_description
    is_abelian = Main.DedekindGroups.is_abelian
    is_dedekind = Main.DedekindGroups.is_dedekind
    is_hamiltonian = Main.DedekindGroups.is_hamiltonian
    get_subgroups = Main.DedekindGroups.get_subgroups
    get_center = Main.DedekindGroups.get_center
    get_commutator_subgroup = Main.DedekindGroups.get_commutator_subgroup
    get_nilpotency_class = Main.DedekindGroups.get_nilpotency_class
    get_derived_length = Main.DedekindGroups.get_derived_length
    get_exponent = Main.DedekindGroups.get_exponent
    get_center_index = Main.DedekindGroups.get_center_index

    println("\n" * "="^70)
    println("Analysis of $name")
    println("="^70)

    # Basic properties.
    order = get_order(G)
    structure = get_structure_description(G)
    println("\nBasic Properties:")
    println("  Order: $order")
    println("  Structure: $structure")

    # Classification.
    is_ab = is_abelian(G)
    is_ded = is_dedekind(G)
    is_ham = is_hamiltonian(G)

    println("\nClassification:")
    println("  Abelian: $is_ab")
    println("  Dedekind: $is_ded")
    println("  Hamiltonian: $is_ham")

    # Subgroups.
    subgroups = get_subgroups(G)
    num_subgroups = length(subgroups)
    println("\nSubgroup Information:")
    println("  Number of subgroups: $num_subgroups")

    # Check normality of all subgroups.
    all_normal = true
    normal_count = 0
    for H in subgroups
        if GAP.Globals.IsNormal(G, H)
            normal_count += 1
        else
            all_normal = false
        end
    end
    println("  Normal subgroups: $normal_count / $num_subgroups")
    println("  All subgroups normal: $all_normal")

    # Center.
    center = get_center(G)
    center_order = get_order(center)
    println("\nCenter:")
    println("  Order: $center_order")
    println("  Structure: $(get_structure_description(center))")

    # Commutator subgroup.
    commutator = get_commutator_subgroup(G)
    commutator_order = get_order(commutator)
    println("\nCommutator Subgroup:")
    println("  Order: $commutator_order")
    println("  Structure: $(get_structure_description(commutator))")

    # Additional properties.
    nilpotency_class = get_nilpotency_class(G)
    derived_length = get_derived_length(G)
    exponent = get_exponent(G)
    center_index = get_center_index(G)

    println("\nAdvanced Properties:")
    println("  Nilpotency class: $nilpotency_class")
    println("  Derived length: $derived_length")
    println("  Exponent: $exponent")
    println("  Center index [G:Z(G)]: $center_index")

    println("\n" * "="^70)
end

"""
    generate_latex_report(G, name::String; label::String="")

Generate a LaTeX table report for group G with Spanish labels.

This function creates a standalone LaTeX table using the booktabs package,
suitable for inclusion in a LaTeX document via \\input{}.

# Arguments
- `G`: The group to analyze (GAP group object)
- `name::String`: The display name for the group (e.g., "Q₈")
- `label::String=""`: Optional custom label for cross-referencing. If empty,
  a sanitized version of the name will be auto-generated.

# Returns
- `String`: Complete LaTeX code for a table environment

# Example
```julia
G = construct_Q8()
latex = generate_latex_report(G, "Q₈", label="q8")
save_latex_report(latex, "tex/q8_analysis.tex")
```
"""
function generate_latex_report(G, name::String; label::String="")
    # Import functions from parent module scope.
    get_order = Main.DedekindGroups.get_order
    get_structure_description = Main.DedekindGroups.get_structure_description
    is_abelian = Main.DedekindGroups.is_abelian
    is_dedekind = Main.DedekindGroups.is_dedekind
    is_hamiltonian = Main.DedekindGroups.is_hamiltonian
    get_subgroups = Main.DedekindGroups.get_subgroups
    get_center = Main.DedekindGroups.get_center
    get_commutator_subgroup = Main.DedekindGroups.get_commutator_subgroup
    get_nilpotency_class = Main.DedekindGroups.get_nilpotency_class
    get_derived_length = Main.DedekindGroups.get_derived_length
    get_exponent = Main.DedekindGroups.get_exponent
    get_center_index = Main.DedekindGroups.get_center_index

    # Gather all group properties.
    order = get_order(G)
    structure = get_structure_description(G)
    is_ab = is_abelian(G)
    is_ded = is_dedekind(G)
    is_ham = is_hamiltonian(G)

    subgroups = get_subgroups(G)
    num_subgroups = length(subgroups)

    normal_count = 0
    for H in subgroups
        if GAP.Globals.IsNormal(G, H)
            normal_count += 1
        end
    end

    center = get_center(G)
    center_order = get_order(center)
    center_structure = get_structure_description(center)

    commutator = get_commutator_subgroup(G)
    commutator_order = get_order(commutator)
    commutator_structure = get_structure_description(commutator)

    # Additional properties.
    nilpotency_class = get_nilpotency_class(G)
    derived_length = get_derived_length(G)
    exponent = get_exponent(G)
    center_index = get_center_index(G)

    # Auto-generate label if not provided.
    if isempty(label)
        # Sanitize name: remove special characters, convert to lowercase
        label = replace(lowercase(name), r"[^a-z0-9]" => "")
    end

    # Convert boolean values to Spanish.
    to_spanish_bool(b::Bool) = b ? "Sí" : "No"

    # Build the LaTeX table.
    latex_lines = String[]
    push!(latex_lines, "% Auto-generated by DedekindPrinting.jl")
    push!(latex_lines, "\\begin{table}[p]")
    push!(latex_lines, "\\centering")
    push!(latex_lines, "\\caption{Análisis de $name}")
    push!(latex_lines, "\\label{tab:$label}")
    push!(latex_lines, "\\begin{tabular}{ll}")
    push!(latex_lines, "\\toprule")
    push!(latex_lines, "Propiedad & Valor \\\\")
    push!(latex_lines, "\\midrule")
    push!(latex_lines, "Orden & $order \\\\")
    push!(latex_lines, "Estructura & $structure \\\\")
    push!(latex_lines, "Abeliano & $(to_spanish_bool(is_ab)) \\\\")
    push!(latex_lines, "Dedekind & $(to_spanish_bool(is_ded)) \\\\")
    push!(latex_lines, "Hamiltoniano & $(to_spanish_bool(is_ham)) \\\\")
    push!(latex_lines, "Número de subgrupos & $num_subgroups \\\\")
    push!(latex_lines, "Subgrupos normales & $normal_count / $num_subgroups \\\\")
    push!(latex_lines, "Centro - Orden & $center_order \\\\")
    push!(latex_lines, "Centro - Estructura & $center_structure \\\\")
    push!(latex_lines, "Subgrupo conmutador - Orden & $commutator_order \\\\")
    push!(latex_lines, "Subgrupo conmutador - Estructura & $commutator_structure \\\\")
    push!(latex_lines, "Clase de nilpotencia & $nilpotency_class \\\\")
    push!(latex_lines, "Longitud derivada & $derived_length \\\\")
    push!(latex_lines, "Exponente & $exponent \\\\")
    push!(latex_lines, "Índice del centro & $center_index \\\\")
    push!(latex_lines, "\\bottomrule")
    push!(latex_lines, "\\end{tabular}")
    push!(latex_lines, "\\end{table}")

    return join(latex_lines, "\n")
end

"""
    save_latex_report(content::String, filepath::String)

Save LaTeX content to a file at the specified path.

This function writes the provided LaTeX content to a file, creating parent
directories if they don't exist. The file is written using UTF-8 encoding.

# Arguments
- `content::String`: The LaTeX content to save
- `filepath::String`: The path where the file should be saved

# Example
```julia
latex = generate_latex_report(G, "Q₈")
save_latex_report(latex, "tex/q8_analysis.tex")
```
"""
function save_latex_report(content::String, filepath::String)
    # Create parent directories if they don't exist.
    dir = dirname(filepath)
    if !isempty(dir) && !isdir(dir)
        mkpath(dir)
    end

    # Write the content to the file.
    open(filepath, "w") do io
        write(io, content)
    end

    println("LaTeX report saved to: $filepath")
end

end # module DedekindPrinting
