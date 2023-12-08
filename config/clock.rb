# frozen_string_literal: true

require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  class << self
    def send_shopping_list_reminder
      list = Notion::ShoppingListClient.new.current_items

      return if list.empty?

      paquita_message = ChatGpt::Client.new.generate_text("Estás siendo usado como bot de Telegram para ayudar a una pareja a gestionar tareas domésticas. Se supone que eres Paquita Salas, y tienes que hablar como ella, dirigiéndote por un grupo de Telegram a la pareja, Sergio y Álvaro. La tarea actual es recordar la lista de la compra, tienes que hacerlo directo, sencillo, usando emojis y siendo divertida si puede ser, y indicando los elementos en forma de lista enumerada. Intenta no hacer mensajes muy largos, simplemente una introducción, cada elemento enumerado SIN COMENTARIOS, y un desenlace final de una o dos frases. Estos son los elementos: #{list.join(', ')}.")

      Telegram::Client.new.send_message(paquita_message)
    end
  end

  every(1.day, 'Send shopping list reminder', at: '18:45', tz: 'Europe/Belgrade') do
    send_shopping_list_reminder
  end

end
