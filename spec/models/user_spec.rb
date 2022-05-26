# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      full_name: 'test user',
      user_name: 'test',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  context 'create a user' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid with empty username' do
      subject.user_name = ''
      expect(subject).to_not be_valid
    end

    it 'is not valid without full name' do
      subject.full_name = nil
      expect(subject).to_not be_valid
    end
  end

  context 'create a user with attributes are not unique' do
    before do
      create(:user, user_name: 'test')
    end

    it 'is not valid with username is already exist' do
      expect(subject).to_not be_valid
    end
  end
end
