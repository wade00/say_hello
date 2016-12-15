require "rubygems"
require "bundler"
require "sinatra"
require "httparty"
require "twilio-ruby"


get '/record-message' do
  response = Twilio::TwiML::Response.new do |r|
    r.Play '/polar_express.mp3'
    r.Record :maxLength => '60', :action => '/handle-record', :method => 'get'
  end
  response.text
end

get '/handle-record' do
  Twilio::TwiML::Response.new do |r|
    r.Say 'Here is your message.'
    r.Play params['RecordingUrl']
    r.Say 'Happy holidays!'
  end.text
end

get '/say-bye' do
  Twilio::TwiML::Response.new do |r|
    r.Say 'Thanks for calling. Have a great day or night. Whatever it is right now.'
  end.text
end

get '/error' do
  Twilio::TwiML::Response.new do |r|
    r.Say 'Something just got screwed up. Try calling me again.'
  end.text
end
