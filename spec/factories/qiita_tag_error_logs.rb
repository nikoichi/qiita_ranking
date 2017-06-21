FactoryGirl.define do
  factory :qiita_tag_error_log do
    qiita_tag nil
    error_message "MyString"
    error_type "MyString"
  end
end
