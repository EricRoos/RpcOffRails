module RpcOffRails
  class Response
    include ActiveModel::Model
    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON

    validates_presence_of :jsonrpc, :result, :error, :id

    attr_accessor :jsonrpc, :result, :error, :id

    def as_json(params={})
      super(params.merge(except: []))
    end

    def attributes
      instance_values
    end
  end
end
