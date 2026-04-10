/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all arithmetic (A06 — Exponentiation, PA_Pow1 + PA_Pow2)
-- @importance: high
-- @proof_status: axiom (typeclass fields)

import Foundations.Prelim
import Foundations.Numeric.Atomic.Zero
import Foundations.Numeric.Atomic.Succ
import Foundations.Numeric.Atomic.Add
import Foundations.Numeric.Atomic.Mul

universe u

namespace Foundations.Numeric.Atomic.Pow

/-- A06 — Exponentiation with Peano recursion equations.
    `pow : N → N → N` is defined by left recursion on the exponent.
    PA_Pow1 (zero_pow): n ^ 0 = 1 = S(0)  (base case)
    PA_Pow2 (succ_pow): n ^ S(m) = n ^ m * n  (recursive case)

    Motivation: exponentiation is primitive recursive and is required for
    Gödel numbering (Phase 4). The β-function encoding sequences of naturals
    uses n^k as a key primitive. It is NOT included in Robinson arithmetic Q
    (see RobinsonArith bundle) but IS part of the standard Peano arithmetic
    infrastructure; hence it extends PeanoArith in Phase 1c.

    Note: 1 is represented as hs.succ 0 to avoid introducing a separate HasOne
    typeclass. Any PeanoArith instance satisfying this gives S(0) the expected role.

    Design: same named-instance pattern as HasAdd/HasMul to avoid cross-module
    namespace issues. The HPow instance enabling ^ notation is derived below.

    Math: pow : N → N → N   s.t.   n^0 = σ(0)   and   n^σ(m) = n^m * n
-/
class HasPow (N : Type u) [HasZero N] [hs : HasSucc N] [HasAdd N] [hm : HasMul N] where
  pow      : N → N → N
  zero_pow : ∀ (n : N), pow n 0 = hs.succ 0
  succ_pow : ∀ (m n : N), pow n (hs.succ m) = hm.mul (pow n m) n

/-- Derived HPow instance: enables ^ notation for any type with HasPow. -/
instance instHPowOfHasPow {N : Type u} [HasZero N] [HasSucc N] [HasAdd N] [HasMul N]
    [hp : HasPow N] : HPow N N N where
  hPow := hp.pow

end Foundations.Numeric.Atomic.Pow

export Foundations.Numeric.Atomic.Pow (HasPow)
