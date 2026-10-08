\ProvidesClass{classes/progress_report}[2026/10/08 progress_report]

% (u)pLaTeX非互換パッケージに対して互換させるパッチを読み込む命令
\RequirePackage{plautopatch}

% 1カラム,A4,フォントサイズ9pt,余白はWord原本(上下12mm,左右13mm)に合わせる
\LoadClass[
    paper=a4,
    fontsize=9pt,
    disablejfam,
    head_space=12mm,
    foot_space=12mm,
    gutter=13mm,
    fore-edge=13mm]
    {jlreq}

\RequirePackage{ifptex}
\RequirePackage{ifluatex}

\ifluatex
    \RequirePackage{luatexja}
    \RequirePackage{luatexja-fontspec}
    \RequirePackage[haranoaji,no-math,deluxe]{luatexja-preset}
    \RequirePackage{xcolor}
    \RequirePackage[unicode,hidelinks,pdfusetitle]{hyperref}
\else
    \ifuptex
        \RequirePackage[deluxe]{otf}
        \RequirePackage[haranoaji,noalphabet]{pxchfon}
        \DeclareFontShape{JY2}{hmc}{b}{n}{<->ssub*hmc/bx/n}{}
        \DeclareFontShape{JT2}{hmc}{b}{n}{<->ssub*hmc/m/n}{}
        \RequirePackage[dvipdfmx]{xcolor}
        \RequirePackage[dvipdfmx,unicode,hidelinks,pdfusetitle]{hyperref}
    \else
        \ClassError{progress_report}{This class file is for LuaLaTeX or upLaTeX only.}{Use LuaLaTeX or upLaTeX to compile this document.}
    \fi
\fi

\RequirePackage{tabularray} % メタ情報表
\RequirePackage{subfiles}

% 原本どおり全体をゴシック体にする
\renewcommand{\kanjifamilydefault}{\gtdefault}
\renewcommand{\familydefault}{\sfdefault}

\definecolor{reportblue}{HTML}{C6D9F1} % 見出し・ラベルの塗り
\definecolor{reportnavy}{HTML}{17365D} % タイトル
\definecolor{reportred}{HTML}{C00000}  % 「記入の基本」
\definecolor{reporttext}{HTML}{222222} % 本文

\pagestyle{empty}
\setlength{\parindent}{0pt}
\color{reporttext}

