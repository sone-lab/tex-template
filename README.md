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

### Overleafで運用する場合

* リポジトリごとzip形式にして各サービスにアップロードしてください
* upLaTeXを使用する場合は、メニューのコンパイラをLaTeXに、LuaLaTeXを使用する場合はLuaLaTeXに変更してください

### Cloud LaTeXで運用する場合

* リポジトリごとzip形式にしてアップロードしてください
* .latexmkrcを使用してビルドを行いますので、upLaTeXとLuaLaTeXの切り替えは.latexmkrcを編集してください

### git, GitHubとの連携

データの消失や編集履歴の確認などのために、gitとGitHubを使用することをお勧めします
このリポジトリはテンプレートリポジトリですので、Use this templateを使用して新しいリポジトリを作成してください

## 使い方

レジュメ、論文のテンプレートはそれぞれexampleディレクトリに格納されています。

レジュメを作成する場合は、resume_template.texをmain.texに上書きしてください
論文を作成する場合は、thesis_template.texをmain.texに上書きしてください

使い方やFAQはこの[記事](https://zenn.dev/being/articles/how-to-use-my-latex)にまとめています


## License

CC0
