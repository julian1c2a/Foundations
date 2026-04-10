/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: Morse-Kelley + Class Axiom of Choice (MK+CAC)
-- @importance: high
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Sets.Atomic
import Foundations.Sets.Bundles.ZFBasic
import Foundations.Sets.Bundles.ZFFinite
import Foundations.Sets.Bundles.Zermelo
import Foundations.Sets.Bundles.ZF
import Foundations.Sets.Bundles.ZFC

universe u

namespace Foundations.Sets.Bundles.MK

/-- MKSet — Morse-Kelley set theory with Class Axiom of Choice (MK+CAC).
    Extends ZFCSet with Class Separation and Class Axiom of Choice.
    Axioms: ZFCSet + HasClassSep + HasCAC.

    MK is strictly stronger than ZFC: it can prove the consistency of ZFC.
    The set/class distinction is semantic (proper classes are not elements of any class)
    but cannot be enforced at the typeclass level alone — it is a property of instances.

    MKplusCAC repo currently has only axioms (see NEXT-STEPS Phase 6c for migration plan).
-/
class MKSet (U : Type u) [Membership U U]
    extends ZFCSet U, HasClassSep U, HasCAC U

end Foundations.Sets.Bundles.MK

export Foundations.Sets.Bundles.MK (MKSet)
