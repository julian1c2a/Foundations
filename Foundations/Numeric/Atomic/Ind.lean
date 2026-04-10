/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: Peano arithmetic (A05 — Induction schema, PA7)
-- @importance: critical
-- @proof_status: axiom (typeclass field; in AczelSetTheory/Lean inductive types this is automatic)

import Foundations.Prelim
import Foundations.Numeric.Atomic.Zero
import Foundations.Numeric.Atomic.Succ

universe u

namespace Foundations.Numeric.Atomic.Ind

/-- A05 — Peano Induction Schema (PA7).
    For any predicate P on N: if P holds at 0 and is preserved by the successor,
    then P holds for all n.

    This is the distinguishing axiom of Peano Arithmetic (PA) over Robinson Arithmetic (Q).
    Without HasInd, a system has the operations 0, σ, +, × but no induction —
    that is Robinson's Q (see bundle RobinsonArith in Phase 1c).

    Paradigm note: for Lean 4 inductive types (AczelSetTheory, Peano repo),
    induction is a FREE theorem from the type's structure; this typeclass
    must only be instantiated explicitly for non-inductive presentations.

    The successor `hs.succ` is accessed via named instance `[hs : HasSucc N]`.

    Math: ∀ P : N → Prop, P(0) → (∀ n, P(n) → P(σ(n))) → ∀ n, P(n)
-/
class HasInd (N : Type u) [HasZero N] [hs : HasSucc N] : Prop where
  ind : ∀ (P : N → Prop),
      P (0 : N) →
      (∀ (n : N), P n → P (hs.succ n)) →
      ∀ (n : N), P n

end Foundations.Numeric.Atomic.Ind

export Foundations.Numeric.Atomic.Ind (HasInd)
