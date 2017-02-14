require 'rails_helper'

RSpec.describe Promotion, type: :model do
  let(:promotion) { FactoryGirl.build(:promotion) }
  let(:promotion2) { FactoryGirl.build(:promotion) }
  
  it 'cannot be created if same origin and identifier' do
    promotion.save
    expect(promotion2.save).to be_falsy
  end

  it 'can be created if same identifier, but different origin' do
    promotion.save
    promotion2.origin = 'test2'
    expect(promotion2.save).to be_truthy
  end

end
