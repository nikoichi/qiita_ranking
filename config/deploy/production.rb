set :rails_env, :production
set :branch, 'master'

server 'qiita-ranking', user: 'nikoichi', roles: %w(web app db)
