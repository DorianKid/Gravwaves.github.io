# Gavitational Waves Web Site

> Sitio web del **Grupo de Gravitación y Análisis de Datos en Ondas Gravitacionales** 

**Demo:** https://doriankid.github.io/Gravwaves.github.io/  
**Repositorio:** https://github.com/DorianKid/Gravwaves.github.io

---

## Tabla de contenidos
- [Descripción general](#descripción-general)
- [Características](#características)
- [Índice del proyecto (secciones del sitio)](#índice-del-proyecto-secciones-del-sitio)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Instalación y ejecución local](#instalación-y-ejecución-local)
- [Roadmap](#roadmap)
- [Contribución](#contribución)
- [Licencia](#licencia)
- [Agradecimientos](#agradecimientos)

---

## Descripción general

Plataforma web estática (HTML/CSS/JS) para **divulgación científica, difusión de investigación y colaboración** en torno a las ondas gravitacionales. El sitio organiza contenido de investigación, publicaciones, participantes, colaboraciones y oportunidades, con un diseño modular y componentes de interfaz dinámicos.

---

## Características

- **Mejoras visuales:** desplazamiento suave, fondos con imágenes y secciones destacadas para una experiencia moderna.
- **Contenido dinámico:** tarjetas, carruseles y secciones responsivas para presentar actividades, eventos y resultados.
- **Arquitectura modular:** múltiples páginas HTML organizadas por tema.
- **Personalización:** estilos propios (carpeta `css/`) y scripts de interacción (carpeta `js/`).
- **Multimedia:** integración de imágenes, logotipos y material de eventos.

---

## Índice del proyecto (secciones del sitio)

Páginas que componen el sitio y su objetivo principal:

- **Inicio (`index.html`)** — Portada del grupo con introducción, enlaces rápidos y resumen de líneas de trabajo.
- **Investigación (`investigacion.html`)** — Temas de investigación: gravitación, análisis de datos, interferometría, cosmología/infación, multimensajeros, etc.
- **Participantes (`participantes.html`)** — Integrantes del grupo (estudiantes de licenciatura/posgrado e investigadores).
- **Publicaciones (`publicaciones.html`)** — Listado de resultados y trabajos del grupo.
- **Colaboraciones (`colaboraciones.html`)** — Organizaciones y proyectos aliados.
- **Oportunidades (`oportunidades.html`)** — Convocatorias y actividades para sumarse al grupo.
- **Taller de Cosmología (`taller-cosmologia.html`)** — Página de evento/curso específico.

> Todas estas páginas viven en la raíz del repo y se navegan mediante el menú principal del sitio.

---

## Estructura del proyecto

```
Gravwaves.github.io/
├─ css/                  # Hojas de estilo (tipografías, layout, componentes)
├─ js/                   # Scripts de interacción y utilidades
├─ logos/                # Logotipos institucionales y del proyecto
├─ personas/             # Avatares o retratos de participantes
├─ fondos/               # Imágenes de fondo/portada
├─ imgs eventos/         # Fotografías y assets de eventos
├─ imgs_colaboraciones/  # Logos e imágenes de colaboradores
├─ imgs_investigacion/   # Imágenes para secciones de investigación
├─ tesis/                # Recursos/portadas de tesis
├─ index.html
├─ investigacion.html
├─ participantes.html
├─ publicaciones.html
├─ colaboraciones.html
├─ oportunidades.html
├─ taller-cosmologia.html
└─ README.md
```

> Nota: Es un **sitio estático**; no requiere backend. Se puede servir en GitHub Pages o con cualquier servidor estático local.

---

## Roadmap

- [ ] **Publicaciones**: filtro por año/área y visor integrado de PDF.
- [ ] **Participantes**: fichas con ORCID/Google Scholar y búsqueda por nombre/rol.
- [ ] **Investigación**: tarjetas por línea con enlaces a datasets, código y presentaciones.
- [ ] **Accesibilidad (a11y)**: contraste, navegación por teclado y etiquetas aria.
- [ ] **SEO multilingüe**: metadatos y estructura i18n (ES/EN) con selector de idioma.
- [ ] **Rendimiento**: compresión de imágenes, lazy‑loading y minificación de CSS/JS.
- [ ] **QA**: pruebas visuales/regresión y checklist de publicación.
- [ ] **Automatización**: script para actualizar publicaciones desde un archivo `.json` o una hoja de cálculo.

---

## Contribución

Por ahora las contribuciones se concentran en apoyo directo: **apoyé a mi maestra para mejorar la página web de su grupo de gravitación** (estructura, estilos y organización del contenido).  
Si más adelante se abren PRs, sugerencias:

- Mantener el estilo consistente (convenciones de nombres, tamaños de imágenes y clases CSS).
- Evitar dependencias pesadas; priorizar JS/CSS nativo.
- Incluir capturas antes/después en los PRs de rediseño.

---

## Licencia

Actualmente **no hay un archivo de licencia explícito** en el repositorio. Se sugiere añadir **MIT** o **CC BY‑4.0** para el contenido, según lo que el grupo decida. *Mientras no exista un archivo `LICENSE`, por defecto los derechos son reservados.*

---

## Agradecimientos

- **Grupo de Gravitación y Análisis de Datos en Ondas Gravitacionales** (UdeG y Tec de Monterrey, campus Guadalajara).
- A las y los estudiantes e investigadores que han compartido imágenes y material para el sitio.
