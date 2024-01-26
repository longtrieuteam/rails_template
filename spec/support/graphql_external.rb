# frozen_string_literal: true

class GraphqlExternal
  def self.call(query, variables)
    new(query, variables).call
  end

  def initialize(query, variables)
    @query = query
    @variables = variables
  end

  def call
    Http::Requester.make_request(
      default_method,
      graphql_url,
      graphql_body,
      { headers: authorization_header }
    )
  end

  private

  attr_reader :query, :variables

  def default_method
    @default_method ||= 'post'
  end

  def graphql_url
    @graphql_url ||= ENV.fetch('GRAPHQL_URL')
  end

  def graphql_body
    @graphql_body ||= {
      query:,
      variables:,
    }
  end

  def authorization_header
    @authorization_header ||= { 'Authorization' => "Bearer #{bearer}" }
  end

  def bearer
    @bearer ||= ENV.fetch('BEARER')
  end
end
