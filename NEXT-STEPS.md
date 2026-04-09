# Next Steps — Foundations

**Last updated:** 2026-04-10 12:00
**Author**: Julián Calderón Almendros

> Este archivo registra las fases de desarrollo planificadas.
> Ver [THOUGHTS.md](THOUGHTS.md) para la justificación de la arquitectura.
> Ver [NAMING-CONVENTIONS.md](NAMING-CONVENTIONS.md) §6 para las convenciones de migración.

---

## Mapa de dependencias entre fases

```
Phase 0 ──► Phase 1 ──► Phase 5 ──► Phase 6 ──► Phase 9
               │                         │
               ▼                         ▼
            Phase 2 ──► Phase 3 ──► Phase 4
                                         │
                              (Peano completo)
                                         │
                              Phase 6 completo
                                         │
                                    Phase 7 ──► Phase 8
                                         │
                                    Phase 9
```

---

## Phase 0: Arquitectura y Convenciones ✅ En curso

**Objetivo**: Establecer la visión, arquitectura y convenciones de nombres antes de escribir código.

**Entregables**:

- [x] `THOUGHTS.md` — visión del proyecto, arquitectura de capas, sistemas previstos
- [x] `NAMING-CONVENTIONS.md §6` — convenciones multi-sistema y guía de migración
- [ ] `DECISIONS.md` — ADR con la decisión de arquitectura (typeclasses vs. estructuras)
- [ ] `DECISIONS.md` — ADR con la estrategia de importación (dependencia vs. migración directa)

**Dependencias**: Ninguna
**Complejidad**: Simple

---

## Phase 1: Diseño de interfaces (typeclasses atómicos + bundles)

**Objetivo**: Construir la jerarquía de typeclasses que permite reutilizar teoremas
entre sistemas. Arquitectura: typeclasses **atómicos** (uno por axioma) +
**bundles** (fragmentos nombrados) + teoremas con requisitos mínimos.

Ver THOUGHTS.md §"2026-04-10 — Inventario universal" para el análisis completo.

### Phase 1a — Typeclasses atómicos del inventario S (conjuntos)

Cada archivo define UN typeclass y su notación/API inmediata. Sin probar teoremas aquí.

- [ ] `Foundations/Sets/Atomic/Ext.lean`     — `class HasExt (U) [Membership U U]`
- [ ] `Foundations/Sets/Atomic/Empty.lean`   — `class HasEmpty (U) [Membership U U]`
- [ ] `Foundations/Sets/Atomic/Pair.lean`    — `class HasPair (U) [Membership U U]`
- [ ] `Foundations/Sets/Atomic/Sep.lean`     — `class HasSep (U) [Membership U U]`
- [ ] `Foundations/Sets/Atomic/Union.lean`   — `class HasUnion (U) [Membership U U]`
- [ ] `Foundations/Sets/Atomic/Pow.lean`     — `class HasPow (U) [Membership U U]`
- [ ] `Foundations/Sets/Atomic/Inf.lean`     — `class HasInf (U) [Membership U U, HasEmpty U, HasSucc U]`
- [ ] `Foundations/Sets/Atomic/Found.lean`   — `class HasFound (U) [Membership U U, HasEmpty U]`
- [ ] `Foundations/Sets/Atomic/Repl.lean`    — `class HasRepl (U) [Membership U U]`
- [ ] `Foundations/Sets/Atomic/Choice.lean`  — `class HasChoice (U) [Membership U U]`
- [ ] `Foundations/Sets/Atomic/StratSep.lean`— `class HasStratSep (U) [Membership U U]` (para NF)
- [ ] `Foundations/Sets/Atomic/ClassSep.lean`— `class HasClassSep (U) [Membership U U]` (para MK/NBG)
- [ ] `Foundations/Sets/Atomic/CAC.lean`     — `class HasCAC (U) [Membership U U]` (para MK)

**Barrel**: `Foundations/Sets/Atomic.lean`

### Phase 1b — Typeclasses atómicos del inventario A (aritmética)

