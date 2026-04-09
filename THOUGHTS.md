# Thoughts — Foundations

**Last updated:** 2026-04-09 12:00
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

## 2026-04-09 — Teoremas de Gödel, completitud lógica y forcing

### Los tres grandes resultados meta-lógicos que deben integrarse

**1. Teorema de Completitud de Gödel (1930) — lógica de primer orden**

- Enunciado: `T ⊢ φ ↔ T ⊨ φ` para toda teoría T consistente y fórmula φ de primer orden.
- Requiere formalizar:
  - Sintaxis de FOL: tipos de datos inductivos para términos, fórmulas, sustituciones libres.
  - Sistema deductivo formal: Hilbert, deducción natural o secuentes de Gentzen.
  - Semántica: estructuras (`Structure` = dominio + función de interpretación), relación de satisfacción `⊨`.
  - Construcción de Henkin (o Löwenheim–Skolem) para producir el modelo a partir de la consistencia.
- Lean 4: la completitud es meta-teórica — hay que formalizar la sintaxis de FOL *dentro* de Lean como tipo de datos inductivo.

**2. Teoremas de Incompletitud de Gödel (1931)**

- Primero: todo sistema F consistente, suficientemente fuerte y recursivamente enumerable es incompleto — existe φ tal que ni `F ⊢ φ` ni `F ⊢ ¬φ`.
- Segundo: F no puede probar su propia consistencia (si es consistente).
- Requiere:
  - **Numeración de Gödel**: codificación de la sintaxis como naturales. *Peano es la pieza clave*: si los naturales, las funciones primitivas recursivas y la representabilidad ya están en `Peano`, la codificación de la sintaxis se construye directamente sobre ese trabajo.
  - **Lema diagonal** (punto fijo para fórmulas): `∃ φ, T ⊢ φ ↔ ¬Provable(⌈φ⌉)`.
  - Representabilidad de funciones recursivas en el sistema.
- Dependencia: Gödel numbering vive en aritmética → el repositorio `Peano` es el soporte natural para esta formalización.

**3. Forcing (Cohen, 1963)**

- Método para construir extensiones genéricas `M[G]` de un modelo transitivo `M ⊨ ZFC`.
- Permite probar resultados de independencia: `ZFC ⊬ CH`, `ZFC ⊬ ¬CH`, `ZFC ⊬ AC` (si se parte de ZF), etc.
- Requiere:
  - ZFC completo (con Elección y Reemplazamiento) como base mínima.
  - Noción de poset de forcing `(P, ≤)` y filtros genéricos `G ⊆ P`.
  - Relación de forcing `p ⊩ φ` (definida por recursión sobre la estructura de φ).
  - Universo genérico `M[G]` y verificación de que satisface ZFC + la propiedad deseada.
- Variantes a contemplar: forcing booleano (Scott–Solovay), forcing de clases (para MK/TG), modelos simétricos.

### Conexiones arquitectónicas clave

#### Peano → Incompletitud
Peano ya tiene los naturales y (en breve) funciones recursivas primitivas. La numeración de Gödel es una función primitiva recursiva. La representabilidad de funciones recursivas en PA es el resultado que conecta la aritmética con la sintaxis. **No hay que rehacer esto para cada sistema**: una vez que se tiene la codificación en Peano, los teoremas de incompletitud se aplican a *cualquier* sistema que interprete PA — lo que incluye ZFC, MK, TG, etc.

#### Completitud → Teoría de Modelos → Sistema de Modelos
El teorema de completitud es el puente entre pruebas y modelos: `T es consistente ↔ T tiene un modelo`. Esto conecta directamente con el sistema de modelos necesario para las jerarquías de conjuntos. Una vez que se tiene una noción general de `Structure` y `⊨`, se pueden instanciar para:
- Modelos de PA, modelos de ZFC, modelos de MK.
- Modelos de forcing `M[G]`.
- Modelos elementales, extensiones elementales, ultra-productos.

#### Forcing → Capa sobre ZFC; parametrizable a sistemas más fuertes
El forcing es paramétrico respecto al sistema base. Un desarrollo genérico de forcing debería funcionar con ZFC como base, y luego ser reutilizable para MK y TG (que son extensiones conservativas en muchos aspectos). Esto cuadra con la arquitectura de tres capas: el framework de forcing pertenece a la *capa de implementación*, instanciable según el sistema de la *capa axiomática*.

### Nueva capa arquitectónica: la Meta-lógica (Capa 0)

Los tres resultados exigen añadir una nueva capa *transversal* a la arquitectura propuesta anteriormente:

```
Capa 0 — Meta-lógica  (NUEVA)
  ├── Sintaxis de FOL (términos, fórmulas, sustitución)
  ├── Sistemas deductivos formales (Hilbert / secuentes / ND)
  ├── Semántica (estructuras, satisfacción, consecuencia)
  ├── Completitud (construcción de Henkin)
  ├── Gödel numbering + representabilidad
  ├── Incompletitud I y II
  └── Forcing (posets, filtros genéricos, relación ⊩, M[G])

Capa 1 — Axiomática   (instancias concretas: PA, ZFC, MK, TG…)
Capa 2 — Teoremas universales
Capa 3 — Implementación demostrativa
```

Esta capa 0 es *independiente del sistema de fundamentación concreto*. No pertenece a ZFC ni a MK: *habla sobre* todos ellos. Es la capa que permite expresar "φ es independiente de ZFC" o "PA no puede probar su propia consistencia" como teoremas dentro del propio sistema formal.

### Sistema de construcción de modelos y forcing — componente de investigación autónoma

