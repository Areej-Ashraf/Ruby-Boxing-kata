# frozen_string_literal: true

require 'date'
require 'boxing/kata/constants'

module Boxing
  module Kata
    class Boxer
      include BoxerConstants
      def initialize(color_counts, contract_effective_date)
        @color_counts = color_counts
        @contract_effective_date = contract_effective_date
        @boxes = []
      end

      def generate_starter_box_hashes
        @boxes = generate_boxes
      end

      def generate_refill_box_hashes
        @boxes << generate_boxes(REFILL_BOX)
        @boxes.flatten!
      end

      def generate_shipping_schedule
        shipping_dates = calculate_shipping_schedule
        @boxes.map! do |box|
          case box[:type]
          when STARTER_BOX
            box.merge(schedule: shipping_dates[0])
          when REFILL_BOX
            box.merge(schedule: shipping_dates[1..].join(', '))
          end
        end
      end

      def generate_mail_class
        @boxes.map! do |box|
          box.merge(mail_class: calculate_mail_class(box))
        end
      end

      def generate_paste_kits
        @boxes.map! do |box|
          box.merge(
            paste_kits: box[:brushes] || box[:replacement_heads],
            mail_class: calculate_mail_class(box.merge(paste_kits: box[:brushes] || box[:replacement_heads]))
          )
        end
      end

      def boxes_type(type)
        @boxes.select { |box| box[:type].eql?(type) }
      end

      attr_reader :boxes

      private

      def calculate_mail_class(box_hash)
        total_weight = (box_hash[:brushes] * BRUSH_WEIGHT) +
                       (box_hash[:replacement_heads] * REPLACEMENT_HEAD_WEIGHT) +
                       ((box_hash[:paste_kits] || 0) * PASTE_KIT_WEIGHT)
        total_weight >= MAIL_CLASS_THRESHOLD ? 'priority' : 'first'
      end

      def calculate_shipping_schedule
        start_date = Date.parse(@contract_effective_date)
        end_date = Date.parse(@contract_effective_date) + 365 # Add 1 year
        (start_date..end_date).step(90).map { |date| date.strftime('%Y-%m-%d') }
      end

      def generate_boxes(type = STARTER_BOX)
        max_brush_count = type.eql?(STARTER_BOX) ? 2 : 4
        single_boxes = []
        
        #Taking assumption same color brushes exists in same class
        boxes = @color_counts.flat_map do |color, count|
          box_count, remainder = count.divmod(max_brush_count)
          single_boxes << generate_box_hash(color, remainder, type) if remainder.positive?
          Array.new(box_count, generate_box_hash(color, max_brush_count, type))
        end
        boxes << optimize_box_generation(single_boxes)
        boxes.flatten
      end

      def generate_box_hash(color, brush_count, type)
        {
          type: type, color: [color], brushes: brush_count, replacement_heads: brush_count
        }
      end

      def optimize_box_generation(single_boxes)
        single_boxes.each_slice(2).map do |box, next_box|
          if next_box.nil?
            box
          else
            {
              type: box[:type],
              color: [box[:color], next_box[:color]].flatten,
              brushes: box[:brushes] + next_box[:brushes],
              replacement_heads: box[:replacement_heads] + next_box[:replacement_heads]
            }
          end
        end
      end
    end
  end
end
