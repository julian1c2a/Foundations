/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (S04 — Pairing)
-- @importance: critical
-- @proof_status: axiom (typeclass field; instances decide whether it is axiom or theorem)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.Pair

/-- S04 — Pairing.
    For any two sets a b, there exists a set {a, b} whose members are exactly a and b.
    `pair a b` is the unordered pair {a, b}.
    Note: `pair a a` is the singleton {a}.

    Math: ∀ a b, ∃ p, ∀ z, z ∈ p ↔ z = a ∨ z = b
-/
class HasPair (U : Type u) [Membership U U] where
  pair : U → U → U
  mem_pair_iff : ∀ (a b z : U), z ∈ pair a b ↔ z = a ∨ z = b

end Foundations.Sets.Atomic.Pair

export Foundations.Sets.Atomic.Pair (HasPair)
