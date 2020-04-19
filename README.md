フードシェアアプリ（仮）
----

概要  
日本国内だけで６００万トンとも言われるフードロス問題の解決に貢献したいと思い、作成。  
余った食品を気軽にシェアしたいユーザーと、安価に食品を欲しいユーザーをマッチングする。  

特に力を入れた点  
ユーザー体験の向上を、「９０秒でサービスを利用できる」ことで実現した。  
３０秒でユーザには商品詳細ページ及び商品一覧ページから当アプリの良否を判断してもらい、良いと感じたユーザーには３０秒でユーザー登録してもらい、  
最後の３０秒で「周辺のマップ」から近所の出品を探し、商品ページへ遷移した後、出品者へダイレクトメッセージが送れるように設計している。  

デプロイしたサイトのURL  
https://food-share-engine.herokuapp.com/  

競合  
国内ではTABETEというフードシェアアプリがリリースされている。  
私は、フードシェアにおける最大のユーザー体験向上は、自分の近所（半径３km以内程度）に出品されている商品があるか、どれだけ集中して出品されているかという検索性と商品数だと思っている。  
TABETE(web版)には現在地を検索する機能がなく、自分の現在地から近い出品を知る術がないが、私はこの点が重要であると考えたので、前述した検索性を意識して開発した。  

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

