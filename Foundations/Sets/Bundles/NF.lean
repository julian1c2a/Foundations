/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: Quine's New Foundations (NF)
-- @importance: medium
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Sets.Atomic
import Foundations.Sets.Bundles.ZFBasic

universe u

namespace Foundations.Sets.Bundles.NF

/-- NFSet — Quine's New Foundations (NF).
    Axioms: S02 Ext + S12 StratSep (stratified comprehension).
    Explicitly does NOT include Foundation (S09): NF is incompatible with Foundation,
    since NF has a universal set V = {x | x = x} which would violate regularity.

    NFSet does NOT extend ZFBasic, ZFFinite, or any ZF fragment. It is an independent
    branch of the hierarchy, incompatible with the ZFC lineage.

    WARNING: HasStratSep's typeclass interface cannot enforce the stratification
    condition syntactically. Instances must be constructed for genuine NF models only.
    See HasStratSep documentation for the Russell's paradox risk.
-/
class NFSet (U : Type u) [Membership U U]
    extends HasExt U, HasStratSep U

end Foundations.Sets.Bundles.NF

export Foundations.Sets.Bundles.NF (NFSet)