- [ ] `Foundations/Numeric/Atomic/Zero.lean`   — `class HasZero (N)`
- [ ] `Foundations/Numeric/Atomic/Succ.lean`   — `class HasSucc (N) [HasZero N]`; inyectividad, σ n ≠ 0
- [ ] `Foundations/Numeric/Atomic/Add.lean`    — `class HasAdd (N) [HasZero N, HasSucc N]`
- [ ] `Foundations/Numeric/Atomic/Mul.lean`    — `class HasMul (N) [HasZero N, HasSucc N, HasAdd N]`
- [ ] `Foundations/Numeric/Atomic/Ind.lean`    — `class HasInd (N) [HasZero N, HasSucc N]`

**Barrel**: `Foundations/Numeric/Atomic.lean`

### Phase 1c — Bundles = fragmentos axiomáticos nombrados

Cada bundle extiende atómicos sin añadir nuevos campos. Nombrados según la literatura.

**Set-theoretic bundles:**

- [ ] `Foundations/Sets/Bundles/ZFBasic.lean`
  — `class ZFBasic (U) extends HasExt U, HasEmpty U, HasPair U, HasSep U`
  — primer fragmento de ZFC: del vacío a la separación (orden del proyecto ZFCSetTheory)

- [ ] `Foundations/Sets/Bundles/ZFFinite.lean`
  — `class ZFFinite (U) extends ZFBasic U, HasUnion U, HasPow U, HasFound U`
  — ZFC hereditariamente finito (modelo: HFSet de Aczel)

- [ ] `Foundations/Sets/Bundles/Zermelo.lean`
  — `class ZermeloSet (U) extends ZFFinite U, HasInf U`
  — Z clásico (sin Replacement)

- [ ] `Foundations/Sets/Bundles/ZF.lean`
  — `class ZFSet (U) extends ZermeloSet U, HasRepl U`

- [ ] `Foundations/Sets/Bundles/ZFC.lean`
  — `class ZFCSet (U) extends ZFSet U, HasChoice U`

- [ ] `Foundations/Sets/Bundles/MK.lean`
  — `class MKSet (U) extends ZFCSet U, HasClassSep U, HasCAC U`

- [ ] `Foundations/Sets/Bundles/NF.lean`
  — `class NFSet (U) extends HasExt U, HasStratSep U`
  — NF: extensionalidad + comprensión estratificada, SIN fundación

- [ ] `Foundations/Sets/Bundles/KP.lean`
  — `class KPSet (U) extends HasExt U, HasEmpty U, HasPair U, HasUnion U`
  — Kripke-Platek (versión simplificada; la real añade restricciones de complejidad)

**Barrel**: `Foundations/Sets/Bundles.lean`

**Arithmetic bundles:**

- [ ] `Foundations/Numeric/Bundles/Robinson.lean`
  — `class RobinsonArith (N) extends HasZero N, HasSucc N, HasAdd N, HasMul N`
  — aritmética Q de Robinson (sin inducción; base para incompletitud)

- [ ] `Foundations/Numeric/Bundles/Peano.lean`
  — `class PeanoArith (N) extends RobinsonArith N, HasInd N`

**Barrel**: `Foundations/Numeric/Bundles.lean`

### Phase 1d — Primeros teoremas universales (con requisitos mínimos)

Cada teorema lleva exactamente los typeclasses atómicos que necesita:

- [ ] `Foundations/Sets/Universal/Basic.lean`
  — `inter`, `sdiff` como definiciones derivadas de `HasSep`
  — `empty_unique [HasExt, HasEmpty]`, `pair_comm [HasExt, HasPair]`
  — `sep_empty [HasEmpty, HasSep]`, `mem_inter_iff [HasSep]`

- [ ] `Foundations/Sets/Universal/Subset.lean`
  — `def subset [HasSep]`; `subset_refl`, `subset_trans`, `subset_antisymm [HasExt]`

- [ ] `Foundations/Sets/Universal/Cantor.lean`
  — `cantor_no_surjection [HasExt, HasPow, HasSep]`

**Barrel**: `Foundations/Sets/Universal.lean`

### Phase 1e — Instancias vacías para verificar la jerarquía

