require 'spec_helper'
require 'boxing/kata/constants'

RSpec.describe Boxing::Kata::Boxer do
  let(:color_counts) { { 'blue' => 3, 'red' => 5, 'green' => 2 } }
  let(:contract_effective_date) { '2022-01-01' }
  let(:boxer) { described_class.new(color_counts, contract_effective_date) }

  describe '#generate_starter_box_hashes' do
    it 'generates starter box hashes' do
      expect(boxer.boxes).to be_empty
      expect {
        boxer.generate_starter_box_hashes
      }.to change { boxer.boxes.length }.from(0).to(5)

      expect(boxer.boxes).to all(include(type: "STARTER BOX"))
    end
  end

  describe '#generate_refill_box_hashes' do
    it 'generates refill box hashes' do
      expect(boxer.boxes).to be_empty
      expect {
        boxer.generate_refill_box_hashes
      }.to change { boxer.boxes.length }.from(0).to(3)

      expect(boxer.boxes).to all(include(type: "REFILL BOX"))
    end
  end

  describe '#generate_shipping_schedule' do
    it 'assigns shipping schedule to boxes' do
      expect(boxer.boxes).to be_empty
      boxer.generate_starter_box_hashes
      expect {
        boxer.generate_shipping_schedule
      }.to change { boxer.boxes.map(&:keys).flatten.include?(:schedule) }.from(false).to(true)
    end

    it 'assigns correct shipping schedule to starter boxes' do
      expect(boxer.boxes).to be_empty
      boxer.generate_starter_box_hashes
      boxer.generate_shipping_schedule
      starter_boxes = boxer.boxes_type('STARTER BOX')
      expect(starter_boxes).to all(have_key(:schedule))
      expect(starter_boxes.map { |box| box[:schedule] }.uniq).to eq([contract_effective_date])
    end

    it 'assigns correct shipping schedule to refill boxes' do
      expect(boxer.boxes).to be_empty
      boxer.generate_refill_box_hashes
      boxer.generate_shipping_schedule
      refill_boxes = boxer.boxes_type('REFILL BOX')
      expect(refill_boxes).to all(have_key(:schedule))
      expected_schedule = [
        (Date.parse(contract_effective_date) + 90).strftime('%Y-%m-%d'),
      ]
      expect(refill_boxes.map { |box| box[:schedule] }.uniq.first).to include(expected_schedule[0])
    end
  end

  describe '#generate_mail_class' do
    before do
      allow(boxer).to receive(:calculate_mail_class).and_return('priority')
    end

    it 'assigns mail class to boxes' do
      expect(boxer.boxes).to be_empty
      boxer.generate_starter_box_hashes
      expect {
        boxer.generate_mail_class
      }.to change { boxer.boxes.map(&:keys).flatten.include?(:mail_class) }.from(false).to(true)
    end

    it 'assigns correct mail class to boxes' do
      expect(boxer.boxes).to be_empty
      boxer.generate_starter_box_hashes
      boxer.generate_mail_class
      expect(boxer.boxes).to all(have_key(:mail_class).and(have_value('priority')))
    end
  end

  describe '#generate_paste_kits' do
    before do
      allow(boxer).to receive(:calculate_mail_class).and_return('priority')
    end

    it 'assigns paste kits and mail class to boxes' do
      expect(boxer.boxes).to be_empty
      boxer.generate_starter_box_hashes
      expect {
        boxer.generate_paste_kits
      }.to change { boxer.boxes.map(&:keys).flatten.include?(:paste_kits) }.from(false).to(true)
        .and(change { boxer.boxes.map(&:keys).flatten.include?(:mail_class) }.from(false).to(true))
    end

    it 'assigns correct paste kits and mail class to boxes' do
      expect(boxer.boxes).to be_empty
      boxer.generate_starter_box_hashes
      boxer.generate_paste_kits
      expect(boxer.boxes).to all(have_key(:paste_kits).and(have_value(2)))
      expect(boxer.boxes).to all(have_key(:mail_class).and(have_value('priority')))
    end
  end

  describe '#boxes_type' do
    let(:sample_boxes) do
      [
        { type: 'STARTER BOX' },
        { type: 'STARTER BOX' },
        { type: 'REFILL BOX' },
        { type: 'REFILL BOX' }
      ]
    end

    before { boxer.instance_variable_set(:@boxes, sample_boxes) }

    it 'returns the boxes of the specified type' do
      starter_boxes = boxer.boxes_type('STARTER BOX')
      expect(starter_boxes).to all(include(type: "STARTER BOX"))
      expect(starter_boxes.length).to eq(2)

      refill_boxes = boxer.boxes_type('REFILL BOX')
      expect(refill_boxes).to all(include(type: "REFILL BOX"))
      expect(refill_boxes.length).to eq(2)
    end
  end
end
