# frozen_string_literal: true

module ChatGpt
  class Client
    def initialize
      @client = OpenAI::Client.new(access_token: access_token)
    end

    def generate_text(input)
      response = client.chat(
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: [{ role: 'user', content: input }]
        }
      )

      response.dig('choices', 0, 'message', 'content')
    end

    private

    attr_reader :client

    def access_token
      ENV['OPEN_AI_TOKEN']
    end
  end
end
