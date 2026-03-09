/-
Copyright (c) 2025. All rights reserved.
Author: Your Name
License: MIT

  MK⁺ — Morse-Kelley Set Theory + Class Axiom Scheme of Choice
  =============================================================

  Parallel development to ZfcSetTheory (ZFC), but grounded on a
  two-sorted ontology:

    · Sets    — collections that *belong to* some class.
    · Classes — any definable collection (sets are a subclass).

  Key differences from ZFC / ZfcSetTheory:
    1. Proper classes are first-class objects (not just informal talk).
    2. Comprehension schema (A7) allows formulas quantifying over classes,
       not just over sets — making MK strictly stronger than ZFC.
    3. Global Choice (MK⁺1) and the Class Axiom Scheme of Choice (MK⁺2)
       go beyond NBG's set-form choice.

  Lean encoding strategy:
    · A single Lean `Type` called `Class` for the universe of discourse.
    · `Mem : Class → Class → Prop` as the primitive membership relation.
    · `IsSet : Class → Prop` defined from membership (see §1).
    · Ordered pairs ⟪x, y⟫ are a *defined* notion (Kuratowski or Morse).
    · All axioms are stated as `axiom` declarations — left `sorry`-free
      by design; concrete proofs will live in separate modules.
-/

import MyProject.Prelim
-- Available from Prelim (no re-import needed):
--   ExistsUnique, ∃! x, p, ∃¹ x, p
--   ExistsUnique.intro / .exists / .choose / .choose_spec / .unique
--   choose_unique / choose_spec_unique / choose_uniq  (Peano-compatible)
--   Classical.*   (via open Classical in Prelim)

namespace MKplus

open Classical

/-! ─────────────────────────────────────────────────────────────────────────
    §0 · Primitive Sorts and Relations
    ─────────────────────────────────────────────────────────────────────────

  We postulate:
    · `Class`   — the universe of all classes (a Lean `Type`).
    · `Mem`     — the binary membership relation on classes.

  Everything else (IsSet, pairs, union, etc.) is *defined* from these.
-/

-- The universe of all classes (both sets and proper classes).
-- axiom Class : Type

-- Primitive membership.
-- axiom Mem : Class → Class → Prop

-- Preferred infix notation for membership.
-- local notation:50 x " ∈ᴹ " y => Mem x y
-- local notation:50 x " ∉ᴹ " y => ¬ Mem x y


/-! ─────────────────────────────────────────────────────────────────────────
    §1 · Defined Notions
    ─────────────────────────────────────────────────────────────────────────

  These are purely definitional; they carry no axiomatic content.
-/

-- A class X is a *set* iff it is a member of some class Y.
-- def IsSet (X : Class) : Prop := ∃ Y : Class, X ∈ᴹ Y

-- X is a subclass of Y (class inclusion).
-- def SubClass (X Y : Class) : Prop := ∀ u : Class, u ∈ᴹ X → u ∈ᴹ Y
-- local notation:50 X " ⊆ᴹ " Y => SubClass X Y

-- Kuratowski ordered pair: ⟪x, y⟫ := {{x}, {x, y}}.
-- (Existence and basic properties follow from A3 + A7.)
-- def OPair (x y : Class) : Class := ...   -- defined after A3 + A7
-- local notation "⟪" x ", " y "⟫" => OPair x y

-- F is a class-function (each left-component has exactly one right-component).
-- def IsClassFun (F : Class) : Prop :=
--   ∀ x y z : Class, ⟪x, y⟫ ∈ᴹ F → ⟪x, z⟫ ∈ᴹ F → y = z

-- Domain of a class-relation.
-- def Dom (F : Class) : Class := ...   -- defined via A7 after pairs

-- Image of a set x under class-function F.
-- def Img (F x : Class) : Class := ...  -- defined via A7 after pairs


/-! ─────────────────────────────────────────────────────────────────────────
    §2 · Axioms of Morse-Kelley Set Theory (MK)
    ─────────────────────────────────────────────────────────────────────────

  Standard presentation following:
    · J.L. Kelley, "General Topology" (1955), Appendix.
    · A.P. Morse, "A Theory of Sets" (1965).
    · E. Mendelson, "Introduction to Mathematical Logic", Ch. 4.

  The eight axioms below constitute MK proper.
  (MK⁺ adds the class choice axioms in §3.)
-/

