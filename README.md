# RuboSensei

- RuboSensei は書いたRuby/Railsコードに対して、より良い書き方を教えてくれるツールです
- RuboCop gem の仕組みをつかっています
- rubocopコマンドで良い書き方のアドバイスが表示されます
- VSCodeプラグイン [Ruby Light](https://marketplace.visualstudio.com/items?itemName=r7kamura.vscode-ruby-light) をつかうと書いたコードのそばに表示できます

![demo](demo.gif)

# 使い方

- Gemfile に以下を追加します。

```ruby
group :development do
  gem "rubocop", require: false
  gem "rubocop-sensei", require: false
end
```

- bundle installを実行します
  - $ bundle install

- .rubocop.yml へ以下を追加します

```yaml
require:
  - rubocop-sensei

Lecture:
  Enabled: true
```

- rubocop コマンドを実行します
  - $ bundle exec rubocop

- rubocop コマンドに `--autocorrect` オプションを渡すと、対応している項目は自動修正も行います
  - $ bundle exec rubocop --autocorrect

# 実行結果例

```
app/models/book.rb:12:5: C: Lecture/PreferMap: このeachメソッドはmapメソッドで置き換えられるかもしれません。

    array.each do |x| ...
    ^^^^^^^^^^^^^^^^^
```

# .rubocop.yml の例

- もしも.rubocop.ymlがないときは、たとえば次のような内容で作成します
- RuboCopデフォルトの検査のうちStyle, LintカテゴリだけをONにするときの.rubocop.ymlの例

```
AllCops:
  NewCops: enable
  SuggestExtensions: false

require:
  - rubocop-sensei

Style:
  Enabled: true

Lint:
  Enabled: true

Lecture:
  Enabled: true
```

- RuboCopデフォルトの検査をオフにしてRuboSenseiが出力するLectureカテゴリだけをONにするときの.rubocop.ymlの例

```yaml
AllCops:
  DisabledByDefault: true

require:
  - rubocop-sensei

Lecture:
  Enabled: true

Lecture/ReplaceElsif:
  Enabled: true
```

# License

MIT
