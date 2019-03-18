require 'byebug'
require 'active_model'
require "rpc_off_rails/version"
require "rpc_off_rails/response"
require "rpc_off_rails/request"
require "rpc_off_rails/configuration"
require "rpc_off_rails/server"

module RpcOffRails
  class Error < StandardError; end
  class RPCError < StandardError; end
  # Your code goes here...
end
