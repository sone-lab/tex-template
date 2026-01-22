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

このリポジトリには、論文用、レジュメ用、週報用のテンプレートが含まれています

### 論文用テンプレート

なんとなく既存のワードテンプレートに合わせた論文用のテンプレートです。（現在作成中）

### レジュメ用テンプレート

まだ何も手を付けていません。必要になるまでには作ります。

### 週報用テンプレート

完成しています。main.texにexample/tex/weekly_report.texをコピーして使用してください。サンプルの出力はexample/pdfにあります。


## License

CC0
