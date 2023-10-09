require 'rails_helper'

RSpec.describe User, type: :Model do
  let(:user) {User.new(name: 'Manzi')}
  before {user.save}

  it "name should be present" do 
    user.name = nil 
    expect(user).to_not be_valid
  end
  it "it has many recipes" do 
    relationship = described_class.reflect_on_association(:recipes)
      expect(relationship.macro).to eq :has_many 
  end
  it "it has many inventories" do 
    relationship = described_class.reflect_on_association(:inventories)
      expect(relationship.macro).to eq :has_many 
  end
end
