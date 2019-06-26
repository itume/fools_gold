RSpec.describe FoolsGold do
  it "has a version number" do
    expect(FoolsGold::VERSION).not_to be nil
  end

  describe "normal tax" do
    describe "with_tax?" do
      let(:yen) {Yen.new(100)}
      it "初期状態なら税抜きであること" do
        expect(yen.with_tax?).to eq(false)
      end

      it "税込みに変更すると税込みになること" do
        yen.with_tax!
        expect(yen.with_tax?).to eq(true)
      end
    end
  end
end
