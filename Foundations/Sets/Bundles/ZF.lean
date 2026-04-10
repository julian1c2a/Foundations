/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: Zermelo-Fraenkel set theory (ZF), without Choice
-- @importance: critical
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Sets.Atomic
import Foundations.Sets.Bundles.ZFBasic
import Foundations.Sets.Bundles.ZFFinite
import Foundations.Sets.Bundles.Zermelo

universe u

namespace Foundations.Sets.Bundles.ZF

/-- ZFSet — Zermelo-Fraenkel set theory (ZF), without Axiom of Choice.
    Extends ZermeloSet with Replacement.
    Axioms: ZermeloSet + S10 Repl.

    Note: ZFCSetTheory repo currently has Replacement pending (see NEXT-STEPS Phase 6a).
    Any type instantiating ZFSet must prove HasRepl — the hardest ZF axiom to establish.

    HasRepl uses f : U → U (total function form), equivalent to the relational schema.
-/
class ZFSet (U : Type u) [Membership U U]
    extends ZermeloSet U, HasRepl U

end Foundations.Sets.Bundles.ZF

export Foundations.Sets.Bundles.ZF (ZFSet)
