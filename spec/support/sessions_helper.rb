module SessionsHelper
  def log_in(user)
    post "/login", params: { email: user.email, password: "secret" }
  end
end
