# frozen_string_literal: true

require 'notion'

Notion.configure do |config|
  config.token = ENV['NOTION_TOKEN']
end
