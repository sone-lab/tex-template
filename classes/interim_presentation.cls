\ProvidesClass{classes/interim_presentation}[2026/11/20 interim_presentation]

% (u)pLaTeX非互換パッケージに対して互換させるパッチを読み込む命令
\RequirePackage{plautopatch}

% 2カラム,A4,本文10pt,行送り14pt
% 余白は予稿様式（中沢研用）のWord原本に合わせる(上下左右20mm,段間7.5mm)
\LoadClass[
    twocolumn,
    paper=a4,
    fontsize=10pt,
    baselineskip=14pt,
    disablejfam,
    head_space=20mm,
    foot_space=20mm,
    gutter=20mm,
    fore-edge=20mm,
    column_gap=7.5mm]
    {jlreq}

\RequirePackage{ifptex}
\RequirePackage{ifluatex}

\PassOptionsToPackage{hyphens}{url}
\RequirePackage{secdot} % sectionの数字の後のドットの制御
\sectiondot{section}
\RequirePackage[hyphens]{xurl} % URLを表示するためのパッケージ、ハイフンでの改行を許可
\urlstyle{same} % URLの表示形式を本文と同じにする
\RequirePackage{bm} % ベクトルを大文字で書くためのパッケージ
\RequirePackage{amssymb, amsmath} % 高度な数式記述用パッケージ
\RequirePackage{mathtools} % 高度な数式記述用パッケージ
\RequirePackage{newtxtext,newtxmath} % Times系フォントを使用するためのパッケージ

\ifluatex
    % LuaTeXを日本語で使うための設定
    \RequirePackage{luatexja}
    % 日本語フォントは原ノ味フォントを使用
    \RequirePackage{luatexja-fontspec}
    \RequirePackage[haranoaji,no-math,deluxe]{luatexja-preset}

    % 図表関連のパッケージを読み込む
    \RequirePackage{xcolor}
    \RequirePackage{graphicx}

    % ハイパーリンクを設定
    \RequirePackage[unicode,hidelinks,pdfusetitle]{hyperref}
\else
    \ifuptex
        % upLaTeXのフォントを設定
        \RequirePackage[deluxe]{otf}
        \RequirePackage[haranoaji,noalphabet]{pxchfon}

        % Font shape JY2/hmc/b/n' undefined (Font) using JY2/hmc/bx/n' instead.
        \DeclareFontShape{JY2}{hmc}{b}{n}{<->ssub*hmc/bx/n}{}

        % LaTeX Font: Font shape `JT2/hmc/b/n' undefine(Font)	using `JT2/hmc/m/n' instead.
        \DeclareFontShape{JT2}{hmc}{b}{n}{<->ssub*hmc/m/n}{}

        % 図表関連のパッケージを読み込む
        \RequirePackage[dvipdfmx]{xcolor}
        \RequirePackage[dvipdfmx]{graphicx}

        % ハイパーリンクを設定
        \RequirePackage[dvipdfmx,unicode,hidelinks,pdfusetitle]{hyperref}

    \else
        % pTeXでコンパイルしようとする場合はエラーを出す
        \ClassError{interim_presentation}{This class file is for LuaLaTeX or upLaTeX only.}{Use LuaLaTeX or upLaTeX to compile this document.}
    \fi
\fi

