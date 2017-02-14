require 'rails_helper'

RSpec.describe Promotion, type: :model do
  it 'Promotion cannot be same origin and identifier' do
    FactoryGirl.create(:promotion)    
  end
end
