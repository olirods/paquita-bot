# frozen_string_literal: true

require 'telegram/bot'

module Telegram
  class Client
    def initialize
      Telegram::Bot::Client.run(token) do |bot|
        @bot = bot
      end
    end

    def send_message(text)
      bot.api.send_message(chat_id:, text:)
    end

    private

    attr_reader :bot

    def chat_id
      ENV['TELEGRAM_CHAT_ID']
    end

    def token
      ENV['TELEGRAM_TOKEN']
    end
  end
end
