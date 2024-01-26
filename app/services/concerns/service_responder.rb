# frozen_string_literal: true

module ServiceResponder
  private

  def success(resource)
    OpenStruct.new(success?: true, resource:) # rubocop:disable Style/OpenStructUse
  end

  def error(resource)
    OpenStruct.new(success?: false, resource:, errors: resource.errors) # rubocop:disable Style/OpenStructUse
  end
end
