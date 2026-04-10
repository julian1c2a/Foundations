/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all arithmetic (A03 — Addition, PA3 + PA4)
-- @importance: critical
-- @proof_status: axiom (typeclass fields)

import Foundations.Prelim
import Foundations.Numeric.Atomic.Zero
import Foundations.Numeric.Atomic.Succ

universe u

namespace Foundations.Numeric.Atomic.Add

/-- A03 — Addition with Peano axioms PA3 and PA4.
    `add : N → N → N` is defined by left recursion on the first argument.
    PA3 (zero_add): 0 + n = n  (base case of left recursion)
    PA4 (succ_add): σ(m) + n = σ(m + n)  (recursive case)

    Design note: `add` is a DATA field of this class (not via `extends Add N`) so that
    PA3 and PA4 can reference `add` directly (same-class field, no namespace issue).
    The Add N instance needed for `+` notation is provided as a derived instance below.

    The successor `hs.succ` is accessed via the named instance `[hs : HasSucc N]`,
    avoiding the cross-module field accessor issue seen in Phase 1a (see ADR-008).

    Math: + : N → N → N   s.t.   0 + n = n   and   σ(m) + n = σ(m + n)
-/
class HasAdd (N : Type u) [HasZero N] [hs : HasSucc N] where
  add      : N → N → N
  zero_add : ∀ (n : N), add 0 n = n
  succ_add : ∀ (m n : N), add (hs.succ m) n = hs.succ (add m n)

/-- Derived Add instance: enables `+` notation for any type with HasAdd. -/
instance instAddOfHasAdd {N : Type u} [HasZero N] [HasSucc N] [ha : HasAdd N] : Add N where
  add := ha.add

end Foundations.Numeric.Atomic.Add

export Foundations.Numeric.Atomic.Add (HasAdd)
