RSpec.describe FoolsGold do
  it "has a version number" do
    expect(FoolsGold::VERSION).not_to be nil
  end

  describe "normal tax" do
    describe "with_tax?" do
      let(:yen) {Yen.new(100)}
      subject {yen.with_tax?}
      it "初期状態なら税抜きであること" do
        is_expected.to be false
      end

      it "税込みに変更すると税込みになること" do
        yen.with_tax!
        is_expected.to be true
      end
    end
  end
end
