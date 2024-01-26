# frozen_string_literal: true

class UrlBuilder
  def self.call(resource)
    new(resource).call
  end

  def initialize(resource)
    @resource = resource
  end

  def call
    url_builder
  end

  private

  attr_reader :resource

  def url_builder
    "#{external_url}/#{resource}"
  end

  def external_url
    @external_url ||= ENV.fetch('EXTERNAL_URL')
  end
end
