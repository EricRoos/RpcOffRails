require './lib/rpc_off_rails'
class Op
  def self.call(a,b)
    a+b
  end
end
class Op2
  def self.call(a,b)
    a*b
  end
end

module Namespace
  class Op
    def self.call(a,b)
      "string #{a+b}"
    end
  end
end

RpcOffRails::Server.configure do |config|
  config.operators = [Op, Op2, Namespace::Op]
end
