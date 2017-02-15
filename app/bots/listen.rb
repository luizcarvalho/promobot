require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

@promotion_bot = PromotionBot.new

Bot.on :message do |message|
  begin
    deliver(message)
  rescue Facebook::Messenger::Bot::RecipientNotFound
    puts 'Erro com destinatário'
  rescue StandardError => e
    puts "Error: #{e.message}"
    deliver(message, standard_error_message)
  end
end

def deliver(message, replace_message = nil)
  message_text = replace_message || promotions_for(message.text)
  Bot.deliver(
    {
      recipient: message.sender,
      message: message_text
    },
    access_token: ENV['ACCESS_TOKEN']
  )
end

def promotions_for(message)
  @promotion_bot.search_and_format_for(message)
end

def standard_error_message
  { text: 'Eita, não entendi isso! Vamos tentar de novo! :D' }
end
