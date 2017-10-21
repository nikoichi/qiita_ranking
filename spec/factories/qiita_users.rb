FactoryGirl.define do
  factory :qiita_user do
    nickname 'MyString'
    permanent_id 1
    name 'MyString'
    facebook_id 'MyString'
    github_id 'MyString'
    linkedin_id 'MyString'
    twitter_screen_id 'MyString'
    organization nil
    profile_image_url 'MyString'
    website_url 'MyString'
    location 'MyString'
    description 'MyText'
    followees_count 1
    followers_count 1
    items_count 1
    items_is_got false
    deleted_at '2017-06-21 16:50:20'
  end
end
