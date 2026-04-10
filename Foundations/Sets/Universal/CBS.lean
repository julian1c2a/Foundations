/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (HasExt + HasPow + HasSep + HasUnion — no Choice needed)
-- @importance: critical
-- @proof_status: sorry (proof sketch below; to be completed in Phase 1d+)

import Foundations.Sets.Atomic
import Foundations.Sets.Universal.Basic
import Foundations.Sets.Universal.Subset

universe u

open Foundations.Sets.Atomic.Sep.HasSep

namespace Foundations.Sets.Universal.CBS

open Classical

/-!
## Proof strategy: Knaster-Tarski fixed point on 𝒫(A)

Given injections f : A → B and g : B → A (all as Lean functions U → U with
membership conditions), define T : 𝒫(A) → 𝒫(A) by:

    T(S) = A \ g(B \ f(S))

where f(S) = {y ∈ B | ∃ x ∈ S, f x = y}  (image of S under f, subset of B).

Step 1 — T is monotone (S ⊆ S' → T(S) ⊆ T(S')):
  Follows because f(S) ⊆ f(S'), so B \ f(S') ⊆ B \ f(S), so
  g(B \ f(S')) ⊆ g(B \ f(S)), so A \ g(B \ f(S)) ⊆ A \ g(B \ f(S')).

Step 2 — T has a least fixed point C by Knaster-Tarski:
  C = ⋃ {S ∈ 𝒫(A) | S ⊆ T(S)}
  Constructed in U as:
    let P := HasSep.sep (fun S => subset S A ∧ subset S (image_of_T S)) (HasPow.powerset A)
    let C := HasUnion.sUnion P

Step 3 — C is a fixed point: C = T(C).
  C ⊆ T(C): if x ∈ C, then x ∈ some S with S ⊆ T(S), so x ∈ T(S) ⊆ T(C) (by monotonicity).
  T(C) ⊆ C: T(C) itself satisfies T(C) ⊆ T(T(C)) (by fixed-point property of C), so T(C) ∈ P.

Step 4 — Bijection h : A → B:
  For x ∈ C   : h(x) = f(x).
  For x ∈ A\C : h(x) = Classical.choose (g_preimage x) where g_preimage witnesses
                        that x ∈ A \ C = g(B \ f(C)), giving a unique y ∈ B \ f(C) with g y = x.

Step 5 — h is injective:
  On C: injectivity of f. On A\C: injectivity of g (hence of g⁻¹).
  Cross: if x ∈ C, x' ∈ A\C, h(x) = h(x'), then f(x) ∈ f(C) and h(x') ∈ B\f(C) — contradiction.

Step 6 — h is surjective:
  Any y ∈ f(C) has preimage via f. Any y ∈ B \ f(C) has preimage via g⁻¹.
  Together they cover all of B.

Dependencies needed: HasExt, HasPow, HasSep, HasUnion.
No Choice needed: g⁻¹ is well-defined by injectivity of g (using Classical.choose + ExistsUnique).
-/

/-- Auxiliary: image of a Lean function restricted to a set, as a subset of another set.
    img f A B = {y ∈ B | ∃ x ∈ A, f x = y} -/
noncomputable def img [Membership U U] [HasSep U]
    (f : U → U) (A B : U) : U :=
  sep (fun y => ∃ x : U, x ∈ A ∧ f x = y) B

theorem mem_img_iff [Membership U U] [HasSep U]
    (f : U → U) (A B y : U) :
    y ∈ img f A B ↔ y ∈ B ∧ ∃ x : U, x ∈ A ∧ f x = y :=
  mem_sep_iff _ B y

/-- Cantor-Bernstein-Schröder theorem.
    If there are injections f : A → B and g : B → A (as Lean functions preserving membership),
    then there exists a bijection h : A → B (a Lean function mapping A-members to B-members,
    injective and surjective on the respective sets).

    Proof: Knaster-Tarski fixed point on 𝒫(A); see proof sketch above.
    Requires: HasExt (set equality), HasPow (to form 𝒫(A)), HasSep (subset selection),
              HasUnion (to take ⋃ of the Tarski collection).
    No Choice: g⁻¹ is unique by injectivity; Classical.choose suffices.
-/
theorem cantor_bernstein
    [Membership U U] [HasExt U] [HasPow U] [HasSep U] [HasUnion U]
    (A B : U) (f g : U → U)
    (hfA  : ∀ x : U, x ∈ A → f x ∈ B)
    (hgB  : ∀ y : U, y ∈ B → g y ∈ A)
    (hf_inj : ∀ x₁ x₂ : U, x₁ ∈ A → x₂ ∈ A → f x₁ = f x₂ → x₁ = x₂)
    (hg_inj : ∀ y₁ y₂ : U, y₁ ∈ B → y₂ ∈ B → g y₁ = g y₂ → y₁ = y₂) :
    ∃ h : U → U,
      (∀ x : U, x ∈ A → h x ∈ B) ∧
      (∀ y : U, y ∈ B → ∃ x : U, x ∈ A ∧ h x = y) ∧
      (∀ x₁ x₂ : U, x₁ ∈ A → x₂ ∈ A → h x₁ = h x₂ → x₁ = x₂) := by
  sorry

end Foundations.Sets.Universal.CBS

export Foundations.Sets.Universal.CBS (
  img
  mem_img_iff
  cantor_bernstein
)
