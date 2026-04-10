/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: Zermelo set theory (Z), subset of ZF/ZFC
-- @importance: high
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Sets.Atomic
import Foundations.Sets.Bundles.ZFBasic
import Foundations.Sets.Bundles.ZFFinite

universe u

namespace Foundations.Sets.Bundles.Zermelo

/-- ZermeloSet — classical Zermelo set theory (Z).
    Extends ZFFinite with the Axiom of Infinity.
    Axioms: ZFFinite + S08 Inf.
    No Replacement (S10): this is strictly weaker than ZF.

    HasInf requires [HasEmpty U], which ZFFinite provides via ZFBasic.
    The setSucc field of HasInf is provided by the instance.
-/
class ZermeloSet (U : Type u) [Membership U U]
    extends ZFFinite U, HasInf U

end Foundations.Sets.Bundles.Zermelo

export Foundations.Sets.Bundles.Zermelo (ZermeloSet)
