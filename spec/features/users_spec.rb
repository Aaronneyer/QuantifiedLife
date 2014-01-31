require 'spec_helper'

describe 'Sign up page' do
  it 'lets the user sign up' do
    sign_up_with 'test@test.com', 'correcthorsebatterystaple'

    expect(page).to have_content('test@test.com')
  end

  it 'fails with invalid stuff' do
    sign_up_with 'test fail', 'password'

    expect(page).to have_content('Sign up')
  end
end
