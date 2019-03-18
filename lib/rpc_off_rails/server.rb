require 'sinatra'

module RpcOffRails
  class Server < Sinatra::Base
    attr_accessor :configuration

    def self.cast_request_method(rpc_method)
      @@configuration.operators.select { |op| op.to_s == rpc_method }.first
    end

    def self.configure
      configuration = Configuration.new
      yield(configuration)
      @@configuration = configuration
      post '/rpc' do
        begin
          begin
            body = JSON.parse(request.body.read)
          rescue Exception => e
           raise RpcOffRails::RPCError.new('invalid body')
          end
          req = Request.new(body)
          op = self.class.cast_request_method(req.method)
          result = op.(*(req.params || []))
          Response.new(jsonrpc: req.jsonrpc, id: req.id.to_s, result: result).to_json
        rescue RpcOffRails::RPCError => e
          { jsonrpc: '2.0', id: nil, error: e.message }.to_json
        end
      end
    end

    def self.configuration
      @@configuration
    end
  end
end