-- ── A1. Extensionality ────────────────────────────────────────────────────
-- Two classes with the same set-members are identical.
-- Note: membership is only tested on *sets* (not arbitrary classes).
-- axiom MK_Ext :
--   ∀ X Y : Class,
--     (∀ u : Class, IsSet u → (u ∈ᴹ X ↔ u ∈ᴹ Y)) → X = Y

-- ── A2. Foundation (Regularity) ───────────────────────────────────────────
-- Every non-empty class has an ∈ᴹ-minimal member.
-- Equivalently: no class is a member of itself, and ∈ᴹ is well-founded on sets.
-- axiom MK_Found :
--   ∀ X : Class, (∃ u : Class, u ∈ᴹ X) →
--     ∃ u : Class, u ∈ᴹ X ∧ ¬ ∃ v : Class, v ∈ᴹ u ∧ v ∈ᴹ X

-- ── A3. Pairing ───────────────────────────────────────────────────────────
-- For any two sets x, y their unordered pair {x, y} is a set.
-- axiom MK_Pair :
--   ∀ x y : Class, IsSet x → IsSet y →
--     ∃ z : Class, IsSet z ∧ ∀ u : Class, u ∈ᴹ z ↔ u = x ∨ u = y

-- ── A4. Union ─────────────────────────────────────────────────────────────
-- The union ⋃x of a set x is a set.
-- axiom MK_Union :
--   ∀ x : Class, IsSet x →
--     ∃ z : Class, IsSet z ∧
--       ∀ u : Class, u ∈ᴹ z ↔ ∃ v : Class, u ∈ᴹ v ∧ v ∈ᴹ x

-- ── A5. Power Set ─────────────────────────────────────────────────────────
-- The power class 𝒫(x) = {u | u ⊆ x} of a set x is a set.
-- axiom MK_Pow :
--   ∀ x : Class, IsSet x →
--     ∃ z : Class, IsSet z ∧
--       ∀ u : Class, u ∈ᴹ z ↔ IsSet u ∧ ∀ v : Class, v ∈ᴹ u → v ∈ᴹ x

-- ── A6. Infinity ──────────────────────────────────────────────────────────
-- There exists an inductive set: one containing ∅ and closed under
-- the von Neumann successor s(x) = x ∪ {x}.
-- (∅ and s are defined via A3 + A4 + A7; stated here informally.)
-- axiom MK_Inf :
--   ∃ x : Class, IsSet x ∧
--     -- ∅ ∈ x:
--     (∃ e : Class, IsSet e ∧ (∀ u : Class, u ∉ᴹ e) ∧ e ∈ᴹ x) ∧
--     -- ∀ y ∈ x, s(y) = y ∪ {y} ∈ x:
--     (∀ y : Class, y ∈ᴹ x →
--       ∃ s : Class, IsSet s ∧ s ∈ᴹ x ∧
--         ∀ u : Class, u ∈ᴹ s ↔ u ∈ᴹ y ∨ u = y)

-- ── A7. Class Comprehension Schema (MK-Comp) ──────────────────────────────
-- The hallmark of MK over NBG:
--   For *any* Lean Prop φ (including those quantifying over classes),
--   the collection {u : Set | φ u} exists as a class.
--
-- In NBG the schema is restricted to *predicative* formulas (no class
-- quantifiers); in MK the schema is *impredicative* (full second-order).
--
-- axiom MK_Comp :
--   ∀ (φ : Class → Prop),
--     ∃ Z : Class, ∀ u : Class, u ∈ᴹ Z ↔ IsSet u ∧ φ u

-- ── A8. Substitution (Replacement) ───────────────────────────────────────
-- The image of a set under a class-function is a set.
-- (In MK this sometimes follows from Comp + other axioms,
--  but stating it explicitly keeps the axiom list transparent.)
-- axiom MK_Repl :
--   ∀ (F x : Class), IsSet x → IsClassFun F →
--     ∃ z : Class, IsSet z ∧
--       ∀ v : Class, v ∈ᴹ z ↔ ∃ u : Class, u ∈ᴹ x ∧ ⟪u, v⟫ ∈ᴹ F


