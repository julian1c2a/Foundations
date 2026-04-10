/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: ZFC, MK (global choice form); independent of ZF
-- @importance: high
-- @proof_status: axiom (typeclass field; independent of ZF — cannot be proven from S01–S10)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.Choice

/-- S11 — Axiom of Choice (global choice function form).
    For any nonempty set x, `choose x` selects an element of x.
    This is the "global choice function" formulation, equivalent to AC over ZF.
    Note: Classical.choice in Lean 4 gives type-level choice; this is set-theoretic choice
    (internal to the universe U), needed for set-theoretic constructions.

    Math: ∀ x, (∃ z, z ∈ x) → choose x ∈ x
-/
class HasChoice (U : Type u) [Membership U U] where
  choose : U → U
  choose_spec : ∀ (x : U), (∃ z : U, z ∈ x) → choose x ∈ x

end Foundations.Sets.Atomic.Choice

export Foundations.Sets.Atomic.Choice (HasChoice)
