require 'clockwork'
require './config/boot'
require './config/environment'
require './lib/telegram/client'

module Clockwork
  class << self
    def send_shopping_list_update
      notion_client = Notion::Client.new
      telegram_client = Telegram::Client.new

      filter = {
        'property': 'Add to Shopping list',
        'checkbox': {
          'equals': true
        }
      }

      elements = notion_client.database_query(database_id: '629199223c6949f4afde6ecf4d871aa9', filter: filter)

      list = []
      elements.results.map do |item|
        list << item.properties.Name.title[0].plain_text
      end

      telegram_client.send_message("Hola chiques, en vuestra lista de la compra tenéis apuntado: #{list.join(', ')}")
    end
  end

  every(1.day, 'Send shopping list update', at: '18:00', tz: "Europe/Belgrade") do
    send_shopping_list_update
  end
end
