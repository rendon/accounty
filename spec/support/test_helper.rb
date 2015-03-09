module TestHelper
  def login_as(user, options = {})
    if integration_test?
      post login_path, session: { email: user.email, password: user.password }
    else
      session[:user_id] = user.id
    end
  end

  private

  def integration_test?
    defined?(post_via_redirect)
  end
end
