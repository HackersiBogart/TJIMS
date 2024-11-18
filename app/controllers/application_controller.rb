class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    # Customize the redirect path after sign in
    admin_path
  end

  include Pagy::Backend

  def test
    render plain: "Public Access Test Page"
  end
end
