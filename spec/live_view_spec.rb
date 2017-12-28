require 'spec_helper'

describe 'Live View functionality' do

  context 'link stats are correct' do
    before(:each) do
      @user = {email: ENV['user_email'], password: ENV['user_password']}
      # generate link (api):
      params = {
          "branch_key" => ENV["branch_key"],
          "campaign" => "QATesting",
          "channel" => "Automation",
          "tags" => [
              "Vitalii"
          ],
          "type" => 2
      }

      response = DeepLink.new.create_deep_link(params)
      expect(response.code).to eq("200")

      puts "Response code: #{response.code}"
      puts "Response body: #{JSON.parse(response.body)}"
      @deep_link_url = JSON.parse(response.body)['url']

      # login:
      app.login_page.load
      app.login_page.login(@user)
      app.home_page.loaded?
    end

    it 'link stats are correct when click link from Android device ...' do
      # in Branch Dashboard; go to Liveview; Links page and see your link there
      app.live_view_page.load
      shorten_url = @deep_link_url.gsub('https://', '')
      expect(app.live_view_page).to have_content(shorten_url)
      # get link id:
      link_id = app.live_view_page.find_link_id(shorten_url)

      # current number of clicks fot the link:
      app.link_stats_page.load(link_id: link_id)
      current_clicks = app.link_stats_page.android_clicks.text.to_i

      # simulate clicking link using an Android user agent:
      request = RestClientCall.new
      endpoint = @deep_link_url + "?uniq_id=#{SecureRandom.uuid}"
      response = request.get(endpoint, nil, :header => {'User-Agent' => ENV['user_agent']})

      app.live_view_clicks_page.load
      app.live_view_clicks_page.wait_for_load_new_cliks(60)
      app.live_view_clicks_page.load_new_cliks.click
      expect(app.live_view_clicks_page).to have_content(endpoint, :wait => 60)

      app.link_stats_page.load(link_id: link_id)
      # hard refresh the page with timeout until get correct result:
      Timeout.timeout(30) do
        loop do
          page.evaluate_script 'window.location.reload()'
          break if app.link_stats_page.android_clicks.text.to_i == current_clicks + 1
        end
      end
      expect(app.link_stats_page.android_clicks.text.to_i).to eq(current_clicks + 1)

    end
  end
end
