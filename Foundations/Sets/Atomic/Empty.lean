/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: all (S03 — Empty Set)
-- @importance: critical
-- @proof_status: axiom (typeclass field; instances decide whether it is axiom or theorem)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.Empty

/-- S03 — Empty Set.
    There exists a set ∅ with no members.
    Extends EmptyCollection so that ∅ notation is available for any [HasEmpty U] instance.

    Math: ∃ ∅, ∀ x, x ∉ ∅
-/
class HasEmpty (U : Type u) [Membership U U] extends EmptyCollection U where
  not_mem_empty : ∀ (x : U), x ∉ (emptyCollection : U)

end Foundations.Sets.Atomic.Empty

export Foundations.Sets.Atomic.Empty (HasEmpty)
