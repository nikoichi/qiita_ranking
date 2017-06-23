namespace :qiita_api do
  def make_client
    Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
  end

  def update_or_create_tag(client, tag)
    response = client.get_tag(tag)
    p body = response.body
    tag_params = QiitaTag.make_params(body)
    qiita_tag = QiitaTag.find_or_initialize_by(name: tag_params['name'])
    qiita_tag.update!(tag_params)
    # TODO: 例外処理記載
    p response.headers
    p response.status
  end

  def update_or_create_user(client, user)
    response = client.get_user(user)
    p body = response.body
    user_params = QiitaUser.make_params(body)
    qiita_user = QiitaUser.find_or_initialize_by(nickname: user_params['nickname'])
    qiita_user.update!(user_params)
    # TODO: 例外処理記載
    p response.headers
    p response.status
  end

  desc '名前を指定してタグを取得(引数は#で区切って複数記述可)'
  task :get_tag, ['name'] => :environment do |_task, args|
    client = make_client
    # 引数に#で区切った複数の名前を指定できるような処理とした
    tags = args.name.split('#')
    tags.each do |tag|
      update_or_create_tag(client, tag)
    end
  end

  desc '指定したユーザーを取得'
  task :get_user, ['name'] => :environment do |_task, args|
    client = make_client
    user = args.name
    update_or_create_user(client, user)
  end
end
