# frozen_string_literal: true

module RequestHelper
  def login_user
    @current_user = FactoryBot.create(:user, user_name: 'test')
    allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return @current_user
  end
end
