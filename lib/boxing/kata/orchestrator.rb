require 'tty-prompt'
require 'boxing/kata/csv_parser'
require 'boxing/kata/boxer'
require 'boxing/kata/box_printer'
require 'boxing/kata/constants'

module Boxing
  module Kata
    class Orchestrator
      include BoxerConstants
      def self.run(filepath)
        prompt = TTY::Prompt.new
        puts 'Welcome to the Beam Ruby Kata! What would you like to do?'

        loop do
          choices = [
            { name: 'Load Brush Preferences', value: 1 },
            { name: 'Print Starter Boxes', value: 2 },
            { name: 'Print Refill Boxes', value: 3 },
            { name: 'Print Box Scheduling', value: 4 },
            { name: 'Print Mail Class', value: 5 },
            { name: 'Print Paste Kits', value: 6 },
            { name: 'Exit', value: 7 },
          ]

          user_input = prompt.select('Please select an option below...', choices)
          case user_input
          when 1
            parser = CsvParser.new(filepath)
            @boxer = Boxer.new(parser.extract_color_counts, parser.extract_contract_effective_date)
          when 2
            if @boxer.nil?
              puts 'Preferences must be loaded before boxes can be generated!'
              next
            end
            @boxer.generate_starter_box_hashes
            BoxPrinter.print_boxes(@boxer.boxes_type(STARTER_BOX))
          when 3
            if @boxer.nil?
              puts 'Preferences must be loaded before boxes can be generated!'
              next
            end
            @boxer.generate_refill_box_hashes
            BoxPrinter.print_boxes(@boxer.boxes_type(REFILL_BOX))
          when 4
            if @boxer.nil?
              puts 'Preferences must be loaded before boxes can be generated!'
              next
            end
            @boxer.generate_shipping_schedule
            BoxPrinter.print_boxes(@boxer.boxes)
          when 5
            if @boxer.nil?
              puts 'Preferences must be loaded before boxes can be generated!'
              next
            end
            @boxer.generate_mail_class
            BoxPrinter.print_boxes(@boxer.boxes)
          when 6
            if @boxer.nil?
              puts 'Preferences must be loaded before boxes can be generated!'
              next
            end
            @boxer.generate_paste_kits
            BoxPrinter.print_boxes(@boxer.boxes)
          when 7
            puts 'Quitting! Goodbye!'
            exit(0)
          end
        end
      end
    end
  end
end
