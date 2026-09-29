%% ===========================================================================
%%  style/akari.cls
%%  Document class for the Project Akari concept paper.
%%
%%  Visual language is taken from the Project Akari brand and the Material 3
%%  content-layer palette:
%%    akariRed       #E53935  brand primary (logo gradient stop)
%%    akariRedDeep   #B71C1C  brand dark stop
%%    akariRedLight  #FF5252  brand light stop
%%    akariInk       #1C1B1F  M3 on-surface
%%    akariInkSoft   #49454F  M3 on-surface-variant
%%
%%  Class options:
%%    nocover           do not emit the title page
%%    <anything else>   forwarded verbatim to the article class
%%
%%  Engine: XeLaTeX only (fontspec / unicode-math).
%% ===========================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{akari}[2026/09/29 v0.1.0 Project Akari concept paper]

\newif\ifakari@cover
\akari@covertrue
\DeclareOption{nocover}{\akari@coverfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[11pt,a4paper]{article}

%% ---------------------------------------------------------------------------
%% 1. Dependencies
%% ---------------------------------------------------------------------------
\RequirePackage{iftex}
\RequirePackage{xcolor}
\RequirePackage{fontspec}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{unicode-math}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{enumitem}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{fancyhdr}
\RequirePackage{needspace}
\RequirePackage{caption}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{lastpage}
\RequirePackage[hidelinks]{hyperref}

%% ---------------------------------------------------------------------------
%% 2. Palette
%% ---------------------------------------------------------------------------
\definecolor{akariRed}      {HTML}{E53935}
\definecolor{akariRedDeep}  {HTML}{B71C1C}
\definecolor{akariRedLight} {HTML}{FF5252}
\definecolor{akariInk}      {HTML}{1C1B1F}
\definecolor{akariInkSoft}  {HTML}{49454F}
\definecolor{akariInkFaint} {HTML}{79747E}
\definecolor{akariRule}     {HTML}{E8DEDD}
\definecolor{akariTint}     {HTML}{FFF6F5}
\definecolor{akariTintWarm} {HTML}{FDF0EE}

%% ---------------------------------------------------------------------------
%% 3. Fonts
%%    Latin and math use TeX Gyre Termes (Times-compatible), which ships with
%%    TeX Live. Replace the three \set*font blocks to change the typeface.
%% ---------------------------------------------------------------------------
\setmainfont{texgyretermes}[
  Extension      = .otf,
  UprightFont    = *-regular,
  BoldFont       = *-bold,
  ItalicFont     = *-italic,
  BoldItalicFont = *-bolditalic,
  Ligatures      = TeX,
]
\setsansfont{texgyreheros}[
  Extension      = .otf,
  UprightFont    = *-regular,
  BoldFont       = *-bold,
  ItalicFont     = *-italic,
  BoldItalicFont = *-bolditalic,
]
\setmonofont{texgyrecursor}[
  Extension      = .otf,
  UprightFont    = *-regular,
  BoldFont       = *-bold,
  ItalicFont     = *-italic,
  BoldItalicFont = *-bolditalic,
  Scale          = 0.92,
]
\setmathfont{texgyretermes-math.otf}

%% ---------------------------------------------------------------------------
%% 4. Optional CJK fallback.
%%    The paper is written in English. A few course titles and proper nouns
%%    appear in their original script, so CJK glyph coverage is wired up when
%%    both xeCJK and the Fandol fonts are available. If either is missing the
%%    document still builds; only those glyphs would fall back to a system
%%    font.
%% ---------------------------------------------------------------------------
\IfFileExists{xeCJK.sty}{%
  \RequirePackage{xeCJK}%
  \IfFontExistsTF{FandolSong-Regular.otf}{%
    \setCJKmainfont{FandolSong-Regular.otf}[
      BoldFont   = FandolSong-Bold.otf,
      ItalicFont = FandolKai-Regular.otf,
    ]%
    \setCJKsansfont{FandolHei-Regular.otf}[BoldFont = FandolHei-Bold.otf]%
    \setCJKmonofont{FandolFang-Regular.otf}%
    \xeCJKsetup{CJKmath=true}%
  }{}%
}{}

%% ---------------------------------------------------------------------------
%% 5. Page geometry and text block
%% ---------------------------------------------------------------------------
\geometry{
  paper      = a4paper,
  top        = 26mm,
  bottom     = 28mm,
  left       = 27mm,
  right      = 27mm,
  headheight = 22pt,
  headsep    = 7mm,
  footskip   = 11mm,
}

\linespread{1.13}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.72ex plus 0.22ex minus 0.1ex}
\setlength{\emergencystretch}{2em}
\clubpenalty=8000
\widowpenalty=8000

