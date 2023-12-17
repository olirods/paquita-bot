# frozen_string_literal: true

module Search
    class Client
      def find_story(text, web)
        response = GoogleSearch.new(q: "site:#{web} #{text}", location: "Spain", api_key: api_key)
  
        response.get_hash[:organic_results][0][:link]
      end
  
      private
  
      attr_reader :client
  
      def api_key
        ENV['SEARCH_TOKEN']
      end
    end
  end
  