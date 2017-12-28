class LoginPage < PageActions

  set_url "/login"

  element :login_container, ".login-container"
  element :email,           "[name='email']"
  element :password,        "[name='password']"
  element :sing_in_button,  "[data-testid='btn-sign-in']"

  def login(user)
    within login_container do
      email.set(user[:email])
      password.set(user[:password])
      sing_in_button.click
    end
  end

end
