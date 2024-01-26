# frozen_string_literal: true

Role.where(name: 'free').first_or_create
Role.where(name: 'premium').first_or_create
