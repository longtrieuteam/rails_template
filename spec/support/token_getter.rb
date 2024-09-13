# frozen_string_literal: true

class TokenGetter
  def self.call(user_attr)
    new(user_attr).call
  end

  def initialize(user_attr)
    @user_attr = user_attr
  end

  def call
    token_getter
  end

  private

  attr_reader :user_attr

  def token_getter
    url = UrlBuilder.call('auth/token')
    response = Http::Requester.make_request(:post, url, user_attr)

    response.body[:token]
  end
end
