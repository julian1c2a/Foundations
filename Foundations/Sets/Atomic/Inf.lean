/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: ZFC, MK, NBG, TG (not KP-without-infinity, not HFSet)
-- @importance: high
-- @proof_status: axiom (typeclass fields; in AczelSetTheory this fails: HFSet has no infinite set)

import Foundations.Prelim
import Foundations.Sets.Atomic.Empty

universe u

namespace Foundations.Sets.Atomic.Inf

/-- S08 — Infinity.
    There exists an inductive set ω: ∅ ∈ ω, and for every y ∈ ω the set-theoretic
    successor S(y) also belongs to ω.

    The successor operation `setSucc` is provided by the instance rather than derived
    from HasPair/HasUnion. This keeps the dependency minimal (only HasEmpty) and makes
    the axiom system-agnostic: any universe where ∅ is in scope and some successor
    operation exists can satisfy this interface.

    For ZFC: setSucc y = y ∪ {y} = sUnion (pair y (pair y y)) (von Neumann successor).
    The membership characterization mem_setSucc_iff forces setSucc to behave as y ∪ {y}
    without requiring HasPair or HasUnion at the class level.

    Note on NEXT-STEPS.md: the original plan listed [HasSucc U] (arithmetic, Phase 1b)
    as a dependency. This design avoids that cross-dependency entirely.

    Math: ∃ ω, ∅ ∈ ω ∧ ∀ y ∈ ω, S(y) ∈ ω   where z ∈ S(y) ↔ z ∈ y ∨ z = y
-/
class HasInf (U : Type u) [Membership U U] [HasEmpty U] where
  inf      : U
  setSucc  : U → U
  empty_mem_inf   : (∅ : U) ∈ inf
  succ_mem_inf    : ∀ (y : U), y ∈ inf → setSucc y ∈ inf
  mem_setSucc_iff : ∀ (y z : U), z ∈ setSucc y ↔ z ∈ y ∨ z = y

end Foundations.Sets.Atomic.Inf

export Foundations.Sets.Atomic.Inf (HasInf)
