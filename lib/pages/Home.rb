class HomePage < PageActions

  set_url "/"

  load_validation { has_side_bar_container? }

  element :side_bar_container, ".side-nav__container"

end
