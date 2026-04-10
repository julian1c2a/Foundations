/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (S05 — Separation / Aussonderung)
-- @importance: critical
-- @proof_status: axiom (typeclass field; instances decide whether it is axiom or theorem)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.Sep

/-- S05 — Separation (Aussonderung).
    For any predicate φ and set s, there exists the set {z ∈ s | φ z}.
    `sep φ s` is the subset of s satisfying φ.

    Math: ∀ φ s, ∃ y, ∀ z, z ∈ y ↔ z ∈ s ∧ φ z
-/
class HasSep (U : Type u) [Membership U U] where
  sep : (U → Prop) → U → U
  mem_sep_iff : ∀ (φ : U → Prop) (s z : U), z ∈ sep φ s ↔ z ∈ s ∧ φ z

end Foundations.Sets.Atomic.Sep

export Foundations.Sets.Atomic.Sep (HasSep)
