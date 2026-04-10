/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: Zermelo-Fraenkel + Choice (ZFC), standard foundation of mathematics
-- @importance: critical
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Sets.Atomic
import Foundations.Sets.Bundles.ZFBasic
import Foundations.Sets.Bundles.ZFFinite
import Foundations.Sets.Bundles.Zermelo
import Foundations.Sets.Bundles.ZF

universe u

namespace Foundations.Sets.Bundles.ZFC

/-- ZFCSet — Zermelo-Fraenkel set theory with Axiom of Choice (ZFC).
    Extends ZFSet with the Axiom of Choice.
    Axioms: ZFSet + S11 Choice.

    ZFC is the standard foundation of classical mathematics.
    The forcing framework (Phase 7) requires ZFC as its base system.
    AC is independent of ZF: instances of ZFSet need not be instances of ZFCSet.

    HasChoice uses the global choice function form: choose x ∈ x for nonempty x.
    This is equivalent to the standard AC formulation over ZF.
-/
class ZFCSet (U : Type u) [Membership U U]
    extends ZFSet U, HasChoice U

end Foundations.Sets.Bundles.ZFC

export Foundations.Sets.Bundles.ZFC (ZFCSet)
