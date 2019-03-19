RSpec.describe RpcOffRails::Request do
  describe '::new' do
    let(:jsonrpc){ '2.0' }
    let(:method) { 'add' }
    let(:params){ {} }
    let(:id){ 1 }
    subject { described_class.new(
      jsonrpc: jsonrpc,
      method: method,
      params: params,
      id: id
    )}

    it { is_expected.to have_attributes(
      jsonrpc: jsonrpc,
      method: method,
      params: params,
      id: id
    )}
  end
end