% 文献は番号「(1)」で、7pt・行送り12pt・ぶら下げ5mm(原本どおり)
\RequirePackage[bibstyle=bibliography,sorting=none,date=year,isbn=false,doi,giveninits,urldate=iso,seconds]{biblatex}
\addbibresource{references.bib}
\DeclareFieldFormat{labelnumberwidth}{\makebox[\labelnumberwidth][l]{\mkbibparens{#1}}}
\renewcommand*{\bibfont}{\fontsize{7pt}{12pt}\selectfont}
\setlength{\labelnumberwidth}{5mm}
\setlength{\bibitemsep}{0pt}
\setlength{\bibhang}{0pt}

% 「文　献」の見出し(10pt・中央揃え)と、その下の罫線
\defbibheading{interim}{%
    \vspace{.5\baselineskip}%
    {\centering\normalsize 文\hspace{2\jlreq@zw}献\par}%
    \vspace{2pt}%
    \hrule
    \vspace{4pt}%
}
\newcommand{\printinterimbibliography}{\printbibliography[heading=interim]}

% 雑誌論文の書式(原本の指定)。langid={japanese}のエントリは日本語、それ以外は英語の書式にする
%   日本語: 著者名：「タイトル」，雑誌名，Vol.巻数，No.号数 p.ページ数 (発行年)
%   英語  : Name : “Title English”, 雑誌名, Vol.巻数, No.号数 p.ページ数 (発行年)
% article以外(inproceedings等)は共通スタイル(bibliography.bbx)のまま
\DeclareFieldFormat{pages}{#1}% 「p.」は書式側で付けるので、biblatexの接頭辞は外す
\DeclareBibliographyDriver{article}{%
    \usebibmacro{bibindex}%
    \usebibmacro{begentry}%
    \printnames{author}%
    \iffieldequalstr{langid}{japanese}
        {：「\printfield{title}」，}
        {\space:\space\textquotedblleft\printfield{title}\textquotedblright,\space}%
    \printfield{journaltitle}%
    \iffieldundef{volume}{}{\iffieldequalstr{langid}{japanese}{，}{,\space}Vol.\printfield{volume}}%
    \iffieldundef{number}{}{\iffieldequalstr{langid}{japanese}{，}{,\space}No.\printfield{number}}%
    \iffieldundef{pages}{}{\space p.\printfield{pages}}%
    \iffieldundef{year}{}{\space(\printfield{year})}%
    \usebibmacro{finentry}%
}

% ページ番号は付けない
\pagestyle{empty}

% 図表の前後は1行(14pt)あける
\setlength{\floatsep}{14pt}
\setlength{\textfloatsep}{14pt}
\setlength{\intextsep}{14pt}

% キャプション: 10pt・中央揃え。表説は表の上、図説は図の下
\RequirePackage{silence}
\WarningFilter{caption}{Unknown document class (or package)}
\RequirePackage{caption}
\captionsetup{font=normalsize, justification=centering, labelsep=quad, labelformat=simple, skip=5pt}
\captionsetup[figure]{name=図}
\captionsetup[table]{name=表, position=top}

% 見出し: ゴシック体10pt、番号は「1.」
\RenewBlockHeading{section}{1}{font={\normalsize\gtfamily},after_label_space=1\jlreq@zw}
\RenewBlockHeading{subsection}{2}{font={\normalsize\gtfamily},after_label_space=1\jlreq@zw}
\RenewBlockHeading{subsubsection}{3}{font={\normalsize\gtfamily},after_label_space=1\jlreq@zw}

% 原本は見出しの前後に空行(14pt)を置いている
\ModifyHeading{section}{before_space=14pt, after_space=14pt}
\ModifyHeading{subsection}{before_space=14pt, after_space=14pt}
\ModifyHeading{subsubsection}{before_space=14pt, after_space=14pt}

% ---------- メタ情報 ----------
% \title: タイトル、\laboratory: 研究室名(教員名)、\author: 氏名、\studentid: 学籍番号
\makeatletter
\newcommand{\laboratory}[1]{\gdef\@laboratory{#1}}
\newcommand{\studentid}[1]{\gdef\@studentid{#1}}
\laboratory{中沢研究室（中沢\hspace{1\jlreq@zw}吉博）}
\studentid{}

% タイトル(14pt)、研究室・氏名・学籍番号(12pt)は中央揃え。2段組はその下から始まる
\renewcommand{\@maketitle}{%
    \centering
    \fontsize{14pt}{14pt}\selectfont
    \@title
    \par
    \vspace{14pt}
    \fontsize{12pt}{12pt}\selectfont
    \@laboratory\hspace{6\jlreq@zw}\@author
    \ifx\@studentid\@empty\else（\@studentid）\fi
    \par
    \vspace{14pt}
}
\normalsize
\makeatother
