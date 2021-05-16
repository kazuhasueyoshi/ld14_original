# 掲示板アプリ発展

## なにをするか

このレポジトリは，掲示板アプリの教科書を全て実装しおえたものになります!

このレポジトリを clone してからスタートしてください！  
[デモ動画](https://www.youtube.com/watch?v=0A179vkqZcY&feature=youtu.be)を参考にデザインと機能を実装してください  
Bootstrap でレイアウトを組んで、 CSS で色を付けていくと良いと思います  

**hint**  
bootstrap はクラス名で CSS を当てていくことができます.
e.g.  
mt-5 = margin-top: 5px  
d-flex = display: flex  
etc..  
[ここ](https://getbootstrap.com/docs/4.3/getting-started/introduction/)の左のメニュー(Layoutなど)から既存の BBS にはどのような CSS が掛かっているか考えてみると良いと思います

### 学習項目

- 1 : N の構成を 0->1 で実装しよう！
- Bootstrap を制御せよ！
- オーバーライド CSS でオリジナル要素を出そう！

## 注意事項

- .env ファイルは含まれていないので新規作成し，API キー等を記述してください．
- .db ファイルは含まれていませんが，マイグレーションファイルは作成されています．各自マイグレートしてください．

## 追加する機能

### 投稿に対するコメント機能

comments テーブルを作成して, コメントを管理するためのテーブルを用意

| 格納するもの    | カラム名        | データ型 |
| --------------- | --------------- | -------- |
| 文章            | body            | string   |
| いいね          | good            | integer  |
| 投稿に紐づく ID | contribution_id | integer  |

### コメントに対するいいね機能

ボタンから特定のコメントをいいねできる機能  
"/"にリダイレクト

### コメント削除機能

ボタンから特定のコメントを削除できる機能  
"/"にリダイレクト

### 推奨する機能

余裕があったら実装してみてください！

- メイン画面以外のデザイン
- コメントの編集機能
- 非同期通信で UX をあげる

## デザイン要件

### 画像

[ここ](https://unsplash.com/photos/7MRF-ZPbluU)からダウンロードしてください

### ボタンなどで使われているアイコン

FontAwesome を使用しています  
[こちら](https://fontawesome.com/start)からアカウント登録をして使用してください

#### ロゴ名

- いいね
  - heart
- 投稿ボタン
  - paper-plane
- 画像選択
  - file-image
- コメント
  - comment
  - angle-down
- 編集ボタン
  - edit
- 削除ボタン
  - trash-alt

### フォント

Damion

- GoogleFonts にあります

### コメントのコラプス

[ここ](https://getbootstrap.com/docs/4.3/components/collapse/)を参考に実装してみると良いと思います  
自力で実装しても問題ないです

### 色と使われてる箇所

| 色                                                                       | 使われてる箇所                     |
| ------------------------------------------------------------------------ | ---------------------------------- |
| ![#150e0a](https://via.placeholder.com/15/150e0a/000000?text=+) #150e0a  | 背景色                             |
| ![#231a15](https://via.placeholder.com/15/231a15/000000?text=+) #231a15  | 投稿フォーム背景(透過度 40%)       |
| ![#f8f3ef ](https://via.placeholder.com/15/f8f3ef/000000?text=+) #f8f3ef | タイトルロゴ、投稿フォーム, ボタン |
| ![#837c78](https://via.placeholder.com/15/837c78/000000?text=+) #837c78  | 投稿フォームボーダー               |
| ![#403733](https://via.placeholder.com/15/403733/000000?text=+) #403733  | 投稿カードボーダー                 |
| ![#ccc0b7](https://via.placeholder.com/15/ccc0b7/000000?text=+) #ccc0b7  | 投稿カード強調文字色               |
| ![#88807c](https://via.placeholder.com/15/88807c/000000?text=+) #88807c  | 投稿カード文字色                   |