Antes de migrar código real, se comprueba que la jerarquía es correcta creando
instancias `sorry`-based temporales para `HFSet` y para un tipo abstracto `ZFCUniverse`:

- [ ] `Foundations/Sets/Interface/CheckAczel.lean` — `instance : ZFFinite HFSet` (sorry)
- [ ] `Foundations/Sets/Interface/CheckZFC.lean`   — `instance : ZFCSet ZFCUniverse` (sorry)

Estas se borran cuando Phase 6 provea las instancias reales.

**Barrel files principales**:
- [ ] `Foundations/Sets/Interface.lean` (re-exporta Atomic + Bundles + Universal)
- [ ] `Foundations/Numeric/Interface.lean`

**Dependencias**: Phase 0 completa; `Foundations.Prelim`
**Complejidad**: Complex (decisión de diseño de alto impacto, pero modular)

---

## Phase 2: FOL — Sintaxis y Sistema Deductivo

**Objetivo**: Formalizar la sintaxis de la lógica de primer orden y un sistema deductivo completo.

**Módulos**:

- [ ] `Foundations/FOL/Syntax/Terms.lean`
  — variables (índices de De Bruijn o nombres), constantes, función de aridad, términos inductivos
- [ ] `Foundations/FOL/Syntax/Formulas.lean`
  — fórmulas atómicas, conectivos (¬, ∧, ∨, →, ↔), cuantificadores (∀, ∃)
- [ ] `Foundations/FOL/Syntax/Substitution.lean`
  — sustitución libre de variables, lema de sustitución, variable fresca
- [ ] `Foundations/FOL/Syntax/Decidable.lean`
  — igualdad decidible en términos y fórmulas (necesario para Gödel numbering)
- [ ] `Foundations/FOL/Proof/Hilbert.lean`
  — axiomas lógicos, modus ponens, regla de generalización, deducción
- [ ] `Foundations/FOL/Proof/Properties.lean`
  — teorema de la deducción, monotonía, compactidad sintáctica

**Barrel files**:
- [ ] `Foundations/FOL/Syntax.lean`
- [ ] `Foundations/FOL/Proof.lean`

**Dependencias**: `Foundations.Prelim`; Peano para indexado de variables (opcional)
**Complejidad**: Complex

---

## Phase 3: FOL — Semántica y Completitud

**Objetivo**: Formalizar la semántica de estructuras y probar el teorema de completitud de Gödel.

**Módulos**:

- [ ] `Foundations/FOL/Semantics/Structure.lean`
  — `Structure α` = tipo `α` (dominio) + función de interpretación de símbolos
- [ ] `Foundations/FOL/Semantics/Satisfaction.lean`
  — relación `⊨` (satisfacción), `⊨` para teorías, validez universal
- [ ] `Foundations/FOL/Semantics/Consequence.lean`
  — consecuencia semántica `T ⊨ φ`, compacidad semántica, teorema de Löwenheim-Skolem (downward)
- [ ] `Foundations/FOL/Completeness/Henkin.lean`
  — extensión de Henkin, consistencia de la extensión, construcción del modelo canónico
- [ ] `Foundations/FOL/Completeness/Theorem.lean`
  — `T ⊢ φ ↔ T ⊨ φ` (teorema principal)

**Barrel files**:
- [ ] `Foundations/FOL/Semantics.lean`
- [ ] `Foundations/FOL/Completeness.lean`
- [ ] `Foundations/FOL.lean`

**Dependencias**: Phase 2 completa
**Complejidad**: Complex (construcción de Henkin es técnicamente exigente)

---

## Phase 4: Numeración de Gödel e Incompletitud

**Objetivo**: Probar los dos teoremas de incompletitud de Gödel usando Peano como base aritmética.

**Pre-requisito**: Phase 5 (migración de Peano) **debe preceder** a esta fase o ejecutarse en paralelo.
La numeración de Gödel es una función primitiva recursiva sobre ℕ.

**Módulos**:

- [ ] `Foundations/Arithmetic/Coding/GodelNumbering.lean`
  — codificación de términos, fórmulas y secuencias de prueba como naturales
  — decodificación, inyectividad de la codificación
