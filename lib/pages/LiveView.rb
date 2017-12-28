class LiveViewPage < PageActions

  set_url '/liveview/links'

  def find_link_data(uri)
    JSON.parse(all('span', :text => uri, count: 2)[0].text)
  # return result:
  #   {"~campaign"=>"QATesting",
  #    "~creation_source"=>0,
  #    "~tags"=>["Vitalii"],
  #    "~marketing"=>true,
  #    "~channel"=>"Automation",
  #    "~id"=>"474752151974072897",
  #    "$one_time_use"=>false,
  #    "+url"=>"0ywq.app.link/tptqY15weJ"}
  end

  def find_link_id(uri)
    find_link_data(uri)['~id']
  end

end