%% ---------------------------------------------------------------------------
%% 6. Headings
%% ---------------------------------------------------------------------------
\titleformat{\section}
  {\normalfont\sffamily\bfseries\fontsize{17}{21}\selectfont\color{akariInk}}
  {\textcolor{akariRed}{\thesection}\hspace{0.55em}}{0pt}{}
  [\vspace{-0.85em}{\color{akariRed}\rule{\linewidth}{1.1pt}}]
\titlespacing*{\section}{0pt}{3.4ex plus 1ex minus .2ex}{2.0ex plus .3ex}

\titleformat{\subsection}
  {\normalfont\sffamily\bfseries\fontsize{13.2}{16.5}\selectfont\color{akariInk}}
  {\textcolor{akariRedDeep}{\thesubsection}\hspace{0.5em}}{0pt}{}
\titlespacing*{\subsection}{0pt}{2.6ex plus 0.8ex minus .2ex}{1.2ex plus .2ex}

\titleformat{\subsubsection}
  {\normalfont\sffamily\bfseries\fontsize{11.6}{14.5}\selectfont\color{akariInkSoft}}
  {\thesubsubsection\hspace{0.5em}}{0pt}{}
\titlespacing*{\subsubsection}{0pt}{2.0ex plus 0.6ex minus .2ex}{0.9ex plus .2ex}

\titleformat{\paragraph}[runin]
  {\normalfont\sffamily\bfseries\color{akariInkSoft}}{}{0pt}{}[~~~]

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

