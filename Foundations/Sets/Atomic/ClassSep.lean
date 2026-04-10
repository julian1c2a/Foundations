/-
Copyright (c) 2026. All rights reserved.
Author: Julián Calderón Almendros
License: MIT
-/

-- REFERENCE.md: project this file after every modification.
-- @axiom_system: MK, NBG
-- @importance: medium
-- @proof_status: axiom (typeclass field)

import Foundations.Prelim

universe u

namespace Foundations.Sets.Atomic.ClassSep

/-- Class Separation (MK / NBG comprehension schema).
    For any predicate φ, `classSep φ` is the class {z | φ z}.
    In MK/NBG, this forms a *class* (not necessarily a set) from any predicate.
    The distinction between sets (elements of some class) and proper classes
    (classes that are not elements of any class) is a semantic property of the
    instance, not expressible in the typeclass alone.

    Math: ∀ φ, ∃ C (class), ∀ z, z ∈ C ↔ φ z
-/
class HasClassSep (U : Type u) [Membership U U] where
  classSep : (U → Prop) → U
  mem_classSep_iff : ∀ (φ : U → Prop) (z : U), z ∈ classSep φ ↔ φ z

end Foundations.Sets.Atomic.ClassSep

export Foundations.Sets.Atomic.ClassSep (HasClassSep)
