"""
This script verifies the four Hamiltonian group examples presented in the
LaTeX document, under the classification theorem section.

Examples verified:
1. Q₈ (order 8)
2. Q₈ x Z/2Z (order 16)
3. Q₈ x Z/3Z (order 24)
4. Q₈ x (Z/2Z)² x Z/3Z (order 96)

All examples should be Hamiltonian (Dedekind but not abelian).
"""

include(joinpath(@__DIR__, "..", "DedekindGroups.jl"))
include(joinpath(@__DIR__, "..", "DedekindPrinting.jl"))

using GAP
using .DedekindGroups
using .DedekindPrinting

function main()
    # Ensure tables directory exists.
    tables_dir = joinpath(@__DIR__, "..", "..", "tex", "tables")
    mkpath(tables_dir)

    # Example 1: Q₈.
    Q8 = construct_Q8()
    analyze_group(Q8, "Q₈ (Quaternion Group)")
    latex_q8 = generate_latex_report(Q8, "\$Q_8\$", label="q8")
    save_latex_report(latex_q8, joinpath(tables_dir, "q8.tex"))

    # Example 2: Q₈ × Z/2Z.
    Z2 = construct_cyclic(2)
    Q8_Z2 = construct_direct_product(Q8, Z2)
    analyze_group(Q8_Z2, "Q₈ × Z/2Z")
    latex_q8_z2 = generate_latex_report(Q8_Z2, "\$Q_8 \\times \\mathbb{Z}/2\\mathbb{Z}\$", label="q8z2")
    save_latex_report(latex_q8_z2, joinpath(tables_dir, "q8_z2.tex"))

    # Example 3: Q₈ × Z/3Z.
    Z3 = construct_cyclic(3)
    Q8_Z3 = construct_direct_product(Q8, Z3)
    analyze_group(Q8_Z3, "Q₈ × Z/3Z")
    latex_q8_z3 = generate_latex_report(Q8_Z3, "\$Q_8 \\times \\mathbb{Z}/3\\mathbb{Z}\$", label="q8z3")
    save_latex_report(latex_q8_z3, joinpath(tables_dir, "q8_z3.tex"))

    # Example 4: Q₈ × (Z/2Z)² × Z/3Z.
    Z2_2 = construct_direct_product(Z2, construct_cyclic(2))
    Q8_Z2_2_Z3 = construct_direct_product(Q8, Z2_2, Z3)
    analyze_group(Q8_Z2_2_Z3, "Q₈ × (Z/2Z)² × Z/3Z")
    latex_q8_z2z2_z3 = generate_latex_report(Q8_Z2_2_Z3, "\$Q_8 \\times (\\mathbb{Z}/2\\mathbb{Z})^2 \\times \\mathbb{Z}/3\\mathbb{Z}\$", label="q8z2z2z3")
    save_latex_report(latex_q8_z2z2_z3, joinpath(tables_dir, "q8_z2z2_z3.tex"))

    println("\n" * "="^70)
    println("All LaTeX tables generated successfully in $tables_dir")
    println("="^70)
end

# Run the verification.
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
