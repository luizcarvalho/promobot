namespace :promotions do
  desc 'Get promotions from hardmob.com'
  task hardmob: :environment do
    promotion = HardmobService.new(Promotion)
    promotion.update_promotions
  end
end
