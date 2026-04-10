/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (S06 — Union)
-- @importance: critical
-- @proof_status: axiom (typeclass field; instances decide whether it is axiom or theorem)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.Union

/-- S06 — Union (big union / set-indexed union).
    For any set s, there exists ⋃ s whose members are exactly the members of members of s.
    `sUnion s` is the generalized union ⋃ s = {z | ∃ w ∈ s, z ∈ w}.
    Binary union x ∪ y is derivable as sUnion (pair x y) when HasPair is also available.

    Math: ∀ s, ∃ u, ∀ z, z ∈ u ↔ ∃ w ∈ s, z ∈ w
-/
class HasUnion (U : Type u) [Membership U U] where
  sUnion : U → U
  mem_sUnion_iff : ∀ (s z : U), z ∈ sUnion s ↔ ∃ w ∈ s, z ∈ w

end Foundations.Sets.Atomic.Union

export Foundations.Sets.Atomic.Union (HasUnion)
