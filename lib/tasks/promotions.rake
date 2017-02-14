namespace :promotions do
  desc 'Get promotions from hardmob.com'
  task hardmob: :environment do
    promotion = HardmobService.new(Promotion)
    promotion.fetch_and_save_all
  end

  desc 'Get promotions from tonolucro.com.br'
  task tonolucro: :environment do
    promotion = TonolucroService.new(Promotion)
    promotion.fetch_and_save_all
  end

  desc 'Get promotions from zebraurbana.com.br'
  task zebra: :environment do
    puts '##### running ZebraService'
    promotion = ZebraService.new(Promotion)
    promotion.fetch_and_save_all
  end

  desc 'run all promotions tasks'
  task all: [:tonolucro, :zebra, :hardmob]
end
