# frozen_string_literal: true

FactoryGirl.define do
  factory :qiita_tag do
    name 'MyString'
    icon_url 'MyString'
    items_count 1
    followers_count 1
    obtained_item_number nil
  end
end
