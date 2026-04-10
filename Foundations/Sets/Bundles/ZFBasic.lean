/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: ZFC (first fragment), AczelSetTheory, ZFBasic-compatible systems
-- @importance: critical
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Sets.Atomic

universe u

namespace Foundations.Sets.Bundles.ZFBasic

/-- ZFBasic — first axiom fragment of ZFC.
    Corresponds to the opening block of ZFCSetTheory: from empty set to separation.
    Axioms: S02 Ext, S03 Empty, S04 Pair, S05 Sep.

    This is the minimal fragment for "basic" set operations: membership, emptiness,
    pairing, and subset selection. Sufficient for defining intersection and set difference.

    Any instance of ZFBasic U provides HasExt U, HasEmpty U, HasPair U, HasSep U
    automatically via Lean 4's typeclass inheritance.
-/
class ZFBasic (U : Type u) [Membership U U]
    extends HasExt U, HasEmpty U, HasPair U, HasSep U

end Foundations.Sets.Bundles.ZFBasic

export Foundations.Sets.Bundles.ZFBasic (ZFBasic)
