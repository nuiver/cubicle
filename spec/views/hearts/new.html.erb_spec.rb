require 'rails_helper'

RSpec.describe "hearts/new", type: :view do
  before(:each) do
    assign(:heart, Heart.new())
  end

  it "renders new heart form" do
    render

    assert_select "form[action=?][method=?]", hearts_path, "post" do
    end
  end
end
