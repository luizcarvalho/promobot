namespace :promotions do
  desc 'Get promotions from hardmob.com'
  task hardmob: :environment do
    promotion = HardmobService.new(Promotion)
    promotion.fetch_lasts_promotions
  end

  desc 'Get promotions from tonolucro.com.br'
  task zebra: :environment do
    Promotion.delete_all
    promotion = TonolucroService.new(Promotion)
    promotion.fetch_lasts_promotions
  end

  desc 'Get promotions from zebraurbana.com.br'
  task zebra: :environment do
    Promotion.delete_all
    promotion = ZebraService.new(Promotion)
    promotion.fetch_lasts_promotions
  end

  desc 'run all promotions tasks'
  task all: [:zebra, :zebra, :hardmob]
end
