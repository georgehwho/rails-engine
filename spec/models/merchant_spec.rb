require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:items) }
  end

  describe 'class methods' do
    context '#paginate' do
      it 'returns an array of merchants w/ a correct limit and offset' do
        create_list(:merchant, 21)
        expect(Merchant.paginate({}).size).to eq(20)
      end
    end
  end
end
