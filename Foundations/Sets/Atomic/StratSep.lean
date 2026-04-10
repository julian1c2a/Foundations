/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: NF, NFUM only
-- @importance: medium
-- @proof_status: axiom (typeclass field)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.StratSep

/-- S12 — Stratified Separation (New Foundations comprehension schema).
    For any predicate φ, `stratSep φ` is the set {z | φ z}.
    WARNING: in NF, φ must be *stratified* — a metatheoretic syntactic condition
    that cannot be fully expressed as a Lean 4 Prop. This typeclass postulates the
    axiom schema for all predicates. It must only be instantiated for types that
    genuinely satisfy NF stratified comprehension (e.g., a set-theoretic model of NF).
    Unrestricted instantiation (for arbitrary U) leads to Russell's paradox.

    Math: ∀ φ stratified, ∃ y, ∀ z, z ∈ y ↔ φ z
-/
class HasStratSep (U : Type u) [Membership U U] where
  stratSep : (U → Prop) → U
  mem_stratSep_iff : ∀ (φ : U → Prop) (z : U), z ∈ stratSep φ ↔ φ z

end Foundations.Sets.Atomic.StratSep

export Foundations.Sets.Atomic.StratSep (HasStratSep)
