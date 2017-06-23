namespace :qiita_api do
  def make_client
    Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
  end

  desc '名前を指定してタグを取得(引数は#で区切って複数記述可)'
  task :get_tag, ['name'] => :environment do |_task, args|
    client = make_client
    # 引数に#で区切った複数の名前を指定できるような処理とした
    tags = args.name.split('#')
    tags.each do |tag|
      response = client.get_tag(tag)
      p response_tag_params = response.body
      QiitaTag.update_or_create(response_tag_params)
      # TODO: 例外処理記載
      p response.headers
      p response.status
    end
  end

  desc '指定したユーザーを取得'
  task :get_user, ['name'] => :environment do |_task, args|
    client = make_client
    user = args.name
    response = client.get_user(user)
    p response_user_params = response.body
    QiitaUser.update_or_create(response_user_params)
    # TODO: 例外処理記載
    p response.headers
    p response.status
  end
end
