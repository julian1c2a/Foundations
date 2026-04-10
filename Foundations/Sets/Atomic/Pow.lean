/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (S07 — Powerset)
-- @importance: critical
-- @proof_status: axiom (typeclass field; instances decide whether it is axiom or theorem)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.Pow

/-- S07 — Powerset.
    For any set s, there exists 𝒫 s whose members are exactly the subsets of s.
    `powerset s` is the powerset 𝒫 s = {z | z ⊆ s} = {z | ∀ x ∈ z, x ∈ s}.

    Math: ∀ s, ∃ p, ∀ z, z ∈ p ↔ ∀ x, x ∈ z → x ∈ s
-/
class HasPow (U : Type u) [Membership U U] where
  powerset : U → U
  mem_powerset_iff : ∀ (s z : U), z ∈ powerset s ↔ ∀ x : U, x ∈ z → x ∈ s

end Foundations.Sets.Atomic.Pow

export Foundations.Sets.Atomic.Pow (HasPow)
