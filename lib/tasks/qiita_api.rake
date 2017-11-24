# frozen_string_literal: true

namespace :qiita_api do
  def qiita_client
    Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
  end

  desc '名前を指定してタグを取得(引数は#で区切って複数記述可)'
  task :get_tag, ['name'] => :environment do |_task, args|
    client = qiita_client
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
    client = qiita_client
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
    client = qiita_client
    item_id = args.id
    response = client.get_item(item_id)
    ap Item.update_or_create(response_item)
    # TODO: 例外処理記載
    p '【get_item】'
    ap response.headers
    ap response.status
  end

  desc 'qiitaの最新の投稿を取得'
  task get_latest_items: :environment do
    client = qiita_client
    # FIXME: ログを保存するテーブルを作り、取得できた投稿の最新の投稿の番号を保持。処理実行回数の最適化に使用する。
    100.times do |i|
      response = client.list_items(page: 100 - i, per_page: 100)
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
  task :get_tags_items, ['qiita_tag_ids'] => :environment do |_task, args|
    client = qiita_client
    # 引数に#で区切った複数の名前を指定できるような処理とした
    qiita_tag_ids = args.qiita_tag_ids.split('#').map(&:to_i)
    qiita_tag_ids.each do |qiita_tag_id|
      qiita_tag = QiitaTag.find(qiita_tag_id)
      # 取得済みの投稿数と現在の投稿数を設定。
      previous_items_count = qiita_tag.obtained_item_number || 0
      response = client.list_tag_items(qiita_tag.name, { page: 1, per_page: 1 })
      # FIXME: Total-Countなくなってる。要修正
      items_total_count = response.headers['Total-Count'].to_i
      # ループ回数設定
      loop_number = (items_total_count - previous_items_count) / Settings.qiita_api.pages_number + 1
      loop_number = Settings.qiita_api.pages_number if loop_number > Settings.qiita_api.pages_number
      loop_number.times do |i|
        remaining_pages_number = loop_number - i
        response = client.list_tag_items(qiita_tag.name, { page: remaining_pages_number,
                                                           per_page: Settings.qiita_api.items_number })
        response_items = response.body
        response_items.each do |response_item|
          ap Item.update_or_create(response_item)
        end
        # TODO: 例外処理記載
        p '【get_item】'
        ap response.headers
        ap response.status
        # TODO: 意図通りの回数になっているか確認。
        qiita_tag.update(obtained_item_number: items_total_count - (remaining_pages_number - 1) * Settings.qiita_api.items_number)
        # APIを叩く回数の制限が少なくなったらrakeタスクを終了。ブロック内のrakeタスクから抜けるにはfailを使うとのこと。
        if response.headers['Rate-Remaining'].to_i < Settings.qiita_api.remaining_number_for_break
          p '制限近いから終了'
          fail
        end
      end
    end
  end

  desc '指定したユーザーの投稿を取得(引数は#で区切って複数記述可)'
  task :get_user_items, ['qiita_user_ids'] => :environment do |_task, args|
    client = qiita_client
    # 引数に#で区切った複数の名前を指定できるような処理とした
    qiita_user_ids = args.qiita_user_ids.split('#').map(&:to_i)
    qiita_user_ids.each do |qiita_user_id|
      qiita_user = QiitaUser.find(qiita_user_id)
      # ループ内で使用する変数宣言。
      previous_items_count = qiita_user.obtained_item_number || 0
      items_total_count = 0
      # FIXME: あとで100に変える。per_pageも。
      100.times do |i|
        response = client.list_user_items(qiita_user.nickname, { page: i + 1, per_page: 100 })
        response_items = response.body
        response_items.each do |response_item|
          ap Item.update_or_create(response_item)
        end
        # TODO: 例外処理記載
        p '【get_item】'
        ap response.headers
        ap response.status
        # ループ初回に変数設定&rakeタスク実行時の投稿数(obtained_item_number)をアップデート
        if i == 0
          items_total_count = response.headers['Total-Count'].to_i
          qiita_user.update(obtained_item_number: items_total_count)
        end
        # 投稿数の差分を全て取得したらループを抜ける
        break if (items_total_count - previous_items_count) / 100 == i
      end
    end
  end

  desc '指定したタグの投稿のストック数を取得する'
  task :get_stock_total_counts, ['tag_id'] => :environment do |_task, args|
    client = qiita_client
    items = QiitaTag.find(args.tag_id).items
    items.each do |item|
      response = client.list_item_stockers(item.qiita_item_id)
      stocks_count = response.headers['Total-Count']
      # # TODO: 例外処理記載
      p '【get_stocl_stocks_counts】'
      ap item.update(stocks_count: stocks_count, stocks_count_updated_at: Time.zone.now)
      ap response.headers
      ap response.status
    end
  end
end
