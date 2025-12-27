"""
DedekindPrinting module

Display and output functions for analyzing and presenting information about
Dedekind groups.

This module provides:
- analyze_group: Comprehensive group analysis with formatted text output
- Future: LaTeX table generation functions
- Future: Formatted report generation

Note: This module expects DedekindGroups to be already loaded in the parent
scope.
"""
module DedekindPrinting

using GAP

export analyze_group

"""
    analyze_group(G, name::String)

Perform a comprehensive analysis of group G and print the results.

This function displays:
- Basic properties (order, structure description)
- Classification (abelian, Dedekind, Hamiltonian)
- Subgroup information (count, normality)
- Center properties
- Commutator subgroup properties
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

    println("\n" * "="^70)
end

end # module DedekindPrinting
