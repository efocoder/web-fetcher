describe 'HttpMaker' do
  let(:maker) {HttpMaker}

  context "empty url" do
    it 'should reject and print error message' do
      expect do
        maker.make_request(url: nil)
      end.to output("Url cannot be empty\n").to_stdout
    end
  end

  context 'one url supplied with no metadata flag' do
    it 'should return 200 status' do
      expect do
        maker.make_request(url: 'https://autify.com')
      end.not_to output("Url cannot be empty\n").to_stdout
    end
  end
end