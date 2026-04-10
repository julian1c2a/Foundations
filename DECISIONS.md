# Design Decisions — Foundations

**Last updated:** 2026-04-09 00:00
**Author**: Julián Calderón Almendros

Architectural Decision Records (ADR) for this project.
Each entry records *what* was decided and *why*, for future reference.

---

## ADR-001: No Mathlib dependency

**Date**: 2025-01-01
**Status**: Accepted

**Decision**: This project does not depend on Mathlib.

**Rationale**: [Explain why — e.g., educational goals, performance, avoiding API churn, etc.]

**Consequences**: All necessary infrastructure (ExistsUnique, etc.) must be built from scratch.

---

## ADR-002: autoImplicit = false

**Date**: 2025-01-01
**Status**: Accepted

**Decision**: `moreServerArgs := #["-DautoImplicit=false"]` is set in `lakefile.lean`.

**Rationale**: Explicit type annotations prevent accidental universe polymorphism issues and make code easier to read and maintain.

**Consequences**: All variables must be explicitly declared or annotated.

---

## ADR-003: File locking system

**Date**: 2025-01-01
**Status**: Accepted

**Decision**: Use `git-lock.bash` + `locked_files.txt` + pre-commit hook to prevent accidental edits to completed modules.

**Rationale**: Lean 4 proofs are fragile — small changes to completed modules can break dependent proofs. The locking system makes this explicit.

**Consequences**: Workflow requires locking/unlocking files. See AI-GUIDE.md §20.

---

## ADR-004: Mathlib naming conventions

**Date**: 2025-01-01
**Status**: Accepted

**Decision**: All identifiers follow Mathlib4 naming conventions as documented in NAMING-CONVENTIONS.md.

**Rationale**: Consistency with the broader Lean 4 ecosystem. Makes theorems discoverable by name pattern (`mem_X_iff`, `subject_predicate`). Facilitates future Mathlib integration if desired.

**Consequences**: Existing names may need migration. See NAMING-CONVENTIONS.md for the full dictionary and 12 formation rules. REFERENCE.md §0 provides a quick reference.

---

## ADR-005: Directory-aligned namespaces

**Date**: 2025-01-01
**Status**: Accepted

**Decision**: Each subdirectory corresponds to a sub-namespace: `Foundations/Foo/Bar.lean` → `namespace Foundations.Foo.Bar`.

**Rationale**: Clear 1:1 mapping between file system and namespace hierarchy. Reduces confusion about where definitions live. Scales well as the project grows.

**Consequences**: `new-module.bash` must handle subdirectory creation. `gen-root.bash` must scan recursively.

---

## ADR-006: Annotation system in REFERENCE.md

**Date**: 2025-01-01
**Status**: Accepted

**Decision**: REFERENCE.md entries include `@axiom_system` and `@importance` annotations.

**Rationale**: Helps AI assistants prioritize which modules/theorems to load for context. Provides quick classification without reading module code.

**Consequences**: Annotations must be maintained when modules are updated. See AI-GUIDE.md §24-25.

---

## ADR-007: Separate NAMING-CONVENTIONS.md file

**Date**: 2025-01-01
**Status**: Accepted

**Decision**: Naming conventions live in a dedicated NAMING-CONVENTIONS.md file, with a summary in AI-GUIDE.md and REFERENCE.md §0.

**Rationale**: The full naming dictionary with 12 rules and migration tables is too large for AI-GUIDE.md alone. A separate file allows detailed examples without bloating the main guide.

**Consequences**: Three places reference naming: NAMING-CONVENTIONS.md (canonical), AI-GUIDE.md (summary), REFERENCE.md §0 (reader guide). All must be kept in sync.

---

## ADR-008: Typeclasses atómicos + bundles en lugar de typeclass monolítico

**Date**: 2026-04-10
**Status**: Accepted

**Context**: Phase 1 necesita una jerarquía de interfaces que permita reutilizar teoremas
entre sistemas de fundamentación (ZFC, MK, Aczel, NF…). La primera propuesta era un
único `class SetAxioms (U)` con todos los campos axiomáticos. Pero los sistemas no
comparten el mismo subconjunto de axiomas: NF no tiene Fundación, KP tiene restricciones
de complejidad, Aczel obtiene los axiomas como teoremas por construcción inductiva. Un
typeclass monolítico obliga a todo sistema a implementar axiomas que no tiene.

Además, los teoremas no necesitan todos los axiomas disponibles: `cantor_no_surjection`
solo necesita Extensionalidad + Potencia + Separación; `empty_unique` solo necesita
Extensionalidad + Vacío. Un typeclass monolítico impone una dependencia innecesariamente
fuerte.

**Decision**: Arquitectura en tres niveles:

1. **Typeclasses atómicos** — uno por axioma del inventario universal (S01–S12, A01–A05).
   Cada uno declara exactamente una operación o propiedad. Sin pruebas aquí.
   Ejemplo: `class HasExt (U) [Membership U U] where ext : ∀ x y : U, ...`

2. **Bundles** — typeclasses que extienden varios atómicos sin añadir nuevos campos.
   Corresponden a fragmentos axiomáticos nombrados de la literatura.
   Ejemplo: `class ZFSet (U) extends ZermeloSet U, HasRepl U`
   La jerarquía de bundles refleja la jerarquía de sistemas: ZFBasic < ZFFinite < Zermelo < ZF < ZFC < MK.

