FactoryGirl.define do
  factory :user do |f|
    f.sequence(:email) {|n| "foo#{n}@example.com" }
    f.password "secret123"
    f.nome "usuário teste"
  end
end