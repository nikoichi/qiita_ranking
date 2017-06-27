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
      p '【get_tag】'
      ap response.headers
      ap response.status
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
    ap response.headers
    ap response.status
  end

  desc '指定した投稿を取得'
  task :get_item, ['id'] => :environment do |_task, args|
    client = make_client
    item_id = args.id
    response = client.get_item(item_id)
    response_item = response.body
    ap Item.update_or_create(response_item)
    # TODO: 例外処理記載
    p '【get_item】'
    ap response.headers
    ap response.status
  end

  desc 'qiitaの最新の投稿を取得'
  task get_latest_items: :environment do
    client = make_client
    # FIXME: あとで100に変える。per_pageも。
    1.times do |i|
      response = client.list_items(page: i + 1, per_page: 1)
      response_items = response.body
      response_items.each do |response_item|
        ap Item.update_or_create(response_item)
      end
      # TODO: 例外処理記載
      p '【get_item】'
      ap response.headers
      ap response.status
    end
  end

  desc '指定したタグの投稿を取得(引数は#で区切って複数記述可)'
  task :get_tag_items, ['qiita_tag_ids'] => :environment do |_task, args|
    client = make_client
    # 引数に#で区切った複数の名前を指定できるような処理とした
    qiita_tag_ids = args.qiita_tag_ids.split('#').map(&:to_i)
    qiita_tag_ids.each do |qiita_tag_id|
      qiita_tag = QiitaTag.find(qiita_tag_id)
      # ループ内で使用する変数宣言。
      previous_items_count = qiita_tag.items_count_when_acquired || 0
      items_total_count = 0
      # FIXME: あとで100に変える。per_pageも。
      3.times do |i|
        response = client.list_tag_items(qiita_tag.name, { page: i + 1, per_page: 2 })
        response_items = response.body
        response_items.each do |response_item|
          ap Item.update_or_create(response_item)
        end
        # TODO: 例外処理記載
        p '【get_item】'
        ap response.headers
        ap response.status
        # ループ初回に変数設定&rakeタスク実行時の投稿数(items_count_when_acquired)をアップデート
        if i == 0
          items_total_count = response.headers['Total-Count'].to_i
          qiita_tag.update(items_count_when_acquired: items_total_count)
        end
        # 投稿数の差分を全て取得したらループを抜ける
        break if (items_total_count - previous_items_count) / 100 == i
      end
    end
  end

  desc '指定したユーザーの投稿を取得(引数は#で区切って複数記述可)'
  task :get_user_items, ['qiita_user_ids'] => :environment do |_task, args|
    client = make_client
    # 引数に#で区切った複数の名前を指定できるような処理とした
    qiita_user_ids = args.qiita_user_ids.split('#').map(&:to_i)
    qiita_user_ids.each do |qiita_user_id|
      qiita_user = QiitaUser.find(qiita_user_id)
      # ループ内で使用する変数宣言。
      previous_items_count = qiita_user.items_count_when_acquired || 0
      items_total_count = 0
      # FIXME: あとで100に変える。per_pageも。
      1.times do |i|
        response = client.list_user_items(qiita_user.nickname, { page: i + 1, per_page: 1 })
        response_items = response.body
        response_items.each do |response_item|
          ap Item.update_or_create(response_item)
        end
        # TODO: 例外処理記載
        p '【get_item】'
        ap response.headers
        ap response.status
        # ループ初回に変数設定&rakeタスク実行時の投稿数(items_count_when_acquired)をアップデート
        if i == 0
          items_total_count = response.headers['Total-Count'].to_i
          qiita_user.update(items_count_when_acquired: items_total_count)
        end
        # 投稿数の差分を全て取得したらループを抜ける
        break if (items_total_count - previous_items_count) / 100 == i
      end
    end
  end

  desc '指定したタグの投稿のストック数を取得する'
  task :get_stock_total_counts, ['tag_id'] => :environment do |_task, args|
    client = make_client
    items = QiitaTag.find(args.tag_id).items.limit(2)
    items.each do |item|
      response = client.list_item_stockers(item.qiita_item_id)
      total_count = response.headers['Total-Count']
      # # TODO: 例外処理記載
      p '【get_stocl_total_counts】'
      ap StockTotalCount.update_or_create(item.id, total_count)
      ap response.headers
      ap response.status
    end
  end
end
