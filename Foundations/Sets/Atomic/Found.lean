/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: ZFC, MK, NBG, TG (not NF, not KP in full generality)
-- @importance: high
-- @proof_status: axiom (typeclass field; in AczelSetTheory this becomes a theorem by structural induction)

import Foundations.Prelim
import Foundations.Sets.Atomic.Empty

universe u

namespace Foundations.Sets.Atomic.Found

/-- S09 — Foundation (Regularity).
    Every nonempty set has an ∈-minimal element.
    Requires HasEmpty to state "x ≠ ∅".
    In AczelSetTheory (Paradigm 2), this is a theorem by structural induction on CList.

    Math: ∀ x ≠ ∅, ∃ y ∈ x, ∀ z ∈ x, z ∉ y
-/
class HasFound (U : Type u) [Membership U U] [HasEmpty U] : Prop where
  found : ∀ (x : U), x ≠ (∅ : U) → ∃ y ∈ x, ∀ z ∈ x, z ∉ y

end Foundations.Sets.Atomic.Found

export Foundations.Sets.Atomic.Found (HasFound)
