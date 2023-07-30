# frozen_string_literal: true

module Notion
  class HouseholdTasksClient < BaseClient
    def pending_items
      elements = client.database_query(database_id: database_id, filter: filter_by_to_do)

      elements.results.map do |item|
        {
          name: item.properties.Name.title[0].plain_text,
          assignee: item.properties.Assignee.relation[0].id == "0fad1bd0-e473-473f-8d80-072f456534b6" ? "Alvaro" : "Sergio",
          points: item.properties.Points.number
        }
      end
    end

    private

    attr_reader :client

    def filter_by_to_do
      {
        "property": 'Status',
        "status": {
          "equals": 'To Do'
        }
      }
    end

    def database_id
      ENV['NOTION_HOUSEHOLD_TASKS_DATABASE_ID']
    end
  end
end
