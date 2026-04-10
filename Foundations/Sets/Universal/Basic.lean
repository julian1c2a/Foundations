/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (requires only minimal atomics per theorem)
-- @importance: critical
-- @proof_status: theorem (proven from typeclass constraints)

import Foundations.Sets.Atomic

universe u

-- Open class namespaces to bring field accessors into scope.
-- This is the standard workaround: `export` creates type aliases but not namespace aliases,
-- so `HasSep.sep` fails inside a different namespace. Opening the class namespace directly
-- makes `sep`, `ext`, `pair` etc. available as unqualified names.
open Foundations.Sets.Atomic.Ext.HasExt
open Foundations.Sets.Atomic.Empty.HasEmpty
open Foundations.Sets.Atomic.Pair.HasPair
open Foundations.Sets.Atomic.Sep.HasSep

namespace Foundations.Sets.Universal.Basic

-- ============================================================
-- Section 1: Derived operations
-- ============================================================

/-- Binary intersection: {z | z ∈ x ∧ z ∈ y}, derived from HasSep. -/
noncomputable def inter [Membership U U] [HasSep U] (x y : U) : U :=
  sep (fun z => z ∈ y) x

/-- Set difference: {z | z ∈ x ∧ z ∉ y}, derived from HasSep. -/
noncomputable def sdiff [Membership U U] [HasSep U] (x y : U) : U :=
  sep (fun z => z ∉ y) x

-- ============================================================
-- Section 2: Membership lemmas for derived operations
-- ============================================================

theorem mem_inter_iff [Membership U U] [HasSep U]
    (x y z : U) : z ∈ inter x y ↔ z ∈ x ∧ z ∈ y :=
  mem_sep_iff (fun w => w ∈ y) x z

theorem mem_sdiff_iff [Membership U U] [HasSep U]
    (x y z : U) : z ∈ sdiff x y ↔ z ∈ x ∧ z ∉ y :=
  mem_sep_iff (fun w => w ∉ y) x z

-- ============================================================
-- Section 3: Theorems about empty set
-- ============================================================

/-- The empty set is unique: any set with no members equals ∅. -/
theorem empty_unique [Membership U U] [HasExt U] [HasEmpty U]
    (x : U) (h : ∀ z : U, z ∉ x) : x = (∅ : U) := by
  apply ext
  intro z
  exact ⟨fun hmem => absurd hmem (h z),
         fun hmem => absurd hmem (not_mem_empty z)⟩

/-- Separation of ∅ by any predicate gives ∅. -/
theorem sep_empty [Membership U U] [HasExt U] [HasEmpty U] [HasSep U]
    (φ : U → Prop) : sep φ (∅ : U) = (∅ : U) := by
  apply ext; intro z
  rw [mem_sep_iff]
  exact ⟨fun ⟨h, _⟩ => absurd h (not_mem_empty z),
         fun h     => absurd h (not_mem_empty z)⟩

-- ============================================================
-- Section 4: Theorems about pairing
-- ============================================================

/-- Unordered pairs are commutative. -/
theorem pair_comm [Membership U U] [HasExt U] [HasPair U]
    (a b : U) : pair a b = pair b a := by
  apply ext; intro z
  simp only [mem_pair_iff]
  exact Or.comm

end Foundations.Sets.Universal.Basic

export Foundations.Sets.Universal.Basic (
  inter
  sdiff
  mem_inter_iff
  mem_sdiff_iff
  empty_unique
  sep_empty
  pair_comm
)
