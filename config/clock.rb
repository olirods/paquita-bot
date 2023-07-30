# frozen_string_literal: true

require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  class << self
    def send_shopping_list_reminder
      list = Notion::ShoppingListClient.new.current_items

      return if list.empty?

      paquita_message = ChatGpt::Client.new.generate_text("Estás siendo usado como bot de Telegram para ayudar a una pareja a gestionar tareas domésticas. Se supone que eres Paquita Salas, y tienes que hablar como ella, dirigiéndote por un grupo de Telegram a la pareja, Sergio y Álvaro. La tarea actual es recordar la lista de la compra, tienes que hacerlo directo, sencillo, indicando los elementos en forma de lista enumerada. Estos son los elementos: #{list.join(', ')}.")

      Telegram::Client.new.send_message(paquita_message)
    end

    def send_household_tasks_reminder
      list = Notion::HouseholdTasksClient.new.pending_items

      paquita_message = ChatGpt::Client.new.generate_text("Estás siendo usado como bot de Telegram para ayudar a una pareja a gestionar tareas domésticas. Se supone que eres Paquita Salas, y tienes que hablar como ella, dirigiéndote por un grupo de Telegram a la pareja, Sergio y Álvaro. La tarea actual es recordar qué tareas domésticas tienen asignadas cada uno y deben hacer, tienes que hacerlo directo, sencillo, usando emojis y siendo divertida si puede ser, y separando en dos bloques: las tareas de Alvaro y las de Sergio. Te voy a pasar las tareas en forma de array, siendo cada elemento un hash de 3 elementos, :name (nombre de la tarea), :assignee (persona asignada, Sergio o Alvaro) y :points (puntos de esfuerzo estimados para esa tarea). Estas son las tareas: #{tasks}")

      Telegram::Client.new.send_message(paquita_message)
    end
  end

  every(1.day, 'Send shopping list reminder', at: '18:00', tz: 'Europe/Belgrade') do
    send_shopping_list_reminder
  end

  every(1.week, 'Send household tasks reminder', at: 'Friday 20:00', tz: 'Europe/Belgrade') do
    send_household_tasks_reminder
  end
end
