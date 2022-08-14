require 'uri'
require 'net/http'

module ApplicationHelper
  def current_nav_link(path)
    Regexp.new(path.to_s).match?(request.path)
  end

  def full_title(page_title = '')
    base_title = 'Calendaree'

    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def send_to_discord(str)
    # TODO: move to controller
    discord_webhook_id = ENV['DISCORD_WEBHOOK_ID']
    discord_webhook_token = ENV['DISCORD_WEBHOOK_TOKEN']
    discord_webhook_api = ENV['DISCORD_WEBHOOK_API']
    discord_webhook = "#{discord_webhook_api}/#{discord_webhook_id}/#{discord_webhook_token}"

    if discord_webhook_id && discord_webhook_token && discord_webhook_api
      uri = URI(discord_webhook)
      content = "@everyone #{str}" + "\n\n" + 'go to'

      res = Net::HTTP.post uri,
                           {
                             content:,
                             allowed_mentions: { parse: ['everyone'] }
                           }.to_json,
                           'Content-Type' => 'application/json'

      puts res.body

    else
      puts 'ELSE'
    end
  end
end
