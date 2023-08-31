# frozen_string_literal: true

require 'spec_helper'
require 'boxing/kata/box_printer'

RSpec.describe Boxing::Kata::BoxPrinter do
  describe '.print_boxes' do
    let(:box_hashes) do
      [
        { type: 'STARTER BOX', color: ['blue'], brushes: 2, replacement_heads: 2 },
        { type: 'REFILL BOX', color: ['red'], brushes: 0, replacement_heads: 0 },
        { type: 'STARTER BOX', color: ['green'], brushes: 1, replacement_heads: 1 }
      ]
    end

    it 'prints box contents for non-empty boxes' do
      expect { described_class.print_boxes(box_hashes) }
        .to output(/STARTER BOX\n2 blue brushes\n2 blue replacement heads\nSTARTER BOX\n1 green brush\n1 green replacement head/).to_stdout
    end

    it 'does not print empty boxes' do
      expect { described_class.print_boxes(box_hashes) }
        .to_not output(/REFILL BOX/).to_stdout
    end

    it 'prints mail class when available' do
      box_with_mail_class = { type: 'STARTER BOX', color: ['blue'], brushes: 2, replacement_heads: 2, mail_class: 'priority' }
      expect { described_class.print_boxes([box_with_mail_class]) }
        .to output(/Mail class: priority/).to_stdout
    end

    it 'prints shipping schedule when available' do
      box_with_schedule = { type: 'STARTER BOX', color: ['blue'], brushes: 2, replacement_heads: 2, schedule: '2022-01-01' }
      expect { described_class.print_boxes([box_with_schedule]) }
        .to output(/Schedule: 2022-01-01/).to_stdout
    end
  end
end
