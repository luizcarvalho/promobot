require 'rails_helper'

RSpec.describe PromotionBot do
  let(:promotion_bot) { PromotionBot.new }
  let(:promotion) { FactoryGirl.create(Promotion) }
  it '#format_promotion_message is a hash' do
    promotion
    expect(promotion_bot.search_and_format_for('lorem')).to be_a(Hash)
  end
end