# frozen_string_literal: true

require 'spec_helper'
require 'csv'

RSpec.describe Boxing::Kata::CsvParser do
  let(:csv_file_path) { File.join(File.dirname(__FILE__), '../../', 'fixtures', 'family_preferences.csv') }

  let(:csv_parser) { described_class.new(csv_file_path) }

  let(:sample_data) do
    [
      { id: '2', name: 'Anakin', brush_color: 'blue', primary_insured_id: nil, contract_effective_date: '2022-01-01' },
      { id: '3', name: 'Padme', brush_color: 'pink', primary_insured_id: '2', contract_effective_date: nil },
      { id: '4', name: 'Luke', brush_color: 'blue', primary_insured_id: '2', contract_effective_date: nil },
      { id: '5', name: 'Leia', brush_color: 'green', primary_insured_id: '2', contract_effective_date: nil },
      { id: '6', name: 'Ben', brush_color: 'green', primary_insured_id: '2', contract_effective_date: nil }
    ]
  end

  describe '#initialize' do
    it 'loads data from a custom CSV file' do
      expect(csv_parser.instance_variable_get(:@data)).to eq(sample_data)
    end
  end

  describe '#extract_color_counts' do
    it 'returns a hash of brush color counts' do
      csv_parser.instance_variable_set(:@data, sample_data)

      expected_result = { 'blue' => 2, 'pink' => 1, 'green' => 2 }
      expect(csv_parser.extract_color_counts).to eq(expected_result)
    end

    it 'returns an empty hash when there are no brush colors' do
      data_without_brush_color = [
        { id: '2', name: 'Anakin', primary_insured_id: nil, contract_effective_date: '2022-01-01' },
        { id: '3', name: 'Padme', primary_insured_id: '2', contract_effective_date: nil }
      ]
      csv_parser.instance_variable_set(:@data, data_without_brush_color)

      expect(csv_parser.extract_color_counts).to eq({})
    end
  end

  describe '#extract_contract_effective_date' do
    it 'returns the first non-nil contract effective date' do
      csv_parser.instance_variable_set(:@data, sample_data)

      expect(csv_parser.extract_contract_effective_date).to eq('2022-01-01')
    end

    it 'returns nil when all contract effective dates are nil' do
      data_with_nil_dates = [
        { id: '2', name: 'Anakin', brush_color: 'blue', primary_insured_id: '', contract_effective_date: nil },
        { id: '3', name: 'Padme', brush_color: 'pink', primary_insured_id: '2', contract_effective_date: nil }
      ]
      csv_parser.instance_variable_set(:@data, data_with_nil_dates)

      expect(csv_parser.extract_contract_effective_date).to be_nil
    end
  end
end
