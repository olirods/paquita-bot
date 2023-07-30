# frozen_string_literal: true

module Notion
  class BaseClient
    def initialize
      @client = Notion::Client.new(token: token)
      @database_id = database_id
    end

    private

    attr_reader :client, :database_id

    def token
      ENV['NOTION_TOKEN']
    end
  end
end
