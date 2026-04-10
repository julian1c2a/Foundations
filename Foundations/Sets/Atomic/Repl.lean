/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: ZFC, MK, NBG, TG (not Zermelo, not KP without Delta_0 restriction)
-- @importance: high
-- @proof_status: axiom (typeclass field; in AczelSetTheory becomes a theorem)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.Repl

/-- S10 — Replacement (for total functions).
    For any function f : U → U and any set x, the image f[x] is a set.
    `repl f x` is the image {f w | w ∈ x}.
    Using f : U → U (total function) is equivalent to the relational schema in ZFC,
    since Lean 4 functions are total and therefore automatically functional.

    Math: ∀ f : U → U, ∀ x, ∃ y, ∀ z, z ∈ y ↔ ∃ w ∈ x, f w = z
-/
class HasRepl (U : Type u) [Membership U U] where
  repl : (U → U) → U → U
  mem_repl_iff : ∀ (f : U → U) (x z : U), z ∈ repl f x ↔ ∃ w ∈ x, f w = z

end Foundations.Sets.Atomic.Repl

export Foundations.Sets.Atomic.Repl (HasRepl)
