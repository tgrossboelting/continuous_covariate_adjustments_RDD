# Research Project Template — CLAUDE.md

This is a template repository for econometric PhD research projects. Each paper gets its own copy of this repo. Work is written in LaTeX; analysis is in R.

## Repository Structure

```
root/
├── literature.bib          # Single shared bibliography (BibLaTeX, authoryear style)
├── paper/
│   ├── paper-main.tex      # Main entry point — \input{preamble}, then section files
│   ├── preamble.tex        # Shared preamble for ALL documents in the repo
│   ├── abstract.tex
│   ├── introduction.tex
│   ├── literature.tex
│   └── notation.tex
├── derivations/            # Standalone derivation documents (one per topic/date)
├── notes/                  # Meeting notes and ideas (flat, no subfolders)
├── slides/                 # Beamer presentation(s)
├── code/                   # R scripts
├── data/                   # Raw data (gitignored)
├── output/                 # Generated figures/tables (gitignored)
└── literature/
    ├── literature_papers/   # External papers (arXiv, journals) — tracked via .gitignore exception
    └── literature_material/ # Scanned notes, figures, handwritten material — tracked via .gitignore exception
```

Both `literature/` subfolders are whitelisted in `.gitignore` so that PDFs and images inside them escape the blanket `*.pdf` rule. Anything else (e.g. compiled PDFs of your own `.tex` notes in `literature/` root) is ignored as a build artifact.

## LaTeX Conventions

### Shared preamble
`paper/preamble.tex` is the single source of truth for all LaTeX settings. Every document in the repo uses it:
- From `paper/`: `\input{preamble}`
- From `notes/` or `derivations/`: `\input{../paper/preamble.tex}`

Do not duplicate packages or macros across documents — always add them to the preamble.

### Bibliography
`literature.bib` lives at the root. The preamble references it as `../literature.bib`. This resolves correctly from all locations because BibLaTeX resolves paths relative to the **main document**, not the `\input`-ed preamble.

Backend: biber. Style: authoryear. DOI/ISBN/URL suppressed globally.

### Math macros defined in preamble
`\E` (expectation), `\Var`, `\Cov`, `\Corr`, `\plim`, `\argmax`, `\argmin`, `\diag`, `\sign`, `\ind` (indicator), `\indep`, `\iid`, `\toindistr`, `\sumn`, `\abs{}`, `\norm{}`, `\defeq`, `\eqdef`, `\given`

### Theorem environments
`theorem`, `proposition`, `lemma`, `corollary` (numbered jointly per section), `assumption`, `definition`, `remark`. Use `\cref`/`\Cref` for cross-references.

### Comments toggle
`\commentT{...}` inserts an inline todo note. Controlled by `\commentfalse` / `\commenttrue` in preamble — flip the toggle to show/hide all comments before sharing.

### Paper structure
`paper-main.tex` uses `\input{}` for each section. Appendix uses alphabetical section numbering (A, B, ...) with Roman subsections (A.I, A.II, ...).

## R Code Conventions

Scripts live in `code/` and follow the template `00_template_script.R`:
- Header block: Script Name, Author, Date, Description, TO-DOs
- Sections: Libraries → Load Data → Analysis → Save Outputs
- Outputs (plots, tables) go to `output/`

## Git & GitHub

Remote: `https://github.com/tgrossboelting/research_project_repo_template.git`

Gitignored:
- All LaTeX build artifacts: `*.aux`, `*.log`, `*.bbl`, `*.bcf`, `*.run.xml`, `*.pdf`, etc.
- `data/` and `output/` directories (preserve with `.gitkeep`)
- R session files: `.Rhistory`, `.RData`, etc.

Always commit `.tex`, `.bib`, and `.R` source files. Never commit build artifacts or data.

## Collaboration Style

- Make minimal, targeted changes — one at a time, easy to verify
- Propose what you intend to change before doing it for anything non-trivial
- Do not bundle unrelated edits, even small ones
- Do not fix things noticed in passing — flag them, but wait for instruction
- After every change: commit with a clear, descriptive message. Do not push automatically — ask for explicit confirmation before running `git push`, every time, even within the same session.
