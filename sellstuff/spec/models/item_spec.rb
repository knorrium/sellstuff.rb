require 'spec_helper'

describe "Item Model" do
  let(:item) { Item.new }
  it 'can be created' do
    item.should_not be_nil
  end
end
