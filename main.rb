require 'yt'
require 'dotenv/load'

Yt.configure do |config|
  config.api_key = ENV["api_key"]
  config.client_id = ENV["client_id"]
  config.client_secret = ENV["client_secret"]
end

def generate_new_description(description)
  divider = "PEACE!"
  if description.include? divider
    matches = description.split(divider)
    new_desc = matches[0] + divider + File.read("info")
    new_desc
  else
    puts "##### Description did not contain: #{divider} #####"
    description
  end
end

account = Yt::Account.new refresh_token: ENV["refresh_token"]
videos = account.videos

videos.each do |collection_video|
  video = Yt::Video.new id: collection_video.id, auth: account
  puts "Processing: #{video.title}"
  new_description = generate_new_description(video.description)
  video.update description: new_description
end
