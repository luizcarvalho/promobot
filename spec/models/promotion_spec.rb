require 'rails_helper'

RSpec.describe Promotion, type: :model do
  let(:promotion) { FactoryGirl.build(:promotion) }
  let(:promotion2) { FactoryGirl.build(:promotion) }
  
  it 'Promotion cannot be same origin and identifier' do
    promotion.save
    expect(promotion2.save).to be_falsy
  end
end
