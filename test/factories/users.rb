FactoryGirl.define do
  factory :user do
    email "woop@tst.com"
    app_id 1
    last_login Time.now
  end
end