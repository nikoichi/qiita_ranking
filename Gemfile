# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.0.0.beta2'
gem 'coffee-rails'             # JavaScriptを簡潔に書ける
gem 'config'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'             # jQueryが使える
gem 'mysql2'
gem 'paranoia'
gem 'puma', '~> 3.7'
gem 'qiita'                    # RubyでqiitaAPIを使うためのgem
gem 'rails', '~> 5.1.1'
gem 'ridgepole'
gem 'rubocop', require: false
gem 'sanitize'                 # HTMLタグを除去するために導入
gem 'sass-rails'
gem 'seed-fu', '~> 2.3'
gem 'slim-rails'
gem 'unicorn'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capistrano', '~> 3.10.1'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano3-ridgepole'
  gem 'capistrano3-unicorn'
  gem 'debase'
  gem 'pry-byebug'             # pryでデバックコマンドが使える
  gem 'pry-rails'              # railsでpryが使える
  gem 'rails-erd' # ER図を生成するためのgem
  gem 'ruby-debug-ide', '0.6.1.beta9'
end

group :test do
  gem 'capybara'               # ブラウザでの操作をシミュレートしてテストができる
  gem 'database_cleaner'       # テスト実行後にDBをクリア
  gem 'factory_girl_rails'     # テストデータの生成
  gem 'rails-controller-testing'
  gem 'rspec-rails' # RailsでRspecが使える
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'awesome_print' # プリントデバッグの出力を整形
  gem 'better_errors' # エラー画面を見やすくする
  gem 'binding_of_caller' # better_errorsのエラー画面でREPLが使える
  gem 'bullet' # 余計なSQLを検出できる
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'tapp' # プリントデバッグがしやすくなる
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
