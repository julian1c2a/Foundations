/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all arithmetic (A01 — Zero)
-- @importance: critical
-- @proof_status: axiom (typeclass field)

import Foundations.Prelim

universe u

namespace Foundations.Numeric.Atomic.Zero

/-- A01 — Zero.
    A distinguished element 0 of type N.
    Extends Lean 4's built-in Zero class so that the literal `0 : N` is available
    via the OfNat instance in Init.Prelude.

    Math: ∃ 0 ∈ N
-/
class HasZero (N : Type u) extends Zero N where
  -- The zero element is Zero.zero, accessible as (0 : N).
  -- No additional axioms at this level: 0 is a distinguished constant.

end Foundations.Numeric.Atomic.Zero

export Foundations.Numeric.Atomic.Zero (HasZero)
