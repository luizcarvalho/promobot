require 'facebook/messenger'

include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  Bot.deliver({
                recipient: message.sender,
                message: {
                  text: message.text || 'Hahaha eu não consegui ler isso! :P'
                }
              },
              access_token: ENV['ACCESS_TOKEN'])
end

=begin
{"sender"=>{"id"=>"1340122152715027"},
   "recipient"=>{"id"=>"1118949694898603"},
   "timestamp"=>1487027885809,
   "message"=>
    {"mid"=>"mid.1487027885809:7f2808c346",
     "seq"=>47022,
     "attachments"=>
      [{"type"=>"image", "payload"=>{"url"=>"https://scontent.xx.fbcdn.net/v/t34.0-12/16735946_10210591940408324_827254661_n.gif?_nc_ad=z-m&oh=9e6d0e33da4c3127fd2fd05a6e517eb6&oe=58A4508D"}}]}}
=end