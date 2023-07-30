# frozen_string_literal: true

require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  class << self
    def send_shopping_list_update
      list = Notion::ShoppingListClient.new.pending_items

      return if list.empty?

      paquita_message = ChatGpt::Client.new.generate_text("Estás siendo usado como bot de Telegram para ayudar a una pareja a gestionar tareas domésticas. Se supo
          ne que eres Paquita Salas, y tienes que hablar como ella, dirigiéndote por un grupo de Telegram a la pareja, Sergio y Álvaro. La tarea actual es r
          ecordar la lista de la compra, tienes que hacerlo directo, sencillo, indicando los elementos en forma de lista enumerada. Estos son los elementos: #{list.join(', ')}.")

      Telegram::Client.new.send_message(paquita_message)
    end
  end

  every(1.day, 'Send shopping list update', at: '18:00', tz: 'Europe/Belgrade') do
    send_shopping_list_update
  end
end