- [ ] `Foundations/Arithmetic/Coding/PrimRec.lean`
  — funciones primitivas recursivas representables en PA (si no están ya en Peano)
- [ ] `Foundations/Arithmetic/Representability.lean`
  — toda función recursiva es representable en PA (teorema de Gödel-Kleene)
- [ ] `Foundations/Arithmetic/Incompleteness/DiagonalLemma.lean`
  — lema diagonal / lema del punto fijo para fórmulas: `∃ φ, T ⊢ φ ↔ ψ(⌈φ⌉)`
- [ ] `Foundations/Arithmetic/Incompleteness/First.lean`
  — sentencia de Gödel `G` tal que `T ⊬ G` y `T ⊬ ¬G` (si T es consistente)
- [ ] `Foundations/Arithmetic/Incompleteness/Second.lean`
  — `T ⊬ Con(T)` si T es consistente y extiende PA

**Barrel files**:
- [ ] `Foundations/Arithmetic/Coding.lean`
- [ ] `Foundations/Arithmetic/Incompleteness.lean`
- [ ] `Foundations/Arithmetic.lean`

**Dependencias**: Phase 2+3 completas; Phase 5 (Peano) completa o importada como dependencia
**Complejidad**: Complex

---

## Phase 5: Migración — Sistemas Numéricos (Peano)

**Objetivo**: Traer los sistemas numéricos del repositorio `Peano` a `Foundations`,
adaptados a las convenciones de nombres (ver NAMING-CONVENTIONS.md §6).

**Pre-migración (a hacer EN el repositorio Peano antes de traer aquí)**:

- [ ] Auditoría de nombres: comprobar que todo sigue NC-1–NC-10 + §6
- [ ] Añadir export blocks a todos los módulos
- [ ] Añadir copyright headers si faltan
- [ ] Proyectar todos los módulos en el REFERENCE.md de Peano
- [ ] Verificar compilación con `autoImplicit=false`

**Módulos en Foundations** (tras migración):

- [ ] `Foundations/Numeric/Nat/Basic.lean` — naturales de Peano, axiomas PA_*
- [ ] `Foundations/Numeric/Nat/Arithmetic.lean` — suma, producto, potencia
- [ ] `Foundations/Numeric/Nat/Order.lean` — orden estricto y no estricto
- [ ] `Foundations/Numeric/Nat/Sets.lean` — conjuntos y tuplas de naturales
- [ ] `Foundations/Numeric/Int/Basic.lean` — enteros (cuando estén en Peano)
- [ ] `Foundations/Numeric/Rat/Basic.lean` — racionales (cuando estén en Peano)
- [ ] `Foundations/Numeric/CauchySeq.lean` — secuencias de Cauchy (números algebraicos / aprox.)
- [ ] Instanciar `NumericSystem` de Phase 1 para cada tipo numérico

**Barrel files**:
- [ ] `Foundations/Numeric/Nat.lean`
- [ ] `Foundations/Numeric/Int.lean`
- [ ] `Foundations/Numeric/Rat.lean`
- [ ] `Foundations/Numeric.lean`

**Dependencias**: Phase 1; repositorio `Peano` pre-migrado
**Complejidad**: Medium (mecánica, pero requiere auditoría sistemática)

---

## Phase 6: Migración — Sistemas de Conjuntos

**Objetivo**: Traer AczelSetTheory, ZFCSetTheory (completado) y MKplusCAC a `Foundations`.

### Phase 6a — Completar ZFCSetTheory (en el repo ZFC, antes de migrar)

- [ ] Probar `ZF_Repl` (Reemplazamiento) en ZFCSetTheory
- [ ] Probar `ZF_Choice` (Axioma de Elección) en ZFCSetTheory
- [ ] Auditoría completa de nombres para Foundations
- [ ] Añadir export blocks
- [ ] Proyectar en REFERENCE.md de ZFCSetTheory

### Phase 6b — Pre-migración de AczelSetTheory (en el repo Aczel)

