source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'slim-rails'
gem 'mysql2'
gem 'compass-rails'            # Sassの機能拡張
gem 'coffee-rails'             # JavaScriptを簡潔に書ける
gem 'dotenv-rails'
gem 'jquery-rails'             # jQueryが使える
gem 'paranoia'
gem 'qiita'                    # RubyでqiitaAPIを使うためのgem
gem 'sanitize'                 # HTMLタグを除去するために導入

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'            # RailsでRspecが使える
  gem 'factory_girl_rails'     # テストデータの生成
  gem 'database_cleaner'       # テスト実行後にDBをクリア
  gem 'capybara'               # ブラウザでの操作をシミュレートしてテストができる
  gem 'rails-erd'  # ER図を生成するためのgem
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'                 # 余計なSQLを検出できる
  # debug
  gem 'better_errors'          # エラー画面を見やすくする
  gem 'binding_of_caller'      # better_errorsのエラー画面でREPLが使える
  gem 'tapp'                   # プリントデバッグがしやすくなる
  gem 'pry-rails'              # railsでpryが使える
  gem 'pry-byebug'             # pryでデバックコマンドが使える
  gem 'awesome_print'          # プリントデバッグの出力を整形
  gem 'hirb'                   # SQLの結果を見やすく整形してくれる
  gem 'hirb-unicode'           # hirbの日本語対応
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
