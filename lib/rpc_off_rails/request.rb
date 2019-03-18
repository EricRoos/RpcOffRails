module RpcOffRails
  class Request
    include ActiveModel::Model
    include ActiveModel::Validations
    include ActiveModel::Serializers::JSON

    validates_presence_of :jsonrpc, :method, :params, :id

    attr_accessor :jsonrpc, :method, :params, :id

    def as_json(params={})
      super(params.merge(except: []))
    end

    def attributes
      instance_values
    end
  end
end
