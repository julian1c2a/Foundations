/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (HasSep for subset, HasExt additionally for antisymmetry)
-- @importance: critical
-- @proof_status: theorem (proven from typeclass constraints)

import Foundations.Sets.Atomic
import Foundations.Sets.Universal.Basic

universe u

open Foundations.Sets.Atomic.Ext.HasExt
open Foundations.Sets.Atomic.Empty.HasEmpty
open Foundations.Sets.Atomic.Sep.HasSep
open Foundations.Sets.Atomic.Pow.HasPow

namespace Foundations.Sets.Universal.Subset

-- ============================================================
-- Section 1: Definition of subset
-- ============================================================

/-- x ⊆ y iff every member of x is also a member of y.
    Defined without HasSep: only requires Membership. -/
def subset [Membership U U] (x y : U) : Prop :=
  ∀ z : U, z ∈ x → z ∈ y

-- ============================================================
-- Section 2: Basic subset properties
-- ============================================================

theorem subset_refl [Membership U U] (x : U) : subset x x :=
  fun _ h => h

theorem subset_trans [Membership U U]
    {x y z : U} (hxy : subset x y) (hyz : subset y z) : subset x z :=
  fun w hw => hyz w (hxy w hw)

/-- Antisymmetry requires extensionality. -/
theorem subset_antisymm [Membership U U] [HasExt U]
    {x y : U} (hxy : subset x y) (hyx : subset y x) : x = y := by
  apply ext
  intro z
  exact ⟨hxy z, hyx z⟩

-- ============================================================
-- Section 3: Interaction with empty set and separation
-- ============================================================

/-- The empty set is a subset of every set. -/
theorem empty_subset [Membership U U] [HasEmpty U]
    (x : U) : subset (∅ : U) x :=
  fun z h => absurd h (not_mem_empty z)

/-- sep φ x is always a subset of x. -/
theorem sep_subset [Membership U U] [HasSep U]
    (φ : U → Prop) (x : U) : subset (sep φ x) x :=
  fun z h => (mem_sep_iff φ x z |>.mp h).1

-- ============================================================
-- Section 4: Subset and membership
-- ============================================================

/-- Powerset membership is equivalent to subset. -/
theorem mem_powerset_iff_subset [Membership U U] [HasPow U]
    (s z : U) : z ∈ powerset s ↔ subset z s :=
  mem_powerset_iff s z

end Foundations.Sets.Universal.Subset

export Foundations.Sets.Universal.Subset (
  subset
  subset_refl
  subset_trans
  subset_antisymm
  empty_subset
  sep_subset
  mem_powerset_iff_subset
)
