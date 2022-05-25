module ControllerHelpers
  def sign_in_user(user = User.new(email: 'user@user.com', password: 'password'))
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  def sign_in_admin(user = User.new(email: 'user@user.com', password: 'password', role: 'admin'))
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
