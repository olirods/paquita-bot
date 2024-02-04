# frozen_string_literal: true

module Search
    class Client
      def find_story(text, web)
        response = GoogleSearch.new(q: "site:#{web} #{text}", location: "Spain", api_key: api_key)
  
        response.get_hash[:organic_results][0][:link]
      end

      def find_images(term)
        response = GoogleSearch.new(q: term, tbm: "isch", location: "Spain", hl: "es", gl: "es", api_key: api_key)

        response.get_hash[:images_results]
      end
  
      private
  
      attr_reader :client
  
      def api_key
        ENV['SEARCH_TOKEN']
      end
    end
  end
  