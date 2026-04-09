# Naming Conventions — Mathlib Style

> Permanent reference document for this project.
> All rules are based on the
> [Mathlib Naming Conventions](https://leanprover-community.github.io/contribute/naming.html),
> adapted to the project's specific domain.

**Last updated:** 2026-04-09 12:00
**Author**: Julián Calderón Almendros

---

## 1. Capitalization Rules

| Declaration type | Convention | Example |
|------------------|------------|---------|
| Theorems, lemmas (Prop terms) | `snake_case` | `union_comm`, `mem_powerset_iff` |
| Types, Props, Structures, Classes | `UpperCamelCase` | `IsFunction`, `IsNat`, `BoolAlg.Basic` |
| Functions returning `Type` | by return type | `powerset` (→ U → `snake`), `IsNat` (→ Prop → `Upper`) |
| Other `Type` terms | `lowerCamelCase` | `successor`, `fromPeano`, `binUnion` |
| Acronyms | as group upper/lower | `ZFC` (namespace), `zfc` (in snake_case) |

---

## 2. Symbol-to-Word Dictionary

| Symbol | In names | Notes |
|--------|----------|-------|
| ∈ | `mem` | `x ∈ A` → `mem` |
| ∉ | `not_mem` | |
| ∪ | `union` | binary |
| ∩ | `inter` | binary |
| ⋃ | `sUnion` | `s` = "set of sets" |
| ⋂ | `sInter` | idem |
| ⊆ | `subset` | non-strict |
| ⊂ | `ssubset` | strict (extra `s`) |
| 𝒫 | `powerset` | |
| σ | `succ` | |
| ∅ | `empty` | |
| △ | `symmDiff` | |
| ᶜ | `compl` | complement |
| \ | `sdiff` | set difference |
| ×ₛ | `prod` | cartesian product |
| ⟂ | `disjoint` | |
| = | `eq` | often omitted |
| ≠ | `ne` | |
| → | `of` / implicit | conclusion goes first |
| ↔ | `iff` | suffix |
| ¬ | `not` | |
| ∃ | `exists` | |
| ∀ | `forall` | |
| ∘ | `comp` | composition |
| ⁻¹ | `inv` | inverse |
| + | `add` | |
| \* / · | `mul` | |
| − | `sub` (binary) / `neg` (unary) | |
| ^ | `pow` | |
| / | `div` | |
| ∣ | `dvd` | divides |
| ≤ | `le` | |
| < | `lt` | |
| ≥ | `ge` | only for argument swap |
| > | `gt` | only for argument swap |
| 0 | `zero` | |
| 1 | `one` | |

---

## 3. Name Formation Rules (12 rules)

### RULE 1 — Conclusion first, hypotheses with `_of_`

The name describes **what is proved**, not how. Hypotheses are added with `_of_`:

```
-- Pattern: A → B → C
-- Name:    c_of_a_of_b
-- Order:   conclusion_of_hypothesis1_of_hypothesis2

-- Example:
-- Theorem: isNat n → isNat (σ n)
-- Name:    isNat_succ_of_isNat
--          ^^^^^^^^^ ^^^^^^^^^^
--          conclusion hypothesis
```

### RULE 2 — Biconditionals carry suffix `_iff`

```
-- Theorem: x ∈ (𝒫 A) ↔ x ⊆ A
-- Name:    mem_powerset_iff
--          ^^^ ^^^^^^^^ ^^^
--          ∈    𝒫        ↔
```

### RULE 3 — Eliminate `_wc` — Use `.mp` / `.mpr` or `_of_`

The `_wc` suffix (if used historically) is replaced by Mathlib convention:

```
-- For forward direction of an iff:
--    inter_eq_empty_iff_disjoint.mp
-- For backward direction:
--    inter_eq_empty_iff_disjoint.mpr
-- As standalone theorem:
--    disjoint_of_inter_eq_empty    (conclusion_of_hypothesis)
```

### RULE 4 — Algebraic properties → short axiomatic name

```
-- commutativity:   union_comm, inter_comm
-- associativity:   inter_assoc, union_assoc
-- absorption:      union_inter_self
-- distributivity:  union_inter_distrib_left
```

**Standard axiomatic suffixes (Mathlib):**

| Suffix | Meaning | Example |
|--------|---------|---------|
| `_comm` | commutativity | `union_comm` |
| `_assoc` | associativity | `inter_assoc` |
| `_refl` | reflexivity | `subset_refl` |
| `_irrefl` | irreflexivity | `ssubset_irrefl` |
| `_symm` | symmetry | `disjoint_symm` |
| `_trans` | transitivity | `subset_trans` |
| `_antisymm` | antisymmetry | `subset_antisymm` |
| `_asymm` | asymmetry | `ssubset_asymm` |
| `_inj` | injectivity (iff) | `succ_inj` (σ a = σ b ↔ a = b) |
| `_injective` | injectivity (pred) | `succ_injective` |
| `_self` | operation with itself | `union_self` (A ∪ A = A) |
| `_left` / `_right` | lateral variant | `union_subset_left` |
| `_cancel` | cancellation | `add_left_cancel` |
| `_mono` | monotonicity | `powerset_mono` |

### RULE 5 — Predicates as prefix, operations in infix order

```
-- Predicate as prefix:   isNat_zero (not zero_is_nat)
-- Exception:             succ_injective (_injective, _surjective are always suffix)
```

### RULE 6 — Standard abbreviations for frequent conditions

| Instead of | Use | Meaning |
|-----------|-----|---------|
| `zero_lt_x` | `pos` | x > 0 |
| `x_lt_zero` | `neg` | x < 0 |
| `x_le_zero` | `nonpos` | x ≤ 0 |
| `zero_le_x` | `nonneg` | x ≥ 0 |

### RULE 7 — Definitions with `Is` for Prop predicates

```
-- Definition (Prop): def IsNat (n : U) : Prop := ...     (UpperCamelCase)
-- In theorem names:  isNat_zero, isNat_succ, isNat_of_mem (lowerCamelCase in snake_case)
```

### RULE 8 — Functions/constructors non-Prop: `lowerCamelCase`

```
-- powerset (not PowerSetOf)  — lowerCamelCase, remove "Of"
-- union (not BinUnion)       — "Bin" removed (binary by arity)
-- sep (not SpecSet)          — "sep" = Mathlib standard for separation
-- comp (not FunctionComposition)
-- image (not ImageSet)
```

### RULE 9 — Specifications: `_iff` and `mem_X_iff`

The pattern `X_is_specified` is replaced by `mem_X_iff`:

```
-- mem_succ_iff      (was: successor_is_specified)
-- mem_inter_iff     (was: BinInter_is_specified)
-- mem_union_iff     (was: BinUnion_is_specified)
-- mem_sep_iff       (was: SpecSet_is_specified)
-- mem_sdiff_iff     (was: Difference_is_specified)
```

### RULE 10 — Uniqueness and existence

```
-- inter_unique      (was: BinInterUniqueSet)
-- powerset_unique   (was: PowerSetExistsUnique)
-- sUnion_unique     (was: UnionExistsUnique)
```

### RULE 11 — Names with `_left` / `_right`

```
-- subset_union_left    — A ⊆ (A ∪ B), subset is left argument
-- subset_union_right   — B ⊆ (A ∪ B), subset is right argument
```

### RULE 12 — Named theorems (proper names)

```
-- cantor_no_surjection          — proper name + description (OK in Mathlib)
-- cantor_schroeder_bernstein    — proper name (kept as-is)
```

> **NOTE:** Mathematical proper names are kept as-is in Mathlib.
> Only operational words are normalized (`mem`, `union`, etc.).

---

## 4. Quick Reference Tables

### 4.1 Definitions — common renamings

| Before | After | Rationale |
|--------|-------|-----------|
| `BinInter` | `inter` | remove "Bin" |
| `BinUnion` | `union` | remove "Bin" |
| `PowerSetOf` | `powerset` | lowerCamelCase, remove "Of" |
| `UnionSet` | `sUnion` | "s" = set-of-sets |
| `SpecSet` | `sep` | Mathlib standard |
| `successor` | `succ` | standard abbreviation |
| `FunctionComposition` | `comp` | standard abbreviation |
| `IdFunction` | `id` | standard abbreviation |
| `InverseFunction` | `inv` | standard abbreviation |
| `ImageSet` | `image` | simplification |
| `PreimageSet` | `preimage` | simplification |
| `Restriction` | `restrict` | simplification |
| `isNat` | `IsNat` | UpperCamelCase (Prop) |
| `isSingleValued` | `IsSingleValued` | UpperCamelCase (Prop) |
| `isInductive` | `IsInductive` | UpperCamelCase |

### 4.2 Theorems — `_is_specified` → `mem_X_iff`

| Before | After | Breakdown |
|--------|-------|-----------|
| `PowerSet_is_specified` | `mem_powerset_iff` | mem + 𝒫 + ↔ |
| `successor_is_specified` | `mem_succ_iff` | mem + σ + ↔ |
| `BinInter_is_specified` | `mem_inter_iff` | mem + ∩ + ↔ |
| `BinUnion_is_specified` | `mem_union_iff` | mem + ∪ + ↔ |
| `SpecSet_is_specified` | `mem_sep_iff` | mem + sep + ↔ |

### 4.3 Theorems — algebraic properties

| Before | After | Breakdown |
|--------|-------|-----------|
| `BinUnion_commutative` | `union_comm` | ∪ + commutativity |
| `BinInter_commutative` | `inter_comm` | ∩ + commutativity |
| `BinInter_associative` | `inter_assoc` | ∩ + associativity |
| `subseteq_reflexive` | `subset_refl` | ⊆ + reflexivity |
| `subseteq_transitive` | `subset_trans` | ⊆ + transitivity |
| `subseteq_antisymmetric` | `subset_antisymm` | ⊆ + antisymmetry |

---

## 5. Migration Note

During development, names are renamed progressively following these conventions.
Priority order for migration:

1. Base modules (axioms): `Extension`, `Specification`, `Union`, `PowerSet`
2. Natural numbers: `Nat.Basic` + arithmetic modules
3. Functions and relations: `Functions`, `Relations`
4. Derived structures: Boolean algebras, cardinality, etc.

Each rename is verified with full compilation before proceeding.

---

## 6. Multi-System Architecture — Naming Conventions

This section governs how the existing source repositories (Peano, AczelSetTheory,
ZFCSetTheory, MKplusCAC) and future systems are named and namespaced within
`Foundations`. Read this section **before** migrating code from any source repo.

---

### 6.1 Namespace Hierarchy

Every system maps to a sub-namespace of `Foundations`. The mapping is:

```
Foundations                          -- root (Prelim.lean lives here)
Foundations.FOL                      -- Layer 0: first-order logic
Foundations.FOL.Syntax               -- terms, formulas, substitution
Foundations.FOL.Proof                -- deductive system
Foundations.FOL.Semantics            -- structures, satisfaction
Foundations.FOL.Completeness         -- Henkin construction, main theorem
Foundations.Arithmetic               -- Layer 0: Gödel numbering
Foundations.Arithmetic.Coding        -- encoding syntax as ℕ
Foundations.Arithmetic.Incompleteness
Foundations.Numeric                  -- Level 1: numeric systems
Foundations.Numeric.Nat              -- Peano naturals
Foundations.Numeric.Int              -- integers
Foundations.Numeric.Rat              -- rationals
Foundations.Numeric.CauchySeq       -- Cauchy approximations
Foundations.Sets                     -- Level 2: set theories
Foundations.Sets.Interface           -- abstract typeclass + universal theorems
Foundations.Sets.Aczel               -- AczelSetTheory
Foundations.Sets.ZFC                 -- ZFCSetTheory
Foundations.Sets.MK                  -- MKplusCAC
Foundations.Sets.TG                  -- Tarski-Grothendieck (future)
Foundations.Sets.NBG                 -- von Neumann-Bernays-Gödel (future)
Foundations.Sets.KP                  -- Kripke-Platek (future)
Foundations.Sets.NF                  -- New Foundations (future)
Foundations.Models                   -- model theory and hierarchies
Foundations.Models.VonNeumann        -- cumulative hierarchy V_α
Foundations.Models.Constructible     -- constructible universe L
Foundations.Models.Grothendieck      -- Grothendieck universes
Foundations.Models.LargeCardinals    -- large cardinal hierarchy
Foundations.Forcing                  -- Cohen forcing framework
Foundations.Forcing.Library          -- canonical forcing conditions
Foundations.Categories               -- category theory (future)
Foundations.HoTT                     -- homotopy type theory (future)
```

**Rule NC-11**: Every module declares exactly the namespace that corresponds to its
path. `Foundations/Sets/ZFC/Extensionality.lean` → `namespace Foundations.Sets.ZFC.Extensionality`.

---

### 6.2 Axiom Tag Table

Each foundational system uses a fixed uppercase tag for its axioms.
The tag immediately precedes the descriptor with no extra underscore: `TAG_Descriptor`.

| System | Tag | Canonical axiom examples |
|--------|-----|--------------------------|
| FOL (logical axioms) | `FOL_` | `FOL_MP`, `FOL_Gen`, `FOL_Spec`, `FOL_Eq` |
| Peano Arithmetic | `PA_` | `PA_Zero`, `PA_Succ`, `PA_Add`, `PA_Mul`, `PA_Ind` |
| Aczel Set Theory | `AZ_` | `AZ_Ext`, `AZ_Found`, `AZ_Pair`, `AZ_Union`, `AZ_Sep`, `AZ_Inf` |
| ZFC | `ZF_` | `ZF_Ext`, `ZF_Empty`, `ZF_Pair`, `ZF_Sep`, `ZF_Union`, `ZF_Pow`, `ZF_Inf`, `ZF_Found`, `ZF_Repl`, `ZF_Choice` |
| Morse-Kelley + CAC | `MK_` | `MK_Ext`, `MK_Sep`, `MK_Union`, `MK_Pow`, `MK_Inf`, `MK_Found`, `MK_Repl`, `MK_Choice`, `MK_CAC` |
| Tarski-Grothendieck | `TG_` | `TG_Ext`, `TG_Pair`, `TG_Univ`, `TG_Choice` |
| NBG | `NBG_` | `NBG_Ext`, `NBG_Sep`, `NBG_Class` |
| Kripke-Platek | `KP_` | `KP_Ext`, `KP_Found`, `KP_Pair`, `KP_Sep`, `KP_Coll` |
| New Foundations | `NF_` | `NF_Ext`, `NF_CompStrat` (stratified comprehension) |

**Rule NC-12**: Axioms that were named differently in the source repo **must be renamed**
to follow the `TAG_Descriptor` pattern before migration. The migration checklist (§6.5)
includes this step explicitly.

---

### 6.3 Typeclass Naming

Typeclasses that abstract over a foundational system follow `UpperCamelCase` + descriptive suffix:

| Typeclass | Meaning |
|-----------|---------|
| `SetOps U` | Provides basic set operations on a universe type `U` |
| `SetAxioms U [SetOps U]` | The axioms hold for `U` |
| `ZFCAxioms U [SetAxioms U]` | Full ZFC (including Replacement and Choice) holds |
| `MKAxioms U [ZFCAxioms U]` | MK extension: classes + CAC |
| `TGAxioms U [ZFCAxioms U]` | TG extension: Grothendieck universes |
| `NumericSystem α` | An ordered numeric system |
| `ForcingPoset P` | A partial order `P` suitable as forcing conditions |

Instances follow the pattern `instance SystemNameIsTypeclassName`:

```lean
instance ZFCIsSetAxioms : SetAxioms ZFCUniverse := { ... }
instance MKIsZFCAxioms  : ZFCAxioms MKUniverse  := { ... }
```

**Rule NC-13**: Never use `abbrev` for typeclass aliases across systems — use `instance`
with the full chain, so Lean can synthesize through the hierarchy automatically.

---

### 6.4 Cross-System Theorem Naming

When a theorem holds in multiple systems, there are three patterns depending on context:

**Pattern A — Typeclass-universal theorem** (Capa 2):
Proved once for any `[SetAxioms U]`. Lives in `Foundations.Sets.Interface`.
Name: plain `subject_predicate`, no system prefix.

```lean
-- In Foundations/Sets/Interface/Empty.lean
theorem empty_unique [SetAxioms U] : ... := ...
```

**Pattern B — System-specific proof** (Capa 3):
A proof that uses properties specific to one system (e.g., ZFC's Replacement).
Name: same `subject_predicate` pattern, qualified by namespace.

```lean
-- In Foundations/Sets/ZFC/Cardinals.lean
namespace Foundations.Sets.ZFC
theorem card_equiv_class_of_repl : ...  -- uses ZF_Repl specifically
end Foundations.Sets.ZFC
```

**Pattern C — Lifting theorem**:
A theorem that says "since MK extends ZFC, theorem X from ZFC holds in MK".
Name: `X` is automatically available in MK context via the typeclass instance chain.
No separate theorem needed — Lean's typeclass synthesis handles this.

**Rule NC-14**: If a theorem holds universally (Pattern A), **do not** copy its proof into
the system-specific module. Instead, define the typeclass instance and rely on A.
Duplication is the primary problem this architecture solves.

---

### 6.5 Pre-Migration Checklist (per source repository)

Before bringing a source repo into `Foundations`, complete all items for that repo.
This checklist should be run on the **source repo** before any migration commit.

#### Checklist — `Peano`

- [ ] All axioms renamed to `PA_*` pattern
- [ ] All `namespace` declarations updated to map to `Foundations.Numeric.*`
- [ ] All exported theorems follow `subject_predicate` snake_case
- [ ] All functions follow `lowerCamelCase` (NC-4)
- [ ] All Prop definitions follow `UpperCamelCase` (NC-3)
- [ ] `autoImplicit=false` set in lakefile or per-file
- [ ] Export blocks present in every module
- [ ] Copyright header on every `.lean` file: `Author: Julián Calderón Almendros`
- [ ] REFERENCE.md in Peano repo is up to date
- [ ] Full compilation passes with zero sorry

#### Checklist — `AczelSetTheory`

- [ ] All axioms renamed to `AZ_*` pattern
- [ ] Namespace → `Foundations.Sets.Aczel.*`
- [ ] Export blocks
- [ ] `autoImplicit=false`
- [ ] Copyright headers
- [ ] Decide: which HFSet names map to which `Foundations.Sets.Interface` names?
  (e.g., Aczel's `HFSet.mem` → `mem` in `SetOps`)
- [ ] Typeclass instance `AczelIsSetAxioms : SetAxioms AczelUniverse` drafted
- [ ] Full compilation passes

#### Checklist — `ZFCSetTheory`

- [ ] `ZF_Repl` proven (Replacement) — **blocker**
- [ ] `ZF_Choice` proven (Axiom of Choice) — **blocker**
- [ ] All axioms renamed to `ZF_*` pattern
- [ ] Namespace → `Foundations.Sets.ZFC.*`
- [ ] Export blocks
- [ ] `autoImplicit=false`
- [ ] Copyright headers
- [ ] Typeclass instance `ZFCIsZFCAxioms : ZFCAxioms ZFCUniverse` drafted
- [ ] Cross-reference with `SetOps` interface: verify all operations are present
- [ ] Full compilation passes

#### Checklist — `MKplusCAC`

- [ ] Expand beyond axioms: prove first consequences
- [ ] All axioms renamed to `MK_*` pattern
- [ ] Namespace → `Foundations.Sets.MK.*`
- [ ] Export blocks
- [ ] `autoImplicit=false`
- [ ] Copyright headers
- [ ] Typeclass instance `MKIsZFCAxioms : ZFCAxioms MKUniverse` drafted
  (MK extends ZFC — this instance allows importing all ZFC theorems)
- [ ] Full compilation passes

---

### 6.6 Import Strategy: Dependency vs. Direct Migration

Two options for bringing source repos into `Foundations`:

**Option A — Dependency (recommended for now)**:
Add `require` in `lakefile.lean`. The source repo remains independent.
Pros: no code duplication; source repos remain usable standalone.
Cons: namespace adaptation requires wrappers; `lakefile.lean` dependencies must be kept in sync.

```lean
-- lakefile.lean
require ZfcSetTheory from git
  "https://github.com/julian1c2a/ZfcSetTheory" @ "master"
```

**Option B — Direct migration**:
Copy `.lean` files into `Foundations/Sets/ZFC/`, rename namespaces, add export blocks.
Pros: full control; single repo; no external dependency versioning.
Cons: source repos and Foundations diverge; must keep both in sync manually.

**Decision rule**: Use Option A until the source repo has passed its pre-migration checklist
and the Foundations interface layer (Phase 1) is stable. Then evaluate Option B for
systems that are considered stable/frozen.

---

### 6.7 FOL Symbol Extensions

The symbol-to-word dictionary (§2) extended for meta-logical and forcing notation:

| Symbol | In names | Context |
|--------|----------|---------|
| `⊢` | `provable` / `proves` | `T_proves_phi`, `consistent_of_not_provable` |
| `⊨` | `models` / `satisfies` | `T_models_phi`, `satisfies_iff` |
| `⌈·⌉` | `code` / `gn` | `gn_formula`, `code_of_term` (Gödel number) |
| `Con(T)` | `consistent` | `consistent_PA`, `consistent_of_not_provable_false` |
| `⊩` | `forces` | `forces_iff`, `p_forces_phi` |
| `M[G]` | `generic_ext` | `generic_ext_models_ZFC` |
| `V_α` | `vrank` | `vrank_succ`, `mem_vrank_iff` |
| `L` | `constructible` | `constructible_mem_iff`, `gch_in_L` |
| `κ` (cardinal) | `card` | `card_le`, `card_inaccessible` |
| `λ` (limit ord.) | `limit` | `limit_ord`, `omega_is_limit` |
| `ω` (first inf. ord) | `omega` | `omega_is_limit`, `nat_lt_omega` |
