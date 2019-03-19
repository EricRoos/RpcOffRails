RSpec.describe RpcOffRails::Response do
  describe '::new' do
    let(:jsonrpc){ '2.0' }
    let(:result) { 'add' }
    let(:error){ nil }
    let(:id){ 1 }
    subject { described_class.new(
      jsonrpc: jsonrpc,
      result: result,
      error: error,
      id: id
    )}

    it { is_expected.to have_attributes(
      jsonrpc: jsonrpc,
      result: result,
      error: error,
      id: id
    )}
  end
end