/-! ─────────────────────────────────────────────────────────────────────────
    §3 · MK⁺ — Class Axiom Scheme of Choice
    ─────────────────────────────────────────────────────────────────────────

  Three progressively stronger choice principles for classes.
  MK⁺1 is "global choice as a class"; MK⁺2 is the full axiom *scheme*.
  They are independent from MK in the same sense AC is independent from ZF.

  Reference: Felgner (1971) "Models of ZF-Set Theory", §IV;
             Mostowski (1939) on class well-orderings.
-/

-- ── MK⁺1. Global Choice (class selector form) ────────────────────────────
-- There exists a class C that *selects* an element from every non-empty set.
-- Equivalently: there is a global choice function at the class level.
-- axiom MK_GlobalChoice :
--   ∃ C : Class,
--     ∀ x : Class, IsSet x → (∃ u : Class, u ∈ᴹ x) →
--       ∃ u : Class, u ∈ᴹ x ∧ ⟪x, u⟫ ∈ᴹ C

-- ── MK⁺2. Class Axiom Scheme of Choice (CAC) ─────────────────────────────
-- For any class-relation R that is "total" on sets (every set has an
-- R-image), there exists a class-function F ⊆ R with the same domain.
--
-- This is stated as an axiom *scheme*: one instance for each class R
-- (equivalently, one instance for each formula defining R).
-- In practice in Lean, a single `axiom` with a universally quantified
-- class R captures the whole scheme.
--
-- axiom MK_CAC :
--   ∀ (R : Class),
--     (∀ x : Class, IsSet x → ∃ y : Class, ⟪x, y⟫ ∈ᴹ R) →
--     ∃ F : Class,
--       (∀ x y z : Class, ⟪x, y⟫ ∈ᴹ F → ⟪x, z⟫ ∈ᴹ F → y = z) ∧  -- F is a function
--       (∀ x : Class, IsSet x → ∃ y : Class, ⟪x, y⟫ ∈ᴹ F) ∧       -- F is total on sets
--       (∀ x y : Class, ⟪x, y⟫ ∈ᴹ F → ⟪x, y⟫ ∈ᴹ R)               -- F ⊆ R

-- ── MK⁺3. Well-ordering of the universe (class well-order form) ──────────
-- There exists a class W that well-orders all sets.
-- (Equivalent to MK⁺1 over MK; included for completeness.)
-- axiom MK_WO :
--   ∃ W : Class,
--     -- W is a total strict order on sets:
--     (∀ x y : Class, IsSet x → IsSet y → x ≠ y →
--       ⟪x, y⟫ ∈ᴹ W ∨ ⟪y, x⟫ ∈ᴹ W) ∧
--     (∀ x y : Class, ⟪x, y⟫ ∈ᴹ W → ¬ ⟪y, x⟫ ∈ᴹ W) ∧
--     -- W is well-founded on sets:
--     (∀ X : Class, (∃ u : Class, IsSet u ∧ u ∈ᴹ X) →
--       ∃ m : Class, IsSet m ∧ m ∈ᴹ X ∧
--         ∀ u : Class, IsSet u → u ∈ᴹ X → ¬ ⟪u, m⟫ ∈ᴹ W)


/-! ─────────────────────────────────────────────────────────────────────────
    §4 · ∃! in the class context
    ─────────────────────────────────────────────────────────────────────────

  Re-using the ExistsUnique infrastructure from Prelim.lean.
  In the MK context, ∃! x, φ x means:
    there is exactly one *class* X (or set, depending on context)
    satisfying φ.

  Typical uses:
    · Uniqueness of the empty class: ∃! E : Class, ∀ u, u ∉ᴹ E
    · Uniqueness of ordered-pair decoding: ∃! y, ⟪x, y⟫ ∈ᴹ F
    · Unique witnesses in functional relations (IsClassFun F →
        ∀ x, ∃! y, ⟪x, y⟫ ∈ᴹ F)
-/

-- Example pattern (uncomment when Class and Mem are in scope):

-- theorem unique_empty :
--     ∃! E : Class, (∀ u : Class, u ∉ᴹ E) ∧ IsSet E := by
--   apply ExistsUnique.intro ...

-- theorem classful_unique_image (F x : Class) (hF : IsClassFun F) (hx : IsSet x)
--     (hu : ∃ y, ⟪x, y⟫ ∈ᴹ F) : ∃! y : Class, ⟪x, y⟫ ∈ᴹ F := by
--   obtain ⟨y, hy⟩ := hu
--   exact ExistsUnique.intro y hy (fun z hz => hF x z y hz hy)


end MKplus
