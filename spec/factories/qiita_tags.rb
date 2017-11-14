# frozen_string_literal: true

FactoryGirl.define do
  factory :qiita_tag do
    name 'MyString'
    icon_url 'MyString'
    items_count 1
    followers_count 1
    obtained_item_number nil
    deleted_at '2017-06-21 17:42:37'
  end
end
