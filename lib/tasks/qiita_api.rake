namespace :qiita_api do
  def make_client
    Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
  end

  def update_or_create_tag(body)
    # キー'id'を'name'にリネーム
    body['name'] = body.delete('id')
    qiita_tag = QiitaTag.find_or_initialize_by(name: body['name'])
    qiita_tag.update(body)
  end

  desc '名前を指定してタグを取得(引数は#で区切って複数記述可)'
  task :get_tag, ['name'] => :environment do |_task, args|
    client = make_client
    # 引数に#で区切った複数の名前を指定できるような処理とした
    tags = args.name.split('#')
    tags.each do |tag|
      response = client.get_tag(tag)
      body = response.body
      update_or_create_tag(body)
      # TODO: 例外処理記載
      puts body
      puts response.headers
      puts response.status
    end
  end
end
