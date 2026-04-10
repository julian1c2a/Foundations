/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all arithmetic (A02 — Successor + PA1 + PA2)
-- @importance: critical
-- @proof_status: axiom (typeclass fields)

import Foundations.Prelim
import Foundations.Numeric.Atomic.Zero

universe u

namespace Foundations.Numeric.Atomic.Succ

/-- A02 — Successor with Peano axioms PA1 and PA2.
    `succ : N → N` is the successor function.
    PA1 (succ_ne_zero): the successor of any element is not zero.
    PA2 (succ_inj): the successor function is injective.
    These two axioms, together with HasZero, are the foundation of all Peano systems.

    All field types reference only `succ` (same class) and `0 : N` (from HasZero),
    so no cross-module field accessor issues arise.

    Math: σ : N → N   such that   σ n ≠ 0   and   σ m = σ n → m = n
-/
class HasSucc (N : Type u) [HasZero N] where
  succ        : N → N
  succ_ne_zero : ∀ (n : N), succ n ≠ (0 : N)
  succ_inj    : ∀ (m n : N), succ m = succ n → m = n

end Foundations.Numeric.Atomic.Succ

export Foundations.Numeric.Atomic.Succ (HasSucc)
