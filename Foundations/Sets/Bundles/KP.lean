/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: Kripke-Platek set theory (KP), simplified version
-- @importance: medium
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Sets.Atomic
import Foundations.Sets.Bundles.ZFBasic

universe u

namespace Foundations.Sets.Bundles.KP

/-- KPSet — Kripke-Platek set theory (simplified version).
    Axioms: S02 Ext, S03 Empty, S04 Pair, S06 Union.

    This is a SIMPLIFIED version of KP. The full KP theory additionally restricts
    Separation and Collection to Δ₀ formulas (formulas with only bounded quantifiers).
    Since Phase 1a does not yet have Δ₀-restricted versions of HasSep/HasRepl,
    this bundle captures only the shared structural core.

    KP is weaker than ZF and is used in proof theory and admissible set theory.
    It is relevant for formalizing ordinal recursion without full ZF.
    A complete KP formalization would require Δ₀-Sep and Δ₀-Collection typeclasses
    (future work, not yet in the atomic inventory).
-/
class KPSet (U : Type u) [Membership U U]
    extends HasExt U, HasEmpty U, HasPair U, HasUnion U

end Foundations.Sets.Bundles.KP

export Foundations.Sets.Bundles.KP (KPSet)
