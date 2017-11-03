FactoryGirl.define do
  factory :item do
    qiita_item_id 'MyString'
    title 'MyString'
    qiita_user { create(:qiita_user) }
    url 'MyString'
    is_private false
    description 'MyText'
    qiita_created_at '2017-06-21 17:09:17'
    qiita_updated_at '2017-06-21 17:09:17'
    deleted_at '2017-06-21 17:09:17'
  end
end
