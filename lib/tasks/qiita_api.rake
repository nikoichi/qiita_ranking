namespace :qiita_api do
  def make_client
    Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
  end

  desc '名前を指定してタグを取得(引数は#で区切って複数記述可)'
  task :get_tag, ['name'] => :environment do |_task, args|
    client = make_client
    # 引数に#で区切った複数の名前を指定できるような処理とした
    tag_names = args.name.split('#')
    tag_names.each do |tag_name|
      response = client.get_tag(tag_name)
      response_tag = response.body
      QiitaTag.update_or_create(response_tag)
      # TODO: 例外処理記載
      p response.headers
      p response.status
    end
  end

  desc '指定したユーザーを取得'
  task :get_user, ['name'] => :environment do |_task, args|
    client = make_client
    user_name = args.name
    response = client.get_user(user_name)
    response_user = response.body
    QiitaUser.update_or_create(response_user)
    # TODO: 例外処理記載
    p response.headers
    p response.status
  end

  desc '指定した投稿を取得'
  task :get_item, ['id'] => :environment do |_task, args|
    client = make_client
    item_id = args.id
    response = client.get_item(item_id)
    response_item = response.body
    Item.update_or_create(response_item)
  end

  desc 'qiitaの最新の投稿を取得'
  task get_latest_items: :environment do
    client = make_client
    # FIXME: あとで100に変える。per_pageも。
    1.times do |i|
      response = client.list_items(page: i + 1, per_page: 1)
      response_items = response.body
      response_items.each do |response_item|
        p Item.update_or_create(response_item)
      end
      # TODO: 例外処理記載
      p response.headers
      p response.status
    end
  end

  desc '指定したタグの投稿を取得(引数は#で区切って複数記述可)'
  task :get_tag_items, ['qiita_tag_ids'] => :environment do |_task, args|
    client = make_client
    # 引数に#で区切った複数の名前を指定できるような処理とした
    qiita_tag_ids = args.qiita_tag_ids.split('#').map(&:to_i)
    qiita_tag_ids.each do |qiita_tag_id|
      qiita_tag = QiitaTag.find(qiita_tag_id)
      # FIXME: あとで100に変える。per_pageも。
      1.times do |i|
        response = client.list_tag_items(qiita_tag.name, { page: i + 1, per_page: 1 })
        response_items = response.body
        response_items.each do |response_item|
          p Item.update_or_create(response_item)
        end
        # TODO: 例外処理記載
        p response.headers
        p response.status
      end
    end
  end
end
