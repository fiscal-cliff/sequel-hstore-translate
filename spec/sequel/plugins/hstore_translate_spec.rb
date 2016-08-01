require 'spec_helper'

describe Sequel::Plugins::HstoreTranslate do

  it 'has a version number' do
    expect(Sequel::Plugins::HstoreTranslate::VERSION).not_to be nil
  end

  context 'when translations setup propperly' do
    let(:model) {}
    before do
      binding.pry
    end
    it 'does something useful' do

      expect(false).to eq(true)
    end
  end
end