- [ ] Auditoría de nombres: AZ_* para axiomas, convenciones NC-1–NC-10
- [ ] Añadir/verificar export blocks
- [ ] Proyectar en REFERENCE.md

### Phase 6c — Pre-migración de MKplusCAC (en el repo MK)

- [ ] Ampliar MKplusCAC más allá de los axiomas básicos
- [ ] Auditoría de nombres: MK_* para axiomas
- [ ] Añadir export blocks

### Phase 6d — Migración a Foundations

- [ ] `Foundations/Sets/Aczel/` — módulos de AczelSetTheory adaptados
  - Instancia `instance AczelIsSetAxioms : SetAxioms AczelUniverse`
- [ ] `Foundations/Sets/ZFC/` — módulos de ZFCSetTheory adaptados
  - Instancia `instance ZFCIsSetAxioms : SetAxioms ZFCUniverse`
- [ ] `Foundations/Sets/MK/` — módulos de MKplusCAC adaptados
  - Instancia `instance MKIsZFCAxioms : ZFCAxioms MKUniverse`
  - (hereda automáticamente `SetAxioms` vía ZFC)

**Barrel files**:
- [ ] `Foundations/Sets/Aczel.lean`
- [ ] `Foundations/Sets/ZFC.lean`
- [ ] `Foundations/Sets/MK.lean`
- [ ] `Foundations/Sets.lean`

**Dependencias**: Phase 1; cada repo pre-migrado; ZFC completo (Phase 6a)
**Complejidad**: Complex

---

## Phase 7: Forcing

**Objetivo**: Implementar el framework de forcing para probar resultados de independencia.

**Pre-requisito**: ZFC completo (Phase 6a+6d).

**Módulos**:

- [ ] `Foundations/Forcing/Basic/Poset.lean` — órdenes parciales, densidad, filtros
- [ ] `Foundations/Forcing/Basic/Names.lean` — nombres de forcing (`P`-nombres en `M`)
- [ ] `Foundations/Forcing/Basic/Relation.lean` — relación de forcing `p ⊩ φ`, definición por recursión
- [ ] `Foundations/Forcing/Basic/Properties.lean` — monotonía, densidad, lema de verdad
- [ ] `Foundations/Forcing/GenericExtension/Construction.lean` — construcción de `M[G]`
- [ ] `Foundations/Forcing/GenericExtension/ZFCVerification.lean` — `M[G] ⊨ ZFC`
- [ ] `Foundations/Forcing/Independence/CH.lean` — `ZFC + ¬CH` es consistente (Cohen forcing)
- [ ] `Foundations/Forcing/Independence/CHTrue.lean` — `ZFC + CH` es consistente (constructible L)
- [ ] `Foundations/Forcing/Library/Cohen.lean` — Cohen forcing (añadir reales de Cohen)
- [ ] `Foundations/Forcing/Library/Collapsing.lean` — Lévy collapse
- [ ] `Foundations/Forcing/Library/Sacks.lean` — Sacks forcing
- [ ] `Foundations/Forcing/Library/Prikry.lean` — Prikry forcing (cambio de cofinalidad)
- [ ] `Foundations/Forcing/ClassForcing.lean` — forcing de clases para MK/TG

**Barrel files**:
- [ ] `Foundations/Forcing/Basic.lean`
- [ ] `Foundations/Forcing/GenericExtension.lean`
- [ ] `Foundations/Forcing/Independence.lean`
- [ ] `Foundations/Forcing/Library.lean`
- [ ] `Foundations/Forcing.lean`

**Dependencias**: Phase 6 (ZFC completo + migrado)
**Complejidad**: Complex (la formalización del forcing es técnicamente muy exigente)

---

## Phase 8: Sistema de Modelos y Jerarquías

**Objetivo**: Formalizar las jerarquías de conjuntos que sirven de modelos para los sistemas axiomáticos.

**Módulos**:

