namespace :promotions do
  desc 'Get promotions from hardmob.com'
  task hardmob: :environment do
    promotion = HardmobService.new(Promotion)
    promotion.fetch_lasts_promotions
  end

  desc 'Get promotions from tonolucro.com.br'
  task tonolucro: :environment do
    promotion = TonolucroService.new(Promotion)
    promotion.fetch_lasts_promotions
  end
end
