# LaTeXテンプレート

[![License: CC0-1.0](https://img.shields.io/badge/License-CC0_1.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)


## 機能

TeXliveやcloud LaTeX, Overleaf等で使用できるLaTeXテンプレートです。
upLaTeXとLuaLaTeXに対応しています
論文用のclsファイルが用意されており、.latexmkrcを使用してビルドを行います
レジュメ用のテンプレートは書式が手に入ったら更新予定です

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

### テンプレートの種類

このリポジトリには、論文用、レジュメ用、週報用のテンプレートが含まれています

### 論文用テンプレート

なんとなく既存のワードテンプレートに合わせた論文用のテンプレートです。（現在作成中）

### レジュメ用テンプレート

まだ何も手を付けていません。必要になるまでには作ります。

### 週報用テンプレート

完成しています。main.texにexample/tex/weekly_report.texをコピーして使用してください。サンプルの出力はexample/pdfにあります。


### プレ卒研研究進捗報告書テンプレート

`extern/`のWord様式を再現したテンプレートです（A4、原ノ味ゴシック）。`classes/progress_report.cls`を使い、記入例は`example/docs/progress_report.tex`にあります。

## License

CC0
