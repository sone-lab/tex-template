# LaTeXテンプレート

[![License: CC0-1.0](https://img.shields.io/badge/License-CC0_1.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)


## 機能

TeXliveやcloud LaTeX, Overleaf等で使用できるLaTeXテンプレートです。
upLaTeXとLuaLaTeXに対応しています
用途ごとのclsファイルが`classes/`に用意されており、.latexmkrcを使用してビルドを行います
テンプレートの種類は[テンプレートの種類](#テンプレートの種類)を参照してください

### VSCodeで運用する場合

* [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)の使用を前提としています
* .latexmkrcを使用してビルドを行います
* .vscode/settings.jsonにはLaTeX Workshopの設定を記述しています

dockerでの運用を可能にするために、devcontainer関連の設定ファイルを用意しています
Docker環境が必要ですが、環境構築の手間を省くことができます
docker imageとして、ghcr.io/being24/latex-docker を使用します  
ビルド用のdocker imageは[こちらのリポジトリ](https://github.com/being24/latex-docker)を参照してください

![demo](example/figures/screenshot.png)

### git, GitHubとの連携

提出時、githubにcommitするのを忘れないでください。
また、週報用、論文用、レジュメ用でリポジトリを分けてください。
あとでorgにまとめます。

## 使い方

### ビルドと textlint

ホストでは `make pdf` が Docker の LaTeX 環境でビルドします。dev container 内では、同じコマンドが container 内の `latexmk` を直接実行します。

```sh
make pdf FILE=main
make lint
make fix
```

textlint は `main.tex` と `sections/` を対象にします。対象は引数で指定できます。

```sh
npm run lint -- main.tex sections
npm run fix -- main.tex sections/abstract.tex
```

textlint の設定は共通パッケージ [being-textlint-ja-latex](https://github.com/being24/textlint-ja-latex) が持ちます。依存関係は `npm ci` で導入し、dev container では作成時に実行します。

LLM 用の MCP server は、リポジトリのルートで `npm run mcp` を起動します。MCP は指定した `.tex` ファイルを lint します。

### 参照チェック

`make check FILE=main` は、未使用・未定義の参照を検出します。1件でもあれば終了コード 1 で終わります。

- 文献: [checkcites](https://ctan.org/pkg/checkcites) が未使用の `.bib` エントリと未定義の `\cite` を報告します
- ラベル: [refcheck](https://ctan.org/pkg/refcheck) が参照されていない `\label` を、LaTeX の警告が未定義の `\ref` を報告します

チェック用のビルドは `build-check/` に出力するため、`main.pdf` は変わりません。biblatex を使う文書（論文用テンプレート）が対象で、`references.bib` のサンプル文献はテンプレートのままでは未使用として報告されます。

### テンプレートの種類

このリポジトリには、5種類のテンプレートがあります。

| 用途 | クラス | 記入例 | 状態 |
|---|---|---|---|
| 論文 | `classes/thesis.cls` | `main.tex`と`sections/` | 作成中 |
| 週報 | `classes/weekly_report.cls` | `example/docs/weekly_report.tex` | 使用可 |
| レジュメ | `classes/resume.cls` | `example/tex/resume_template.tex` | 例がビルドできない |
| プレ卒研研究進捗報告書 | `classes/progress_report.cls` | `example/docs/progress_report.tex` | 使用可 |
| 中間発表の予稿（中沢研用） | `classes/interim_presentation.cls` | `example/docs/interim_presentation.tex` | 使用可 |

状態は記入例をDockerの環境でビルドできるかで判断しています（2026-11-20時点）。
論文は`main.tex`のビルドで確認しました。

記入例を`main.tex`にコピーして使います。
論文は`main.tex`と`sections/`をそのまま使います。
ビルドは`make pdf FILE=main`です。

進捗報告書と予稿は、Wordの様式を再現したものです。
再現元のdocxは`extern/`に置く運用ですが、`.gitignore`で除外しているため、リポジトリには入っていません。

### 論文用テンプレート

なんとなく既存のワードテンプレートに合わせた論文用のテンプレートです。（現在作成中）
`main.tex`が`sections/`の各ファイルを`\subfile`で読み込みます。
各ファイルは`title`、`abstract`、`Introduction`、`theory`、`conclusion`、`references`、`acknowledgments`です。

`thesis.cls`を使う記入例が`example/docs/readme_report.tex`にもあります。
サンプルの出力は`example/pdf/readme_report.pdf`にあります。

### レジュメ用テンプレート

`classes/resume.cls`は、A4の2段組で、本文は9ptです。
記入例は`example/tex/resume_template.tex`です。

現状では、この例がビルドできません。
例の末尾が`sections/references.tex`を読み込みますが、このファイルは論文用のクラスにしかないコマンド（`\MyUnnumberedChapter`）を使うためです。

### 週報用テンプレート

完成しています。
`example/docs/weekly_report.tex`を`main.tex`にコピーして使います。
書き換えるのは、`\title`、`\author`、`\meetingdate`です。
サンプルの出力は`example/pdf/weekly_report.pdf`にあります。

### プレ卒研研究進捗報告書テンプレート

2026年度のプレ卒研研究進捗報告書（Word）を再現したテンプレートです。
A4の1段組で、本文は9ptの原ノ味ゴシック、余白は上下12mmと左右13mmです。
記入例は`example/docs/progress_report.tex`にあります。

書き換える項目は次のとおりです。

- 氏名などの項目：`\author`、`\studentid`、`\laboratory`、`\researchtheme`、`\advisor`
- 日付と回：`\reportdate`、`\reportweek`、`\reportmode`
- 提出前チェック：`\prechecked{1,3}`で1番目と3番目を■にします（未指定はすべて□）。確認者は`\reviewer`と`\reviewdate`で指定します。

未指定の項目は原本どおり空欄になります。
科目名の`\course`は、「2026年度 電気電子情報実験IV・V」が既定値です。

本文の記入欄は`reportbox`環境で書きます。
`\begin{reportbox}{見出し}{最小の高さ}`の形です。
中身が短いときは指定した高さに、長いときは中身に合わせて伸びます。
記入の目安は`\hint{}`で書きます。

### 中間発表用予稿テンプレート（中沢研用）

中沢研の予稿様式（Word）を再現したテンプレートです。
A4の2段組で、余白は上下左右20mm、本文は10ptの原ノ味明朝、行送りは14ptです。
見出しは10ptの原ノ味角ゴシック、タイトルは14pt、研究室名と氏名の行は12ptにしています。
フォントは原本のMS明朝とMSゴシックの代わりに、原ノ味明朝と原ノ味角ゴシックを使います。
記入例は`example/docs/interim_presentation.tex`です。

`\title`、`\author`、`\studentid`を指定します。
研究室名の`\laboratory`は、「中沢研究室（中沢　吉博）」が既定値です。

記入例には、原本の赤字（書式の注記と記入手順）が入っています。
本文を書くときは、赤字の注記と、末尾の`akablock`環境（記入手順）を消します。
赤字用の定義（`\akaji`、`akablock`、`\cs`、`\env`）も記入例の中にあるので、あわせて消してかまいません。

表と図は、`table`環境（表説は表の上）と`figure`環境（図説は図の下）で書きます。
原本が勧める「表と図を右側に寄せる」配置は、再現していません。
表と図は、書いた位置に近い段の上に自動で置かれます。

文献は`\printinterimbibliography`で出力します。
本文の`\cite`は右肩に「(1)」の形で付き、文献一覧の番号も「(1)」です。
書式は様式どおりです。
日本語の文献は`references.bib`に`langid = {japanese}`を付けると日本語の書式になり、付けないと英語の書式になります。
雑誌論文（`@article`）だけが対象で、ほかの種類は他のテンプレートと同じ書式です。

## License

CC0
