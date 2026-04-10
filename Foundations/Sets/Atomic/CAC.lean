/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: MK (Class Axiom of Choice)
-- @importance: medium
-- @proof_status: axiom (typeclass field)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.CAC

/-- Class Axiom of Choice (CAC, MK form).
    For any class relation R such that some y satisfies R x y for a given x,
    `cac R x` is a witness: R x (cac R x) holds.
    This is the class-level analogue of HasChoice: it applies to class relations
    (represented as U → U → Prop) rather than just set-indexed families.
    Intended for MK where class functions need choice witnesses.

    Math: ∀ R : class relation, ∀ x, (∃ y, R x y) → R x (cac R x)
-/
class HasCAC (U : Type u) [Membership U U] where
  cac : (U → U → Prop) → U → U
  cac_spec : ∀ (R : U → U → Prop) (x : U), (∃ y : U, R x y) → R x (cac R x)

end Foundations.Sets.Atomic.CAC

export Foundations.Sets.Atomic.CAC (HasCAC)
