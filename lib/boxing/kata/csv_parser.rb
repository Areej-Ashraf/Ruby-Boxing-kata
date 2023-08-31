require 'csv'

module Boxing
  module Kata
    class CsvParser
      def initialize(filepath)
        @data = CSV.open(filepath, headers: true, skip_blanks: true, header_converters: :symbol).map(&:to_h)
      end

      def extract_color_counts
        @data.select { |hash| hash[:brush_color] && !hash[:brush_color].empty? }
            .group_by { |hash| hash[:brush_color] }
            .transform_values(&:count)
      end

      def extract_contract_effective_date
        @data.map { |hash| hash[:contract_effective_date] }.compact.first
      end
    end
  end
end

