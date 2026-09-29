# Project Akari Concept Paper

Concept paper for [Project Akari](https://github.com/SakurakaiCat/ProjectAkari) —
a statement of intent: what the project is, why it is built the way it is, and
which design decisions are considered settled. See the project repository for
the implementation itself.

> **Status:** scaffold only. The build system, class, and structure are in place;
> the manuscript has not been written yet.

## Requirements

- **XeLaTeX** — required. The class uses `fontspec` and `unicode-math`, so
  `pdflatex` and `lualatex` will not work.
- **latexmk** — the build driver.
- A TeX Live installation with the packages listed under [Dependencies](#dependencies).

No Python, Node, or `pygments` dependency: code listings use `listings`, not
`minted`.

## Build

```bash
make            # → build/main.pdf
make watch      # rebuild on save
make check      # build, then report undefined refs / overfull boxes
make clean      # remove intermediates, keep the PDF
make distclean  # remove build/ entirely
```

The equivalent raw command, if you would rather not use make:

```bash
latexmk -xelatex -interaction=nonstopmode -file-line-error -outdir=build main.tex
```

## Layout

```
.
├── main.tex                    master file — the only file you compile
├── Makefile
├── style/
│   ├── akari.cls               document class: palette, fonts, page, headings
│   └── akari-envs.sty          callouts, pull quotes, code listings
├── refs/
│   ├── metadata.tex            title, version, status, date
│   └── references.bib          bibliography (optional, see below)
├── frontmatter/
│   └── abstract.tex
├── chapters/
│   └── body.tex                body include list; split into one file per chapter
├── backmatter/
│   └── appendix.tex            revision history, glossary
├── figures/brand/              logo in svg / pdf / png
├── build/                      output (git-ignored except .gitkeep)
└── scripts/                    helper scripts
```

`main.tex` is the only file you compile directly. Everything else is pulled in
with `\input`, so the manuscript can be split into as many files as it needs.

### Adding a chapter

Create `chapters/03-whatever.tex`, then add `\input{chapters/03-whatever}` to
`chapters/body.tex`. Keeping the include list in its own file means `main.tex`
stays readable no matter how many chapters accumulate.

## Writing conventions

- **Body text is English.** Running heads, captions, and the table of contents
  are all English. A CJK fallback font is wired up for the occasional course
  title that has no English form, but it is a fallback, not a second language.
- **Document-level facts come from macros.** Version, status, and date are
  defined once in `refs/metadata.tex` and referenced as `\DocVersion`,
  `\DocStatus`, `\DocDate`.
- **Tables**: `booktabs` rules (`\toprule` / `\midrule` / `\bottomrule`), no
  vertical rules. `tabularx` with `X` columns for anything that wraps.
- **Emphasis**: prefer `\emph{}` over manual italics so nesting behaves.

### Callout environments

Defined in `style/akari-envs.sty`. Every one takes an optional custom title.

```latex
\begin{keyidea}[Why this matters]
  Central design decisions and the reasoning behind them.
\end{keyidea}

\begin{notice}[Scope]
  Background, boundaries, and things deliberately left out of scope.
\end{notice}

\begin{caution}[Known limitations]
  Constraints, risks, and open trade-offs.
\end{caution}

\begin{todo}[Open question]
  Unresolved questions and planned work.
\end{todo}

\begin{creed}
  A design principle or verbatim excerpt worth setting apart.
\end{creed}
```

Inline helpers: `\term{Localised name}{Original name}`, `\code{identifier}`,
`\file{path/to/file}`.

### Code listings

`listings` is used rather than `minted` so the build needs nothing beyond TeX
Live. Three custom lexers are defined: `ts`, `json5like`, `sqlx`.

```latex
\begin{lstlisting}[language=ts, caption={...}, label={lst:...}]
const x: number = 1;
\end{lstlisting}
```

### Math

`amsmath`, `mathtools`, and `unicode-math` are loaded, with TeX Gyre Termes
Math as the math font. Display math via `\[ ... \]` or the `equation`
environment.

## Fonts

| Role  | Font | Source |
| ----- | ---- | ------ |
| Latin | TeX Gyre Termes | TeX Live |
| Sans  | TeX Gyre Heros  | TeX Live |
| Mono  | TeX Gyre Cursor | TeX Live |
| Math  | TeX Gyre Termes Math | TeX Live |
| CJK fallback | Fandol Song / Hei / Kai / Fang | TeX Live |

Every font ships with TeX Live, so a stock installation builds the document
without downloading anything. To change the typeface, edit the `\setmainfont`
and `\setsansfont` blocks in `style/akari.cls`.

## Bibliography

Disabled by default — the paper can be written without citations. To enable it,
uncomment the two lines in the preamble of `main.tex`:

```latex
\usepackage[backend=biber,style=authoryear]{biblatex}
\addbibresource{refs/references.bib}
```

and uncomment `\printbibliography` in the back matter. The `Makefile` does not
run `biber`; if you enable `biblatex`, build with plain `latexmk` (which detects
`biber` from the `.bcf` file) rather than the `make` target.

## Brand assets

`figures/brand/akari-logo.svg` is the source of truth. The `.pdf` used by the
title page and the `.png` preview are both generated from it:

```bash
make fonts      # requires rsvg-convert
```

## License

See the repository for licensing. Content is licensed separately from the
Project Akari source code.
