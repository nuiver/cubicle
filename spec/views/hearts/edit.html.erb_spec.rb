require 'rails_helper'

RSpec.describe "hearts/edit", type: :view do
  before(:each) do
    @heart = assign(:heart, Heart.create!())
  end

  it "renders the edit heart form" do
    render

    assert_select "form[action=?][method=?]", heart_path(@heart), "post" do
    end
  end
end
