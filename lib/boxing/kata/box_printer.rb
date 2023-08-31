# frozen_string_literal: true

module Boxing
  module Kata
    class BoxPrinter
      def self.print_boxes(box_hashes)
        box_hashes.each do |box|
          next if box[:brushes].eql?(0)

          print_box_contents(box)
          print_box_mail_class(box) if box[:mail_class]
          print_box_shipping_schedule(box) if box[:schedule]
        end
      end

      def self.print_box_contents(box)
        puts (box[:type]).to_s
        box[:color].each do |color|
          count = get_count(box)
          puts "#{count} #{color} brush#{count > 1 ? 'es' : ''}" if box[:brushes]
          puts "#{count} #{color} replacement head#{count > 1 ? 's' : ''}"
        end
        puts "#{box[:paste_kits]} paste kit#{box[:paste_kits] > 1 ? 's' : ''}" if box[:paste_kits]
      end

      def self.print_box_mail_class(box)
        puts "Mail class: #{box[:mail_class]}"
      end

      def self.print_box_shipping_schedule(box)
        puts "Schedule: #{box[:schedule]}"
      end

      def self.get_count(box)
        box[:color].length.eql?(1) ? box[:brushes] : 1
      end
    end
  end
end