Idea más ambiciosa: un framework que permita *explorar sistemáticamente* qué es demostrable en cada sistema, usando forcing como herramienta de investigación:

**1. Biblioteca de condiciones de forcing canónicas**

| Forcing | Resultado |
|---------|-----------|
| Cohen forcing | `¬CH` es consistente con ZFC |
| Collapsing forcing | Colapso de cardinales |
| Lévy collapse | Consistencia de cardinales grandes + ¬CH |
| Sacks forcing | Mínimo grado de constructibilidad |
| Prikry forcing | Cambio de cofinalidad sin colapso de cardinales |
| Mathias forcing | Conjuntos de Ramsey |
| Class forcing | Para sistemas más fuertes: MK, TG |

**2. Verificador de independencia**

Dado un enunciado φ y un sistema T:
- Si se construye un modelo de `T + φ` y un modelo de `T + ¬φ`, entonces φ es independiente de T.
- El framework de forcing proporciona la maquinaria para construir ambos modelos.
- El teorema de completitud garantiza que la existencia del modelo equivale a la consistencia.

**3. Componente de autoaprendizaje / investigación**

- Exploración sistemática de qué axiomas adicionales (axiomas de grandes cardinales, axiomas de determinacy, etc.) resuelven qué problemas abiertos.
- Mapa de implicaciones entre axiomas: `TG ⊢ ZFC`, `MK ⊢ ZFC`, `PD → AD → ...`.
- Jerarquía de grandes cardinales (inaccesibles, Mahlo, medibles, supercompactos, etc.) como extensiones axiomáticas explorables.
- Integración con Vopěnka: si el principio de Vopěnka está en TG+Vopěnka, ¿qué resultados nuevos se obtienen automáticamente?

### El forcing como amplificador del problema de la repetición

El forcing añade una nueva dimensión al problema de la repetición: una vez que se tiene el framework de forcing genérico para ZFC, no debería rehacerse para MK. La clave es que el forcing es *relativo al modelo base*: si MK extiende ZFC y el modelo `M ⊨ ZFC` está disponible, entonces `M[G] ⊨ ZFC` ya está construido. Para resultados específicos de MK solo habría que añadir lo que MK aporta sobre ZFC en el modelo genérico.

### Orden de implementación sugerido para la Capa 0

1. **FOL/Syntax** — términos, fórmulas, sustitución (depende de: Peano para índices de variables)
2. **FOL/ProofSystem** — sistema deductivo (Hilbert o secuentes)
3. **FOL/Semantics** — `Structure`, satisfacción `⊨`, consecuencia semántica
4. **FOL/Completeness** — construcción de Henkin, `T ⊢ φ ↔ T ⊨ φ`
5. **Arithmetic/GodelNumbering** — codificación de la sintaxis en ℕ (sobre Peano)
6. **Arithmetic/Representability** — toda función recursiva es representable en PA
7. **Incompleteness/DiagonalLemma** — lema de punto fijo para fórmulas
8. **Incompleteness/First** — existencia de la sentencia de Gödel
9. **Incompleteness/Second** — `PA ⊬ Con(PA)` si PA es consistente
10. **Forcing/Basic** — posets, filtros, conjuntos de nombres, relación ⊩ (sobre ZFC completo)
11. **Forcing/GenericExtension** — construcción de `M[G]`, verificación de ZFC en `M[G]`
12. **Forcing/Independence** — ejemplos: `ZFC + ¬CH`, `ZFC + CH`
13. **Forcing/Library** — condiciones canónicas (Cohen, collapsing, Sacks, Prikry…)
14. **Forcing/ClassForcing** — extensión a MK/TG para grandes cardinales

---

## Open Questions

### Arquitectura general
- [ ] ¿Cómo modelar la "capa de interfaces" en Lean 4? ¿Typeclasses, estructuras, functores?
- [ ] ¿Es posible hacer que los teoremas de ZFC sean instancias automáticas en MKplusCAC sin reescribir pruebas?
- [ ] ¿Cómo representar jerarquías de conjuntos (von Neumann, Grothendieck) en este marco?
- [ ] ¿Cuál es la estrategia de conexión entre AczelSetTheory y ZFCSetTheory a nivel de pruebas (no solo de axiomas)?

### Sistemas numéricos
- [ ] ¿Hasta dónde llega Peano para números algebraicos y aproximaciones de Cauchy sin Mathlib?
- [ ] ¿Qué axiomas de infinito son agregables a AczelSetTheory sin romper su decidibilidad/constructivismo?

### Meta-lógica y Gödel
- [ ] ¿Cuál es la representación más conveniente de la sintaxis de FOL en Lean 4 (tipo inductivo vs. encodings de De Bruijn)?
- [ ] ¿Debe la Capa 0 vivir en un repositorio separado (`FOLFoundations` o similar) o dentro de `Foundations`?
- [ ] La numeración de Gödel depende de Peano: ¿cómo importar el repositorio `Peano` en `Foundations` manteniendo la independencia de Mathlib?
- [ ] ¿Qué sistema deductivo es más cómodo para formalizar la completitud en Lean 4: Hilbert, secuentes o deducción natural?

### Forcing
- [ ] ¿Es factible un framework de forcing paramétrico (instanciable a ZFC, MK, TG) con una sola implementación?
- [ ] ¿Cómo representar filtros genéricos en Lean 4 sin Choice explícito dentro del forcing mismo?
- [ ] ¿Puede el forcing de clases (class forcing) construirse sobre el mismo framework base que el forcing de conjuntos?
- [ ] ¿Cómo conectar el framework de forcing con la jerarquía de grandes cardinales para el componente de investigación autónoma?

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
