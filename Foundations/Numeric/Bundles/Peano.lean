/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: Peano arithmetic (PA)
-- @importance: critical
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Numeric.Atomic
import Foundations.Numeric.Bundles.Robinson



universe u

namespace Foundations.Numeric.Bundles.Peano

/-- PeanoArith — Peano arithmetic (PA).
    Extends RobinsonArith with exponentiation and the induction schema.
    Axioms: RobinsonArith + A06 Pow (PA_Pow1 + PA_Pow2) + A05 Ind (PA7).

    PA is the standard first-order arithmetic. It is the foundation for:
    - Gödel numbering (Phase 4): the coding uses pow as a key primitive
    - Incompleteness theorems: PA ⊬ Con(PA) if PA is consistent
    - Connecting arithmetic to set theory: von Neumann ω ⊨ PA within ZFC

    HasPow requires [HasZero N] [HasSucc N] [HasMul N], all in RobinsonArith.
    HasInd requires [HasZero N] [HasSucc N], both in RobinsonArith.
    The ^ notation is enabled via instHPowOfHasPow from HasPow.
-/
class PeanoArith (N : Type u)
    extends RobinsonArith N, HasPow N, HasInd N

end Foundations.Numeric.Bundles.Peano

export Foundations.Numeric.Bundles.Peano (PeanoArith)
