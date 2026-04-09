# Thoughts — Foundations

**Last updated:** 2026-04-09 00:00
**Author**: Julián Calderón Almendros

> This is an informal design journal. Record ideas, alternatives considered,
> open questions, and future directions here. Not normative — purely exploratory.
> Useful for AI context on "why" decisions were made.

---

## 2026-04-09 — Visión general del proyecto y problema de arquitectura

### Sistemas de fundamentación implementados o en curso

Todos los repositorios están en https://github.com/julian1c2a:

| Repositorio | Sistema | Estado actual |
|-------------|---------|---------------|
| `Peano` | Aritmética de Peano (sin Mathlib) | Naturales completos; enteros y racionales próximamente; conjuntos de naturales y tuplas de naturales (en futuro: de enteros y de racionales) |
| `AczelSetTheory` | Teoría de conjuntos constructivista (Aczel) | Lo más gordo hecho; HFSets resueltos; todos los axiomas de ZFC probados como teoremas; conexiones con Peano establecidas |
| `ZFCSetTheory` | ZFC clásico | Muy completo; faltan los dos últimos axiomas: Elección y Reemplazamiento; bien conectado con Peano |
| `MKplusCAC` | Morse-Kelley + Axioma de Elección para Clases | Principios solamente: conjunto de axiomas y poco más |

### Sistemas previstos a futuro

- **Tarski-Grothendieck** (TG)
- **TG + Vopěnka**
- **NBG** (von Neumann–Bernays–Gödel)
- **Kripke-Platek**
- **NF** o **NFUM** (New Foundations / NF con Urelementos + Matemáticas)
- Cuando se alcance MKplusCAC, la siguiente extensión natural es TG o TG+Vopěnka

### Sobre los números y los conjuntos: dos niveles

Existe una distinción estructural importante entre dos niveles de abstracción:

**Nivel 1 — Sistemas numéricos y listas ordenadas** (estilo Peano):
- Trata con conjuntos que son fundamentalmente *listas ordenadas sin duplicados* cuyos elementos son del mismo "tipo" (naturales, enteros, racionales).
- Peano es cómodo para llegar hasta los reales y sistemas numéricos algebraicos.
- Desde Peano puro probablemente no se pueden construir los reales directamente, pero sí: algunos números algebraicos, y sistemas de aproximaciones de Cauchy que no tienen por qué tener límite en los racionales.

**Nivel 2 — Teoría de conjuntos en toda su generalidad**:
- Trata el siguiente escalón: conjuntos heterogéneos, jerarquías, clases propias, etc.
- AczelSetTheory, ZFCSetTheory, MKplusCAC pertenecen a este nivel.

### El problema central: repetición y arquitectura

A medida que el proyecto crece, se está repitiendo trabajo. Una vez terminado el sistema inicial de Aczel, debería poderse aprovechar todo lo ya demostrado en ZFC. Al abordar MKplusCAC, no debería ser necesario recomenzar a probar todo lo ya probado, sino solo:
1. Adaptar lo existente para recoger ZFC (y AczelSetTheory si procede).
2. Detenerse solo en las *ampliaciones* que ofrece el sistema más fuerte.

### Idea de arquitectura (por explorar)

Se necesita un **sistema de interfaces** con tres capas:

1. **Capa axiomática**: el conjunto de axiomas de cada sistema, expresado de la forma más general posible.
2. **Capa de teoremas universales**: los teoremas importantes expresados en su forma más general (independientes del sistema subyacente en la medida de lo posible).
3. **Capa de implementación**: el sistema demostrativo concreto — por ejemplo, Peano para aritmética y conjuntos numéricos, ZFC para teoría de conjuntos general.

El objetivo es que, al añadir MKplusCAC, solo haya que:
- Instanciar la capa 1 con los axiomas de MK.
- Reutilizar la capa 2 directamente (los teoremas comunes ya probados en ZFC).
- Extender la capa 3 solo donde MK ofrece algo nuevo.

### Sistemas de modelos y jerarquías

Otro eje del problema: hace falta un **sistema de modelos** que capture las jerarquías de conjuntos o de tipos (p.ej., jerarquía de von Neumann, universos de Grothendieck, jerarquía acumulativa). Esto es especialmente relevante para TG y TG+Vopěnka.

### Perspectivas más lejanas

- **Teoría de categorías**: podría introducirse como capa transversal cuando la base sea suficientemente sólida.
- **HoTT (Homotopy Type Theory)**: perspectiva de unificación tipo/conjunto desde el lado de los tipos.
- El orden tentativo de sistemas a implementar: MKplusCAC → TG → TG+Vopěnka → (NBG, KP, NF/NFUM en paralelo o después).

---

## Open Questions

- [ ] ¿Cómo modelar la "capa de interfaces" en Lean 4? ¿Typeclasses, estructuras, functores?
- [ ] ¿Es posible hacer que los teoremas de ZFC sean instancias automáticas en MKplusCAC sin reescribir pruebas?
- [ ] ¿Hasta dónde llega Peano para números algebraicos y aproximaciones de Cauchy sin Mathlib?
- [ ] ¿Cuál es la estrategia de conexión entre AczelSetTheory y ZFCSetTheory a nivel de pruebas (no solo de axiomas)?
- [ ] ¿Qué axiomas de infinito son agregables a AczelSetTheory sin romper su decidibilidad/constructivismo?
- [ ] ¿Cómo representar jerarquías de conjuntos (von Neumann, Grothendieck) en este marco?

---

## Lessons Learned

### Naming Conventions

- Mathlib naming conventions (NAMING-CONVENTIONS.md) significantly improve searchability
- The `mem_X_iff` pattern is more discoverable than `X_is_specified`
- Predicates as prefix (`isNat_zero`) are more consistent than suffix (`zero_is_nat`)

### Module Organization

- Subdirectories should mirror sub-namespaces
- Each subdirectory benefits from a `Basic.lean` for foundational definitions
- Extension modules (`FooExt.lean`) are preferable to modifying frozen modules

### Documentation

- REFERENCE.md must be self-sufficient for AI assistants
- The "project" protocol (AI-GUIDE.md §12) prevents documentation drift
- Annotations (`@importance`, `@axiom_system`) help AI prioritize context loading

---

## Future Directions

Ver sección "2026-04-09 — Visión general" arriba para el mapa completo.
