class LiveViewClicksPage < PageActions

  set_url '/liveview/clicks'

  elements :live_view_tab, ".smart-table tr", minimun: 1
  element :load_new_cliks, ".fa-refresh"

end
