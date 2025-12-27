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
export get_nilpotency_class, get_derived_length, get_exponent, get_center_index

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

"""
    get_nilpotency_class(G) -> Int

Get the nilpotency class of group G. Returns 0 if the group is not nilpotent.
"""
function get_nilpotency_class(G)
    return GAP.Globals.NilpotencyClassOfGroup(G)
end

"""
    get_derived_length(G) -> Int

Get the derived length of group G (length of the derived series).
Returns 0 if the group is not solvable.
"""
function get_derived_length(G)
    return GAP.Globals.DerivedLength(G)
end

"""
    get_exponent(G) -> Int

Get the exponent of group G (smallest positive integer n such that g^n = e for all g ∈ G).
Returns 0 if no such finite exponent exists.
"""
function get_exponent(G)
    return GAP.Globals.Exponent(G)
end

"""
    get_center_index(G) -> Int

Get the index [G:Z(G)] of the center in group G.
"""
function get_center_index(G)
    return get_order(G) ÷ get_order(get_center(G))
end

end # module DedekindGroups
