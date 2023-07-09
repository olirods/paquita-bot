# frozen_string_literal: true

module Notion
  class ShoppingListClient < BaseClient

    def pending_items
      filter = {
        'property': 'Add to Shopping list',
        'checkbox': {
          'equals': true
        }
      }

      elements = client.database_query(database_id: database_id, filter: filter)

      list = []
      elements.results.map do |item|
        list << item.properties.Name.title[0].plain_text
      end

      list
    end
    
    private

    attr_reader :client, :database_id

    def database_id
      ENV['NOTION_SHOPPING_LIST_DATABASE_ID']
    end
  end
end
  