require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  class << self
    def send_shopping_list_update
      
      list = Notion::ShoppingListClient.new.pending_items

      unless list.empty?
        Telegram::Client.new.send_message("Hola chiques, en vuestra lista de la compra tenéis apuntado: #{list.join(', ')}")
      end
    end
  end

  every(1.day, 'Send shopping list update', at: '18:00', tz: "Europe/Belgrade") do
    send_shopping_list_update
  end
end
