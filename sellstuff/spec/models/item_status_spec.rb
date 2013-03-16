require 'spec_helper'

describe "ItemStatus Model" do
  let(:item_status) { ItemStatus.new }
  it 'can be created' do
    item_status.should_not be_nil
  end
end