特徴の詳細  
・Google Maps APIを使用したマップ機能  
ユーザーから見た機能について  
Google MapsのAPIを使用した。食品を出品する際に、出品したユーザーには希望する合流場所を登録してもらい、ログインしているユーザー(操作しているユーザー）からは現在地情報を取得することで、ログインしているユーザーの現在地と出品した食品との距離をリアルタイムで計算している。  
それにより、ユーザーは自分が取りに行ける距離か判断しやすくなると考えた。  
さらに、食品を探す際に、マップから現在地周辺で出品しているユーザーを簡単に探すことが出来るよう実装しており(ヘッダーの「周辺のマップへ」を指す）、マップ画面からその食品の詳細ページへのリンクも貼っている。  

実装について  
gemとしてGeocoder及びgetkitを使用。大変だった点は、RailsとJavascriptを組み合わせること。
Google MapsはJavascriptで記述する必要があったが、Javascriptのみで記述し、指定した場所を表示させることは、あまり難しくなかった。しかし、ユーザーに入力してもらった住所をDBに保存し、その内容をallメソッドで全て取得し、each文を使い一つずつ取り出す際、each文の範囲によってはscriptタグ内部でうまく動作せずマップが表示されなかった。  
Railsを記述する部分を最小限に抑え、Javascript側に値を渡すことでうまく表示された。  
Rails側のDBの内容を、Javascript側で使用し表示させる経験が積めたと思う。  
具体的な実装は、  
現在地の計算についてはproduct/show.html.erbのscriptタグ内部、  
https://github.com/Ryosei-erb/prototype/blob/master/app/views/products/show.html.erb  
Productsコントローラーlocationアクション  
https://github.com/Ryosei-erb/prototype/blob/master/app/controllers/products_controller.rb  
product/location.html.erbのscriptタグ内部  
https://github.com/Ryosei-erb/prototype/blob/master/app/views/products/location.html.erb   

現在地周辺の食品検索は、maps/index.html.erb  
https://github.com/Ryosei-erb/prototype/blob/master/app/views/maps/index.html.erb  
Mapsコントローラーsearchアクション  
https://github.com/Ryosei-erb/prototype/blob/master/app/controllers/maps_controller.rb  
maps/search.html.erb  
https://github.com/Ryosei-erb/prototype/blob/master/app/views/maps/search.html.erb  
をご覧頂きたい。  

・出品者とログインユーザーとのダイレクトメッセージ機能  
ユーザーから見た機能について  
出品された商品の位置や価格を見て自分が取りに行けると考えたユーザーは、ダイレクトメッセージ機能を使って、出品したユーザーとコンタクトを取ることが出来る。  
「チャットを始める」というボタンを押すと、出品したユーザーと一対一の専用ルームが作られ、コミュニケーションが取れる。  
別のユーザーが「チャットを始める」ボタンを押すと、また別のルームが作られる。  
その目的は、開発者としてルーム内では住所のようなセンシティブな情報が投稿されることを想定しており、ユーザーのプライバシーを考慮しているから。  
というのも、このアプリでは、出品する際に「出品者の希望する合流場所」を指定してもらい、その場所で食品を欲しいユーザーと直接会って食品の受け渡しと会計を行ってもらおうと考えていた。  
それは、当初、小規模なサービスにクレジットカード情報を登録することはセキュリティ面から信用されないのではないかと考えたからだ（その後、カード登録とカードからの決済機能も追加しました）。  
したがって、利用する流れとしては以下を想定している。  
出品するユーザーは「出品者の希望する合流場所」を指定する。自分の住所ではなく、家や職場の近所で良い。  
そして、出品を見たユーザーは、ダイレクトメッセージ機能を通じて、出品したユーザーの合流場所の希望に対して、自分の希望を伝える。近所の付近で、「..という交差点はどうだろうか」など。  
つまり、カードを登録した決済機能を使わずに、会計する方法として、本機能を実装した。  

実装について  
この機能の実装の詳細は、Qiitaにまとめて公開しているので、こちらをご覧頂きたい。  
https://qiita.com/ryosei_y/items/ad33301244bc4ddcc539  

・SOLD OUT機能  
ユーザーから見た機能について  
SOLD OUT機能とは、出品された食品をユーザーが削除する機能ではなく、「すでに売り切れている」と他のユーザーに周知する機能である。  
この機能を実装した理由は二つある。  
一つ目は、出品したユーザーが心変わりして、やはり出品を取りやめようと思う場合を考えた。  
その際、destroyメソッドを使い、「出品を削除」してしまうと、データそのものが消えてしまうことになる。  
ただ、そうすると、ユーザーが再び出品したいと考えた時、もう一度出品してもらう必要がある。  
SOLD OUT機能ならば、売り切れた状態にするだけなので、再び出品したいとユーザーが考えた際は、「SOLDを解除」というボタンを押せば、すぐに出品状態に戻すことが出来る。つまり、UXを考えた設計を心がけた。  
二つ目は、21世紀の石油と言われるデータを蓄積せず、消去してしまうことは惜しいと考えた。  
私の開発したアプリでは、「あるユーザーが、何の食品を出品したか」というデータが取得することが可能である。  
その蓄積したデータを使い、将来的にはユーザーの嗜好を分析し、嗜好に応じた広告を出すことで収益化の一つとすることを視野に入れられると考えている。  

実装について  
出品者のみにボタンが見える仕様とすることは大前提として考えていた。  
ボタンを押した際に、URLクエリを使い、新しいページを表示させ、そのページではSOLDと書かれた文字を食品画像の上に表示させることまでは、すぐに実装することが出来た。  
しかし、ただページを切り替えるだけでは、他のページからリダイレクトした際には元の出品された状態のページが表示されてしまうので、何か工夫が必要だった。  
着想を得たのは、スクールの課題でECサイトを構築していた際、Solidusでは、まだ注文が完了していない場合の商品の状態(cart)、すでに注文が終わっている商品の状態(complete)をstateというカラムを使い表現していたことだった。  
つまり、Viewのレベルでページを切り替えるのではなく、モデルのレベルでDBを使い状態(state)を切り替えるという方法である。  
具体的な実装は、Productsコントローラーのsoldアクション  
https://github.com/Ryosei-erb/prototype/blob/master/app/controllers/products_controller.rb  
showアクション  
https://github.com/Ryosei-erb/prototype/blob/master/app/controllers/products_controller.rb  
resaleアクション  
https://github.com/Ryosei-erb/prototype/blob/master/app/controllers/products_controller.rb  
app/views/products/sold.html.erb  
https://github.com/Ryosei-erb/prototype/blob/master/app/views/products/sold.html.erb  
をご覧頂きたい。  

・PAYJP APIを使用したカード登録、決済機能  
ユーザーから見た機能について  
カードを事前に登録しているならば、買いたい商品のページで「購入する」というボタンから購入できるようにした。  
カード登録は必須ではないが、利便性を考え、何度も繰り返し購入するならば重要であると考えて実装した。  

実装について  
PAYJPという外部Web APIを使用した。  
カードの登録で、PAYJPに情報を送信する部分は一部Vue.jsを使用して実装した。  
Vue.jsを使用することで、「双方向データバインディング」が可能となったことは実装に役立った。  
なぜなら、ユーザーが入力したカード情報（例えば、カード番号など）はセキュリティの観点から、こちらでは保存せずに、PAYJPに送信し、トークンが送られてきたら、すぐに削除するようにPAYJPのドキュメントには書いてある。  
その際、Vue.jsを使用すれば、データバインディングが出来るので、データを削除することが容易だった。  

カード登録については、登録画面はapp/views/cards/_card_form.html.erb  
https://github.com/Ryosei-erb/prototype/blob/master/app/views/cards/_card_form.html.erb  
PAYJPへの入力内容の送信とトークン化はapp/javascripts/packs/hello_vue.js  
https://github.com/Ryosei-erb/prototype/blob/master/app/javascript/packs/hello_vue.js  
PAYJPから受け取ったデータからDBにカードの登録を行う部分は、Cardsコントローラーpayアクション  
https://github.com/Ryosei-erb/prototype/blob/master/app/controllers/cards_controller.rb  
をご覧頂きたい。  

決済機能については、決済のボタン（フォーム）は、app/views/products/_products_right_side.html.erb  
https://github.com/Ryosei-erb/prototype/blob/master/app/views/products/_product_right_side.html.erb  
登録してあるカード情報から支払いをする部分はProductsコントローラーのcheckoutアクション  
https://github.com/Ryosei-erb/prototype/blob/master/app/controllers/products_controller.rb  
をご覧頂きたい。  

注） 簡易ログインをクリックすると、すでにカードが登録済みのユーザーが使用できます。  
新たにカードの登録を実行したい場合は、ログアウト状態から、新規にユーザーを作成し、ヘッダーのユーザー管理をクリックすると、ユーザー詳細ページが表示されるので、そのページで「カードを登録する」というリンクからカード登録フォームへリダイレクト出来ます。  
そのフォームで、カード番号に「5555555555554444」、cvcに「123」、有効期限の月に「03」、年に「2021」と入力すると、テストカードで登録することが出来るので、是非お試し下さい。  

以上です。
