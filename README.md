フードシェアアプリ（仮）
----

概要
日本国内だけで６００万トンとも言われるフードロス問題の解決に貢献したいと思い、作成。
余った食品を気軽にシェアしたいユーザーと、安価に食品を欲しいユーザーをマッチングする。

特に力を入れた点
ユーザー体験の向上を、「９０秒でサービスを利用できる」ことで実現した。
３０秒でユーザーに当アプリの良否を判断してもらい、良いと感じたユーザーには３０秒でユーザー登録してもらい、
最後の３０秒で「周辺のマップ」から近所の出品を探し、商品ページへ遷移した後、出品者へダイレクトメッセージが送れるように設計している。

デプロイしたサイトのURL
https://food-share-engine.herokuapp.com/

競合
国内ではTABETEというフードシェアアプリがリリースされている。
私は、フードシェアにおける最大のユーザー体験向上は、自分の近所（半径３km以内程度）に出品されている商品があるか、どれだけ集中して出品されているかという検索性と商品数だと思っている。TABETE(web版)には現在地を検索する機能がなく、自分の現在地から近い出品を知る術がないが、私はこの点が重要であると考えたので、前述した検索性を意識して開発した。

特徴
以下の機能を実装している。
・Google Maps APIを使用したマップ機能
・出品者とログインユーザーとのダイレクトメッセージ機能
・SOLD OUT機能
・PAYJP APIを使用したカード登録、決済機能
・カテゴリーに応じた関連商品表示機能
・出品日に応じた新規出品表示機能
・商品名とカテゴリーからの検索機能
・sorceryを使用したユーザー登録、認証機構
・お気に入り機能
