class LinkStatsPage < PageActions

  set_url "/link-stats{/link_id}"

  element :click_flow_container, ".click-flow-container"
  element :number_of_cliks, ".click-highlight"
  element :android_stats, "#android-click-flow"
  elements :link_clicks, ".click-flow__content"

  load_validation { has_click_flow_container? }

  def android_clicks
    within android_stats do
      link_clicks(:count => 4)[1]
    end
  end

end
