/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all arithmetic (A04 — Multiplication, PA5 + PA6)
-- @importance: high
-- @proof_status: axiom (typeclass fields)

import Foundations.Prelim
import Foundations.Numeric.Atomic.Zero
import Foundations.Numeric.Atomic.Succ
import Foundations.Numeric.Atomic.Add

universe u

namespace Foundations.Numeric.Atomic.Mul

/-- A04 — Multiplication with Peano axioms PA5 and PA6.
    `mul : N → N → N` is defined by left recursion on the first argument.
    PA5 (zero_mul): 0 * n = 0  (base case)
    PA6 (succ_mul): σ(m) * n = (m * n) + n  (recursive case)

    Design note: same pattern as HasAdd — `mul` is a DATA field, `Add N` instance
    is accessed via named `[ha : HasAdd N]` to avoid cross-module namespace issues.
    The `Mul N` instance for `*` notation is provided as a derived instance below.

    Math: × : N → N → N   s.t.   0 × n = 0   and   σ(m) × n = (m × n) + n
-/
class HasMul (N : Type u) [HasZero N] [hs : HasSucc N] [ha : HasAdd N] where
  mul      : N → N → N
  zero_mul : ∀ (n : N), mul 0 n = 0
  succ_mul : ∀ (m n : N), mul (hs.succ m) n = ha.add (mul m n) n

/-- Derived Mul instance: enables `*` notation for any type with HasMul. -/
instance instMulOfHasMul {N : Type u} [HasZero N] [HasSucc N] [HasAdd N]
    [hm : HasMul N] : Mul N where
  mul := hm.mul

end Foundations.Numeric.Atomic.Mul

export Foundations.Numeric.Atomic.Mul (HasMul)