- [ ] `Foundations/Models/VonNeumann/Cumulative.lean` — jerarquía acumulativa `V_α`
- [ ] `Foundations/Models/VonNeumann/Rank.lean` — función rango `ρ(x)`
- [ ] `Foundations/Models/VonNeumann/Inaccessible.lean` — `V_κ ⊨ ZFC` para κ inaccesible
- [ ] `Foundations/Models/Constructible/L.lean` — el universo constructible `L`
- [ ] `Foundations/Models/Constructible/GCHinL.lean` — `L ⊨ GCH + AC`
- [ ] `Foundations/Models/Grothendieck/Universes.lean` — universos de Grothendieck
- [ ] `Foundations/Models/LargeCardinals/Inaccessible.lean` — cardinales inaccesibles
- [ ] `Foundations/Models/LargeCardinals/Mahlo.lean` — cardinales de Mahlo
- [ ] `Foundations/Models/LargeCardinals/Measurable.lean` — cardinales medibles
- [ ] `Foundations/Models/LargeCardinals/Supercompact.lean` — cardinales supercompactos

**Barrel files**:
- [ ] `Foundations/Models/VonNeumann.lean`
- [ ] `Foundations/Models/Constructible.lean`
- [ ] `Foundations/Models/Grothendieck.lean`
- [ ] `Foundations/Models/LargeCardinals.lean`
- [ ] `Foundations/Models.lean`

**Dependencias**: Phase 6 (ZFC completo); Phase 7 (forcing) para modelos de forcing
**Complejidad**: Complex

---

## Phase 9: Capa de Teoremas Universales

**Objetivo**: Reunir todos los teoremas que valen en *cualquier* sistema de fundamentación
compatible con la interfaz `SetAxioms`, evitando duplicación entre sistemas.

**Módulos**:

- [ ] `Foundations/Sets/Interface/Empty.lean` — `empty_unique`, `not_mem_empty`
- [ ] `Foundations/Sets/Interface/Pair.lean` — `mem_pair_iff`, `pair_comm`
- [ ] `Foundations/Sets/Interface/Union.lean` — `mem_union_iff`, `union_comm`, `union_assoc`
- [ ] `Foundations/Sets/Interface/Sep.lean` — `mem_sep_iff`, `sep_subset`
- [ ] `Foundations/Sets/Interface/Powerset.lean` — `mem_powerset_iff`, `powerset_mono`
- [ ] `Foundations/Sets/Interface/Subset.lean` — `subset_refl`, `subset_trans`, `subset_antisymm`
- [ ] `Foundations/Sets/Interface/Cantor.lean` — `cantor_no_surjection` para cualquier `SetAxioms U`

**Nota**: Estos módulos prueban teoremas *una sola vez* para `[SetAxioms U]`.
Las instancias de ZFC, Aczel y MK los heredan automáticamente sin re-demostración.

**Dependencias**: Phase 1 (interfaces); Phase 5+6 (instancias concretas)
**Complejidad**: Medium

---

## Fases Futuras

### Phase 10: Tarski-Grothendieck

**Objetivo**: Formalizar TG y TG + Principio de Vopěnka.

**Módulos**: `Foundations/Sets/TG/`, `Foundations/Sets/TGVopenka/`
**Dependencias**: Phase 6 (MK completo)
**Complejidad**: Complex

### Phase 11: NBG, Kripke-Platek, NF

**Objetivo**: Formalizar los sistemas restantes de la jerarquía.

**Módulos**: `Foundations/Sets/NBG/`, `Foundations/Sets/KP/`, `Foundations/Sets/NF/`
**Dependencias**: Phase 6
**Complejidad**: Complex (NF es especialmente difícil por la estratificación)

### Phase 12: Teoría de Categorías

**Objetivo**: Capa transversal categórica sobre los sistemas de conjuntos.

**Módulos**: `Foundations/Categories/`
**Dependencias**: Phase 9 (capa universal)
**Complejidad**: Complex

### Phase 13: HoTT

**Objetivo**: Perspectiva de la teoría de tipos homotópica.

**Módulos**: `Foundations/HoTT/`
**Dependencias**: Phase 1 (interfaces); Phase 12 (categorías, opcionalmente)
**Complejidad**: Complex

---

## Phase Status Summary

