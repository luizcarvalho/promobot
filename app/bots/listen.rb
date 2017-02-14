require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

@promotion_bot = PromotionBot.new

Bot.on :message do |message|
  begin
    Bot.deliver(
      {
        recipient: message.sender,
        message: @promotion_bot.search_and_format_for(message.text)
      },
      access_token: ENV['ACCESS_TOKEN']
    )
  rescue
    Bot.deliver(
      {
        recipient: message.sender,
        message: 'Eita, não entendi isso! Vamos tentar de novo! :D'
      },
      access_token: ENV['ACCESS_TOKEN']
    )
  end
end
