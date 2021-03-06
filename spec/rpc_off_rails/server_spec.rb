RSpec.describe RpcOffRails::Server do
  let(:expected_operator_return) { 3 }
  let(:op_name) { 'AddOp' }
  let(:op_params) { [1,2] }
  let(:operator) {
    class_double(op_name).tap do |instance|
      allow(instance).to receive(:to_s).and_return(op_name)
    end
  }

  before do
    described_class.configure do |server|
      server.operators = [ operator ]
    end
  end

  describe '::configure' do
    describe 'the configuration' do
      subject { described_class.configuration }
      it { is_expected.to have_attributes(
        operators: [ operator ]
      ) }
    end
  end

  describe '::run' do
    let(:params) { build(:request, method: op_name, params: op_params) }
    before do
      allow_any_instance_of(RpcOffRails::Request).to receive(:valid?).and_return(valid_request?)
      if valid_request?
        expect(operator).to receive(:call).and_return(expected_operator_return)
      end
      post '/rpc', params.to_json, { 'CONTENT_TYPE' => 'application/json' }
    end
    context 'when request is valid' do
      let(:valid_request?) { true }
      describe 'the response' do
        subject { last_response }
        it { is_expected.to be_ok }
      end
      describe 'the response body' do
        subject { RpcOffRails::Response.new(JSON.parse(last_response.body)) }
        it { is_expected.to have_attributes(
          jsonrpc: '2.0',
          result: expected_operator_return,
          id: params.id
        )}
      end
    end
    context 'when the request is invalid' do
      let(:valid_request?) { false }
      describe 'the response' do
        subject { last_response }
        it { is_expected.to_not be_ok }
      end
      describe 'the response body' do
        subject { RpcOffRails::Response.new(JSON.parse(last_response.body)) }
        it { is_expected.to have_attributes(
          jsonrpc: '2.0',
          error: 'invalid request'
        )}
      end
    end
  end
end
