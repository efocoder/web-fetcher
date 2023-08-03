require 'spec_helper'

describe "fetch.rb" do
  let(:fetch) {Fetch}
  let(:argv) {[]}

  context 'no url supplied' do
    it 'should fails when no url supplied' do
      expect do
        fetch.make_fetch(argv)
      end.to output("No url supplied, please provide a url to continue\n").to_stdout
    end
  end

  context 'only url supplied' do
    it 'should have url  as arry []' do
      argv << 'https://autify.com'
      expect(argv).to be_a(Array)
      expect(argv.size).to eq(1)
      expect(argv).not_to be_empty
      expect(argv).to include('https://autify.com')
    end
  end

end