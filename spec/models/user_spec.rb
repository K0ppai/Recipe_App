require 'rails_helper'

RSpec.describe User, type: :Model do
  let(:user) {User.new(name: 'Manzi')}
  before {user.save}

  it "name should be present" do 
    user.name = nil 
    expect(user).to_not be_valid
  end
end