% ---------- メタ情報 (未指定なら原本どおりの空欄になる) ----------
\newcommand{\course}[1]{\gdef\@course{#1}}
\newcommand{\studentid}[1]{\gdef\@studentid{#1}}
\newcommand{\laboratory}[1]{\gdef\@laboratory{#1}}
\newcommand{\reportdate}[1]{\gdef\@reportdate{#1}}
\newcommand{\reportweek}[1]{\gdef\@reportweek{#1}}
\newcommand{\reportmode}[1]{\gdef\@reportmode{#1}}
\newcommand{\researchtheme}[1]{\gdef\@researchtheme{#1}}
\newcommand{\advisor}[1]{\gdef\@advisor{#1}}

\makeatletter
\course{2026年度 電気電子情報実験IV・V}
\title{プレ卒研研究進捗報告書}
\author{}
\studentid{}
\laboratory{}
\reportdate{\hspace{2em}年\hspace{2em}月\hspace{2em}日}
\reportweek{}
\reportmode{□対面\hspace{0.5em}□オンタイム遠隔\hspace{0.5em}□オンデマンド}
\researchtheme{}
\advisor{}

% タイトル + メタ情報表 + 記入の基本
\renewcommand{\maketitle}{%
    \begin{center}
        {\color{reportnavy}\bfseries
        {\fontsize{11.5pt}{14pt}\selectfont \@course\par}
        \vspace{1pt}
        {\fontsize{18pt}{22pt}\selectfont \@title\par}}
    \end{center}
    \vspace{3pt}
    \begin{tblr}{
        width=\linewidth,
        colspec={Q[c,m,wd=24mm,bg=reportblue]X[l,m]Q[c,m,wd=26mm,bg=reportblue]X[1.4,l,m]},
        hlines, vlines, rowsep=1.2mm, colsep=1.4mm,
        row{4}={ht=13mm},
        cell{1,2,3,4}{1,3}={font=\bfseries}
    }
        氏名 & \@author & 学籍番号 & \@studentid \\
        所属研究室 & \@laboratory & 実施年月日 & \@reportdate \\
        第\hspace{2em}週 & \@reportweek & 実施形態 & \@reportmode \\
        {研究テーマ\\（暫定可）} & \@researchtheme & 主な指導担当者 & \@advisor
    \end{tblr}
    \par\vspace{4pt}
    {\bfseries\color{reportred}記入の基本：}%
    単なる作業一覧ではなく、「何を目的に、何を行い、何が分かり、次に何をするか」を具体的に記入する。箇条書き可。必要に応じて図表、参考資料、データ名、プログラム名を示す。
    \par\vspace{4pt}
}
\makeatother

% ---------- 記入欄 ----------
% \begin{reportbox}{見出し}{記入欄の最小高さ} ... \end{reportbox}
% 見出し行と記入欄を1つのvboxにして、欄の途中では改ページしない (原本のcantSplit相当)
% tcolorboxはupLaTeX(DVI)で本文が出ないため、標準の箱と罫線で組む
\makeatletter
\newsavebox{\rb@box}
\newlength{\rb@height}
\newlength{\rb@pad}
\setlength{\rb@pad}{1.4mm}
\newenvironment{reportbox}[2]{%
    \def\rb@title{#1}\setlength{\rb@height}{#2}%
    \begin{lrbox}{\rb@box}%
    \begin{minipage}{\dimexpr\linewidth-2\rb@pad-2\fboxrule\relax}\raggedright\ignorespaces
}{%
    \end{minipage}\end{lrbox}%
    \par\noindent
    \vbox{%
        \fboxsep=0pt
        \hbox{\fcolorbox{black}{reportblue}{\parbox[c][5.6mm][c]{\dimexpr\linewidth-2\fboxrule\relax}{\hspace*{\rb@pad}\bfseries\rb@title}}}%
        \nointerlineskip\vskip-\fboxrule
        \setlength{\dimen0}{\dimexpr\ht\rb@box+\dp\rb@box+2.4mm\relax}%
        \ifdim\dimen0<\rb@height\setlength{\dimen0}{\rb@height}\fi
        \hbox{\fcolorbox{black}{white}{\parbox[c][\dimen0][c]{\dimexpr\linewidth-2\fboxrule\relax}{\hspace*{\rb@pad}\usebox{\rb@box}}}}%
    }%
    \par\vspace{4mm}%
}
\makeatother

% 「［記入の目安］」の斜体ヒント。和文に斜体は無いので、LuaLaTeXでは疑似斜体にする
\ifluatex
    \newjfontfamily\hintjfont[AutoFakeSlant=0.2]{HaranoAjiGothic-Regular.otf}
    \newcommand{\hint}[1]{{\hintjfont\itshape ［記入の目安］#1\par}}
\else
    \newcommand{\hint}[1]{{\itshape ［記入の目安］#1\par}}
\fi

% ---------- 提出前チェック ----------
\newcommand{\makefooter}{%
    \par\noindent
    {\fboxsep=0pt
    \fcolorbox{black}{reportblue}{\parbox[c][5.6mm][c]{\dimexpr\linewidth-2\fboxrule\relax}{\hspace*{1.4mm}\footnotesize{\bfseries 提出前チェック}\hspace{0.8em}□目的と実施内容が対応している\hspace{0.1em}□結果・気づきを記入した\hspace{0.1em}□次回課題に期限または完了条件がある\hspace{0.1em}□引用・参照元を示した}}}%
    \par\vspace{2mm}
    \hfill 確認者：\hspace{10em}確認日：\hspace{2em}年\hspace{2em}月\hspace{2em}日
}
