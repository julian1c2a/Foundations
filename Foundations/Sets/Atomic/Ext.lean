/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (S02 — Extensionality)
-- @importance: critical
-- @proof_status: axiom (typeclass field; instances decide whether it is axiom or theorem)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.Ext

/-- S02 — Extensionality.
    Two sets are equal if and only if they have exactly the same members.

    Math: ∀ x y, (∀ z, z ∈ x ↔ z ∈ y) → x = y
-/
class HasExt (U : Type u) [Membership U U] : Prop where
  ext : ∀ (x y : U), (∀ z : U, z ∈ x ↔ z ∈ y) → x = y

end Foundations.Sets.Atomic.Ext

export Foundations.Sets.Atomic.Ext (HasExt)
