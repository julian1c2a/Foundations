/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (HasExt + HasPow + HasSep — no Choice needed)
-- @importance: critical
-- @proof_status: theorem (proven from typeclass constraints, uses Classical.em)

import Foundations.Sets.Atomic
import Foundations.Sets.Universal.Basic
import Foundations.Sets.Universal.Subset

universe u

open Foundations.Sets.Atomic.Sep.HasSep

namespace Foundations.Sets.Universal.Cantor

open Classical

/-- Cantor's theorem: no function from U to its powerset is surjective.
    Equivalently, no set x surjects onto its powerset.
    Proof: diagonal argument — the set D = {z ∈ x | z ∉ f z} is not in the image of f.

    Requires:
    - HasExt  : to prove D ≠ f y by extensionality
    - HasPow  : to state that f maps into the powerset
    - HasSep  : to construct the diagonal set D = {z ∈ x | z ∉ f z}

    Math: ∀ f : U → U, ¬ Surjective f (on powerset)
    i.e. ∀ f, ∀ x, ∃ D ∈ 𝒫 x, ∀ y ∈ x, f y ≠ D
-/
theorem cantor_no_surjection [Membership U U] [HasExt U] [HasPow U] [HasSep U]
    (f : U → U) (x : U)
    (hf : ∀ y : U, y ∈ x → subset (f y) x) :
    ∃ D : U, subset D x ∧ ∀ y : U, y ∈ x → f y ≠ D := by
  -- Diagonal set: D = {z ∈ x | z ∉ f z}
  let D := sep (fun z => z ∉ f z) x
  refine ⟨D, sep_subset (fun z => z ∉ f z) x, ?_⟩
  intro y hy hcontra
  -- If f y = D, derive a contradiction
  have key : y ∈ f y ↔ y ∈ D := by rw [hcontra]
  rw [mem_sep_iff] at key
  by_cases h : y ∈ f y
  · exact absurd h (key.mp h).2
  · exact absurd (key.mpr ⟨hy, h⟩) h

end Foundations.Sets.Universal.Cantor

export Foundations.Sets.Universal.Cantor (cantor_no_surjection)
