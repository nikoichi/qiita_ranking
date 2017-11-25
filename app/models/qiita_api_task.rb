# frozen_string_literal: true

class QiitaApiTask
  def self.qiita_client
    Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
  end

  def self.get_stocks_count(qiita_item_id)
    # TODO: 例外処理記載(ログやめる)
    Rails.logger.info '=== get_stocks_count ==='
    client = qiita_client
    response = client.list_item_stockers(qiita_item_id)
    Rails.logger.info response.headers
    Rails.logger.info response.status
    response.headers['Total-Count'].to_i
  end
end
