FactoryGirl.define do
  factory :subscription do
    subscription_type_id 1
    start_date Time.now
    receipt "010010101010"
    price 13
    association :user
  end
end