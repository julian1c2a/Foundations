/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: Robinson arithmetic (Q)
-- @importance: high
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Numeric.Atomic

universe u

namespace Foundations.Numeric.Bundles.Robinson

/-- RobinsonArith — Robinson arithmetic (Q).
    Axioms: A01 Zero, A02 Succ (+ PA1 + PA2), A03 Add (+ PA3 + PA4), A04 Mul (+ PA5 + PA6).
    No induction schema (A05/PA7): this is the key distinction from Peano arithmetic.

    Robinson's Q is the weakest arithmetic in which Gödel's incompleteness theorems apply.
    Any sufficiently strong consistent extension of Q is incomplete (Gödel 1931).
    This is the base system for Gödel numbering and representability (Phase 4).

    Derived instances provided by the atomic files:
      instAddOfHasAdd : Add N  (enables + notation)
      instMulOfHasMul : Mul N  (enables * notation)
-/
class RobinsonArith (N : Type u)
    extends HasZero N, HasSucc N, HasAdd N, HasMul N

end Foundations.Numeric.Bundles.Robinson

export Foundations.Numeric.Bundles.Robinson (RobinsonArith)
