FactoryBot.define do
  factory :request, class: RpcOffRails::Request do
    jsonrpc '2.0'
    add_attribute(:method) { 'add' }
    params [1]
    id "1"
  end
end
