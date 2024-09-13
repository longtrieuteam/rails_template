# frozen_string_literal: true

class Resources
  include FactoryBot::Syntax::Methods

  # When defining a member of RESOURCES, for example, "wallet: 'wallets'", it will automatically define
  # the following methods: create_wallet, get_all_wallet, update_wallet, get_wallet, delete_wallet
  RESOURCES = {
    profile: 'auth/token/profile',
    wallet: 'wallets',
    wallet_transaction: 'wallet_transactions',
    category: 'categories',
  }.freeze

  COLLECTION_ACTIONS = { create: :post, get_all: :get }.freeze
  MEMBER_ACTIONS = { update: :put, get: :get, delete: :delete }.freeze

  RESOURCES.each_key do |resource|
    %w[create get get_all update delete].each do |action|
      define_singleton_method("#{action}_#{resource}") do |token, input_body = {}, resource_id = nil|
        new(token, input_body, resource_id).send("#{action}_#{resource}")
      end
    end
  end

  def initialize(token, input_body, resource_id)
    @token = token
    @input_body = input_body
    @resource_id = resource_id
  end

  attr_reader :token, :input_body, :resource_id

  # Dynamically define instance methods
  RESOURCES.each do |resource, endpoint|
    COLLECTION_ACTIONS.each do |action, method|
      define_method("#{action}_#{resource}") do
        data = { resource => input_body }
        url = UrlBuilder.call(endpoint)
        Http::Requester.make_request(method, url, data, headers: { 'X-user-Token': token })
      end
    end

    MEMBER_ACTIONS.each do |action, method|
      define_method("#{action}_#{resource}") do
        data = { resource => input_body }
        url = UrlBuilder.call("#{endpoint}/#{resource_id}")
        Http::Requester.make_request(method, url, data, headers: { 'X-user-Token': token })
      end
    end
  end
end
