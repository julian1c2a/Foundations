/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: ZFC (hereditarily finite fragment), AczelSetTheory (HFSet model)
-- @importance: critical
-- @proof_status: bundle (no new fields; pure extends)

import Foundations.Sets.Atomic
import Foundations.Sets.Bundles.ZFBasic

universe u

namespace Foundations.Sets.Bundles.ZFFinite

/-- ZFFinite — ZFC restricted to hereditarily finite sets.
    Extends ZFBasic with Union, Powerset, and Foundation.
    Axioms: ZFBasic + S06 Union, S07 Pow, S09 Found.
    No S08 Infinity: this fragment is satisfied by HFSet (AczelSetTheory's type).

    The canonical model is AczelSetTheory's HFSet quotient type, where all six
    non-infinity ZFC axioms hold as theorems by structural induction on CList.
    Foundation is satisfied because CList has no cycles (Paradigm 2, THOUGHTS.md).
-/
class ZFFinite (U : Type u) [Membership U U]
    extends ZFBasic U, HasUnion U, HasPow U, HasFound U

end Foundations.Sets.Bundles.ZFFinite

export Foundations.Sets.Bundles.ZFFinite (ZFFinite)
