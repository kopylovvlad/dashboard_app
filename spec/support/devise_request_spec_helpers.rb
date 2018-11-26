module DeviseRequestSpecHelpers
  include Warden::Test::Helpers

  def sign_in(resource_or_scope, resource = nil)
    resource ||= resource_or_scope
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    login_as(resource, scope: scope)
  end

  def sign_out(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    logout(scope)
  end

  def redirect_to_sign_in
    expect(response).to have_http_status(302)
    expect(response).to redirect_to(new_user_session_path)
  end
end