3. **Teoremas con requisitos mínimos** — cada teorema declara solo los typeclasses atómicos
   que necesita, no el bundle completo.
   Ejemplo: `theorem cantor_no_surjection [HasExt U] [HasPow U] [HasSep U] ...`

**Rationale**:

- *Frente a typeclass monolítico*: no hay campo "dummy" para axiomas que no aplican (NF, KP).
  Los teoremas son reutilizables en el sistema más débil posible.
- *Frente a `structure` en lugar de `class`*: perderíamos la inferencia de instancias.
  Los teoremas necesitarían recibir explícitamente el sistema — verboso e incompatible con
  el objetivo de reutilización automática.
- *Frente a herencia lineal fija (ZF < ZFC < MK)*: NF y KP no encajan en esa cadena.
  Los atómicos permiten composición arbitraria. Un sistema "raro" como NF instancia solo
  `HasExt` + `HasStratSep`, sin necesidad de encajar en la jerarquía ZFC.
- *Consistencia con Lean 4*: la inferencia de instancias de Lean resuelve automáticamente
  qué bundle disponible satisface los requisitos del teorema. Esto es exactamente teoría de
  modelos formalizada en el sistema de tipos.

**Consequences**:

- Más archivos en Phase 1 (uno por atómico) pero cada uno es trivial.
- Los bundles permiten usar nombres familiares (`ZFSet`, `PeanoArith`) en el código de aplicación.
- La distinción `axiom` vs `theorem` para el mismo campo (ZFC vs Aczel) es invisible al usuario
  del typeclass, pero preservable mediante anotaciones `@proof_status` en REFERENCE.md.
- Complejidad de diseño concentrada en Phase 1; fases posteriores se benefician directamente.
- Dependencia cíclica imposible: atómicos < bundles < universales < instancias.

---

## ADR-009: Migración directa vs. dependencia de lago (lake dependency)

**Date**: 2026-04-10
**Status**: Accepted

**Context**: Los repositorios `Peano`, `AczelSetTheory`, `ZFCSetTheory` y `MKplusCAC`
contienen trabajo ya hecho que debe integrarse en `Foundations`. Hay dos estrategias:

- **Dependencia de lago**: declarar los repos como dependencias en `lakefile.lean` e importar
  sus módulos directamente. Es el camino rápido.
- **Migración directa**: copiar el código fuente, adaptarlo a las convenciones de
  `Foundations` (NC-1–NC-10, §6), e integrarlo como módulos propios.

**Decision**: **Migración directa**, precedida en cada caso por una auditoría en el repositorio
de origen. El proceso para cada repo es:

1. Auditoría de nombres en el repo de origen (prefijos `ZF_*`, `PA_*`, `AZ_*`, convenios NC).
2. Añadir export blocks a todos los módulos del repo de origen.
3. Actualizar REFERENCE.md del repo de origen.
4. Verificar compilación con `autoImplicit=false`.
5. Copiar a `Foundations/` bajo la estructura de directorios definida en NEXT-STEPS.md.
6. Instanciar los typeclasses atómicos/bundles de Phase 1 para cada tipo migrado.

**Rationale**:

- *Convenciones de nombres*: los repos de origen no siguen todavía NC-1–NC-10 de forma
  consistente. Importarlos como dependencia introduciría nombres inconsistentes en
  `Foundations` sin posibilidad de renombrar en origen.
- *Control total sobre la API pública*: `Foundations` es la capa de reutilización.
  Necesita decidir qué se exporta y con qué nombre, independientemente de cómo esté
  organizado en el repo de origen.
- *Instanciación de typeclasses*: para que `ZFCSetTheory` provea una instancia
  `instance : ZFCSet ZFCUniverse`, alguien tiene que escribir ese glue code.
  Es más limpio hacerlo en `Foundations` con el código ya migrado que añadir
  código de glue en el repo de origen.
- *Dependencias de lago crean acoplamiento de versiones*: si `ZFCSetTheory` cambia su API,
  `Foundations` se rompe sin aviso. Con migración directa, el código en `Foundations` es
  estable una vez migrado y bloqueado (`git-lock.bash freeze`).
- *Excepción*: si en el futuro algún repo alcanza madurez suficiente y adopta todas las
  convenciones de `Foundations`, se puede reconsiderar una dependencia de lago para ese
  repo concreto. Eso requeriría un nuevo ADR.

**Consequences**:

- Mayor esfuerzo inicial (auditoría + migración), pero trabajo único por repo.
- Los repos de origen siguen siendo independientes y usables por sí mismos.
- Los repos de origen deben estar en buen estado antes de cada fase de migración
  (Phases 5 y 6 tienen listas de pre-migración explícitas).
- El código en `Foundations` queda frozen tras migración; los cambios en origen no
  se propagan automáticamente. Esto es deseable: `Foundations` es la capa estable.
- `lakefile.lean` de `Foundations` permanece sin dependencias externas (coherente con ADR-001).

---

## Template for new decisions

## ADR-NNN: [Title]

**Date**: YYYY-MM-DD
**Status**: [Proposed | Accepted | Deprecated | Superseded by ADR-XXX]

**Context**: [Why is this decision needed?]

**Decision**: [What was decided?]

**Rationale**: [Why this choice over alternatives?]

**Consequences**: [What are the trade-offs?]
