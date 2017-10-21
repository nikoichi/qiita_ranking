FactoryGirl.define do
  factory :qiita_user_error_log do
    qiita_user nil
    error_message 'MyString'
    error_type 'MyString'
  end
end