%% ---------------------------------------------------------------------------
%% 7. Running heads and feet
%% ---------------------------------------------------------------------------
\renewcommand{\sectionmark}[1]{\markboth{#1}{}}
\fancypagestyle{akari@body}{%
  \fancyhf{}%
  \fancyhead[L]{\small\sffamily\color{akariInkFaint}\AkariShortTitle}%
  \fancyhead[R]{\small\sffamily\color{akariInkFaint}\nouppercase{\leftmark}}%
  \fancyfoot[C]{\small\sffamily\color{akariInkSoft}\thepage\,/\,\pageref{LastPage}}%
  \renewcommand{\headrulewidth}{0.4pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \renewcommand{\headrule}{%
    \hbox to\headwidth{\color{akariRule}\leaders\hrule height \headrulewidth\hfill}}%
}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\small\sffamily\color{akariInkSoft}\thepage\,/\,\pageref{LastPage}}%
  \renewcommand{\headrulewidth}{0pt}%
}
\pagestyle{akari@body}

%% ---------------------------------------------------------------------------
%% 8. Captions
%% ---------------------------------------------------------------------------
\captionsetup{
  font      = {small,sf},
  labelfont = {bf,color=akariRed},
  labelsep  = quad,
  skip      = 6pt,
}
\captionsetup[table]{position=top}

%% ---------------------------------------------------------------------------
%% 9. Lists
%% ---------------------------------------------------------------------------
\setlist[itemize]{
  leftmargin = 1.6em, topsep = 0.4ex, itemsep = 0.25ex,
  parsep = 0pt, label = \textcolor{akariRed}{\textbullet},
}
\setlist[enumerate]{
  leftmargin = 2.0em, topsep = 0.4ex, itemsep = 0.25ex,
  parsep = 0pt, label = \textcolor{akariRedDeep}{\bfseries\arabic*.},
}
\setlist[description]{
  leftmargin = 0pt, topsep = 0.4ex, itemsep = 0.3ex, parsep = 0pt,
  font = \sffamily\bfseries\color{akariInk},
}

%% ---------------------------------------------------------------------------
%% 10. Table of contents
%% ---------------------------------------------------------------------------
\titlecontents{section}[0pt]
  {\addvspace{0.7ex}\sffamily\bfseries\color{akariInk}}
  {\textcolor{akariRed}{\thecontentslabel}\hspace{0.6em}}{}
  {\hfill\color{akariInkFaint}\contentspage}
\titlecontents{subsection}[1.6em]
  {\addvspace{0.2ex}\sffamily\small\color{akariInkSoft}}
  {\thecontentslabel\hspace{0.5em}}{}
  {\hfill\color{akariInkFaint}\contentspage}

%% ---------------------------------------------------------------------------
%% 11. Metadata. Override any of these in refs/metadata.tex.
%% ---------------------------------------------------------------------------
\newcommand{\AkariTitle}      {Project Akari Concept Paper}
\newcommand{\AkariSubtitle}   {Design Rationale and System Blueprint}
\newcommand{\AkariTagline}    {Illuminating the Path of Learning}
\newcommand{\AkariAuthor}     {SakurakaiCat}
\newcommand{\AkariOrg}        {Project Akari}
\newcommand{\AkariVersion}    {v0.1.0}
\newcommand{\AkariStatus}     {Draft}
\newcommand{\AkariDate}       {\today}
\newcommand{\AkariShortTitle} {Project Akari Concept Paper}
\newcommand{\AkariLogo}       {figures/brand/akari-logo.pdf}

%% ---------------------------------------------------------------------------
%% 12. Title page
%% ---------------------------------------------------------------------------
\newcommand{\AkariMetaRow}[2]{%
  {\sffamily\small\color{akariInkFaint}#1}\hfill
  {\sffamily\small\color{akariInk}#2}\\[0.9ex]%
}

\renewcommand{\maketitle}{%
  \ifakari@cover
    \begin{titlepage}%
      \thispagestyle{empty}%
      \begin{flushleft}%
        \vspace*{6mm}%
        \IfFileExists{\AkariLogo}{\includegraphics[width=30mm]{\AkariLogo}}{}%
      \end{flushleft}%
      \vspace{18mm}%
      {\color{akariRed}\rule{34mm}{1.6pt}}\par
      \vspace{7mm}%
      {\sffamily\bfseries\fontsize{27}{32}\selectfont\color{akariInk}\AkariTitle\par}%
      \vspace{4.5mm}%
      {\sffamily\fontsize{15}{19}\selectfont\color{akariInkSoft}\AkariSubtitle\par}%
      \vspace{10mm}%
      {\itshape\sffamily\large\color{akariInkFaint}\AkariTagline\par}%
      \vfill%
      \begin{minipage}{\linewidth}%
        \AkariMetaRow{Document version}{\AkariVersion}%
        \AkariMetaRow{Status}{\AkariStatus}%
        \AkariMetaRow{Maintainer}{\AkariAuthor}%
        \AkariMetaRow{Date}{\AkariDate}%
      \end{minipage}\par
      \vspace{6mm}%
      {\color{akariRed}\rule{\linewidth}{1.6pt}}%
    \end{titlepage}%
    \setcounter{page}{1}%
  \fi
  \global\let\maketitle\relax
}

%% ---------------------------------------------------------------------------
%% 13. hyperref setup
%% ---------------------------------------------------------------------------
\urlstyle{same}
\hypersetup{
  colorlinks = true,
  linkcolor  = akariRedDeep,
  citecolor  = akariRedDeep,
  urlcolor   = akariRedDeep,
  bookmarksnumbered = true,
  pdftitle   = {Project Akari Concept Paper},
  pdfauthor  = {SakurakaiCat},
}

\endinput
