"""
DedekindGroups module

Core verification functions and group construction utilities for working with
Dedekind groups (groups where all subgroups are normal) using GAP.jl.

This module provides:
- Classification functions: is_dedekind, is_abelian, is_hamiltonian
- Group construction: construct_Q8, construct_cyclic, construct_direct_product
- Property queries: get_subgroups, get_center, get_commutator_subgroup, etc.
"""
module DedekindGroups

using GAP

export is_dedekind, is_abelian, is_hamiltonian
export construct_Q8, construct_cyclic, construct_direct_product
export get_subgroups, get_center, get_commutator_subgroup
export get_order, get_structure_description

# Classification functions.

"""
    is_dedekind(G) -> Bool

Check if a group G is a Dedekind group (all subgroups are normal).
"""
function is_dedekind(G)
    subgroups = GAP.Globals.AllSubgroups(G)
    for H in subgroups
        if !GAP.Globals.IsNormal(G, H)
            return false
        end
    end
    return true
end

"""
    is_abelian(G) -> Bool

Check if a group G is abelian.
"""
function is_abelian(G)
    return GAP.Globals.IsAbelian(G)
end

"""
    is_hamiltonian(G) -> Bool

Check if a group G is Hamiltonian (Dedekind but not abelian).
"""
function is_hamiltonian(G)
    return is_dedekind(G) && !is_abelian(G)
end

# Group construction functions.

"""
    construct_Q8() -> GAP.GapObj

Construct the quaternion group Q₈.
"""
function construct_Q8()
    return GAP.Globals.QuaternionGroup(8)
end

"""
    construct_cyclic(n) -> GAP.GapObj

Construct the cyclic group Z/nZ.
"""
function construct_cyclic(n)
    return GAP.Globals.CyclicGroup(n)
end

"""
    construct_direct_product(groups...) -> GAP.GapObj

Construct the direct product of given groups.
"""
function construct_direct_product(groups...)
    gap_list = GapObj(collect(groups))
    return GAP.Globals.DirectProduct(gap_list)
end

# Group property query functions.

"""
    get_subgroups(G) -> Vector

Get all subgroups of G.
"""
function get_subgroups(G)
    return GAP.gap_to_julia(GAP.Globals.AllSubgroups(G))
end

"""
    get_center(G) -> GAP.GapObj

Get the center of group G.
"""
function get_center(G)
    return GAP.Globals.Center(G)
end

"""
    get_commutator_subgroup(G) -> GAP.GapObj

Get the commutator subgroup (derived subgroup) of G.
"""
function get_commutator_subgroup(G)
    return GAP.Globals.DerivedSubgroup(G)
end

"""
    get_order(G) -> Int

Get the order (number of elements) of group G.
"""
function get_order(G)
    return GAP.Globals.Order(G)
end

"""
    get_structure_description(G) -> String

Get a human-readable description of the group structure.
"""
function get_structure_description(G)
    return GAP.gap_to_julia(String, GAP.Globals.StructureDescription(G))
end

end # module DedekindGroups
