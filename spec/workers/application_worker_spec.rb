# frozen_string_literal: true

require 'rails_helper'

describe ApplicationWorker do
  it 'includes Sidekiq::Worker' do
    expect(ApplicationWorker.ancestors).to include(Sidekiq::Worker)
  end
end
