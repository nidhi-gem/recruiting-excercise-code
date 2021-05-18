require 'rails_helper'
require 'exchangeable'

RSpec.describe Exchangeable do

  describe 'retrieve_exchange_rate' do
    subject(:exchangeable) { described_class.new(params).retrieve_exchange_rate }

    context 'with and currency type' do
      let(:params) { { currency: 'USD' } }

      it 'returns the currency rate for USD' do
        expect(exchangeable).to include('USD')
        expect(exchangeable.second.to_f).to be_a_kind_of(Float)
      end
    end

    context 'with and currency type' do
      let(:params) { { currency: 'GBP' } }

      it 'returns the currency rate for GBP' do
        expect(exchangeable).to include('GBP')
        expect(exchangeable.second.to_f).to be_a_kind_of(Float)
      end
    end

    context 'with and currency type' do
      let(:params) { { currency: 'PHP' } }

      it 'returns the currency rate for PHP' do
        expect(exchangeable).to include('PHP')
        expect(exchangeable.second.to_f).to be_a_kind_of(Float)
      end
    end

    context 'with and currency type' do
      let(:params) { { currency: 'EUR' } }

      it 'returns the currency rate for EUR' do
        expect(exchangeable).to include('EUR')
        expect(exchangeable.second).to eq('1')
      end
    end
  end
end
