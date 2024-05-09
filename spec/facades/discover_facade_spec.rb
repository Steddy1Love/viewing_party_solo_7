require "rails_helper"

RSpec.describe DiscoverFacade do
  before :each do
    @facade = DiscoverFacade.new
  end

  it "exists" do
    expect(@facade).to be_a(DiscoverFacade)
  end
end