| Phase | Descripción | Dependencias | Estado |
|-------|-------------|--------------|--------|
| 0 | Arquitectura y convenciones | — | 🔄 En curso |
| 1 | Interfaces (typeclasses) | 0 | ❌ Pendiente |
| 2 | FOL Sintaxis + Deductivo | 0 | ❌ Pendiente |
| 3 | FOL Semántica + Completitud | 2 | ❌ Pendiente |
| 4 | Gödel + Incompletitud | 2+3+5 | ❌ Pendiente |
| 5 | Migración: Numéricos (Peano) | 1 | ❌ Pendiente |
| 6 | Migración: Conjuntos (Aczel+ZFC+MK) | 1+6a | ❌ Pendiente |
| 7 | Forcing | 6 | ❌ Pendiente |
| 8 | Modelos y Jerarquías | 6+7 | ❌ Pendiente |
| 9 | Teoremas universales | 1+5+6 | ❌ Pendiente |
| 10 | TG + Vopěnka | 6 | ❌ Pendiente |
| 11 | NBG, KP, NF | 6 | ❌ Pendiente |
| 12 | Categorías | 9 | ❌ Pendiente |
| 13 | HoTT | 1+12 | ❌ Pendiente |

---

## Estructura de directorios objetivo

```
Foundations/
├── Prelim.lean                      ✅ Completo
│
├── Sets/                            Phases 1+6+9
│   ├── Atomic/                      Phase 1a — un typeclass por axioma S
│   │   ├── Ext.lean, Empty.lean, Pair.lean, Sep.lean
│   │   ├── Union.lean, Pow.lean, Inf.lean, Found.lean
│   │   ├── Repl.lean, Choice.lean
│   │   └── StratSep.lean, ClassSep.lean, CAC.lean
│   ├── Bundles/                     Phase 1c — fragmentos nombrados
│   │   ├── ZFBasic.lean, ZFFinite.lean, Zermelo.lean
│   │   ├── ZF.lean, ZFC.lean, MK.lean
│   │   ├── NF.lean, KP.lean
│   │   └── (TG.lean, NBG.lean — Phase 10+11)
│   ├── Universal/                   Phase 1d — teoremas con requisitos mínimos
│   │   ├── Basic.lean, Subset.lean, Cantor.lean
│   │   └── (más en Phase 9)
│   ├── Aczel/                       Phase 6
│   ├── ZFC/                         Phase 6
│   ├── MK/                          Phase 6
│   ├── TG/                          Phase 10
│   ├── NBG/                         Phase 11
│   ├── KP/                          Phase 11
│   └── NF/                          Phase 11
│
├── Numeric/                         Phase 5
│   ├── Atomic/                      Phase 1b — un typeclass por axioma A
│   │   ├── Zero.lean, Succ.lean, Add.lean, Mul.lean, Ind.lean
│   ├── Bundles/                     Phase 1c
│   │   ├── Robinson.lean, Peano.lean
│   ├── Nat/                         Phase 5 (de Peano repo)
│   ├── Int/
│   ├── Rat/
│   └── CauchySeq.lean
│
├── FOL/                             Phase 2+3
│   ├── Syntax/
│   │   ├── Terms.lean, Formulas.lean, Substitution.lean, Decidable.lean
│   ├── Proof/
│   │   ├── Hilbert.lean, Properties.lean
│   ├── Semantics/
│   │   ├── Structure.lean, Satisfaction.lean, Consequence.lean
│   └── Completeness/
│       ├── Henkin.lean, Theorem.lean
│
├── Arithmetic/                      Phase 4
│   ├── Coding/
│   │   ├── GodelNumbering.lean, PrimRec.lean
│   ├── Representability.lean
│   └── Incompleteness/
│       ├── DiagonalLemma.lean, First.lean, Second.lean
│
├── Models/                          Phase 8
│   ├── VonNeumann/
│   ├── Constructible/
│   ├── Grothendieck/
│   └── LargeCardinals/
│
├── Forcing/                         Phase 7
│   ├── Basic/
│   ├── GenericExtension/
│   ├── Independence/
│   └── Library/
│
├── Categories/                      Phase 12
└── HoTT/                            Phase 13
```
