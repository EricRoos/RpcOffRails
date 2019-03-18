RSpec.describe RpcOffRails::Request do
  describe '::new' do
    let(:jsonrpc){'2.0'}
    let(:method){'addNumber'}
    let(:params){ {a: 1, b:2 } }
    let(:id){ 1 }
    subject { described_class.new(jsonrpc: jsonrpc, method: method, params: params, id: id) }
    it { is_expected.to have_attributes(
      json_rpc: json_rpc,
      id: id,
      method: method
    ) }
  end
end
