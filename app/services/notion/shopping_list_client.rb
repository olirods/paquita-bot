# frozen_string_literal: true

module Notion
  class ShoppingListClient < BaseClient
    def current_items
      elements = client.database_query(database_id: database_id, filter: filter_by_added)

      elements.results.map { |item| item.properties.Name.title[0].plain_text }
    end

    private

    attr_reader :client

    def filter_by_added
      {
        'property': 'Add to Shopping list',
        'checkbox': {
          'equals': true
        }
      }
    end

    def database_id
      ENV['NOTION_SHOPPING_LIST_DATABASE_ID']
    end
  end
end
