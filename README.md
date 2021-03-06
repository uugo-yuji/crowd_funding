# README
# ポートフォリオ/クラウドファンディングサイト

- サービス概要: 登録したユーザが出資して貰いたいプロダクトを投稿し出資を募るサービスです。  

## 使用技術
 - Ruby 2.6.5
 - Rails 6.0.3
 - MySQL 5.7
 - Docker 19.03.12
 - Docker-compose 1.27.2
 - Rspec
 - Rubocop/per-commit

## 機能
 - ユーザ登録, ログイン機能
    - devise
 - 運営管理者機能
    - enumで権限の判断
    - カテゴリー追記
    - 全ユーザのプロダクト状況の確認
 - プロダクトの投稿機能
    - 画像投稿にActiveStorageを使用
 - プロダクトへの出資機能
    - 決済機能はついておりません。
 - カテゴリー機能
 - いいね機能
 - メッセージ機能
    - 登録したユーザ間でのメッセージ機能です。
 - 検索機能
    - プロダクトに対するタイトル,出資額,カテゴリーでの検索機能です。

## テスト
- Rspec
  - 単体テスト(model)

## 開発フロー
 - 知り合いの方に協力して頂き実務を想定,GitHub Flowを用いIssuesでのタスク管理,コードレビュー後にmergeを実施。  
 - 細かくcommitしていき修正,改善。また、進捗状況など合わせて意識的に管理。
 - 質問などSlackでのやりとりも相手の時間を使わせない事などチームで開発する意識し開発を行いました。  
　※ 現在、主要のバックエンドのみ実装。  
