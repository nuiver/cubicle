require 'rails_helper'

RSpec.describe "hearts/index", type: :view do
  before(:each) do
    assign(:hearts, [
      Heart.create!(),
      Heart.create!()
    ])
  end

  it "renders a list of hearts" do
    render
  end
end
