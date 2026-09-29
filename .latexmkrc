# =============================================================================
#  latexmk configuration
#
#  Loaded automatically by latexmk when it runs from this directory, so a bare
#  `latexmk main.tex` behaves the same as `make`.
#
#  - TEXINPUTS lets \usepackage{akari-envs} resolve to style/, and
#    \includegraphics find figures/, without installing anything system-wide.
#  - BIBINPUTS lets biblatex find refs/references.bib.
#  - The engine is XeLaTeX; the class needs fontspec and unicode-math.
# =============================================================================

$pdflatex = 'xelatex -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1 %O %S';
$pdf_mode = 5;                  # 5 = xelatex -> pdf, via xdvipdfmx
$out_dir  = 'build';

$ENV{'TEXINPUTS'} = './style//:./figures//:' . ($ENV{'TEXINPUTS'} // '');
$ENV{'BIBINPUTS'} = './refs//:' . ($ENV{'BIBINPUTS'} // '');

# Keep the auxiliary files, but delete them on `latexmk -c`.
$clean_ext = 'synctex.gz run.xml bbl fdb_latexmk fls';

# Rebuild when a chapter, the class, or the bibliography changes.
$do_cd = 0;
@default_files = ('main.tex');
