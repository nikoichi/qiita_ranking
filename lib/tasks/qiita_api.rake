namespace :qiita_api do
  def make_client
    Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
  end

  # TODO: 例外処理記載
  def make_tag_params(body)
    # キー'id'を'name'にリネーム
    body['name'] = body.delete('id')
    body
  end

  def update_or_create_tag(client, tag)
    response = client.get_tag(tag)
    body = response.body
    tag_params = make_tag_params(body)
    qiita_tag = QiitaTag.find_or_initialize_by(name: tag_params['name'])
    qiita_tag.update!(tag_params)
    # TODO: 例外処理記載
    p body
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
end
