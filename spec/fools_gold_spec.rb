RSpec.describe FoolsGold do
  it "has a version number" do
    expect(FoolsGold::VERSION).not_to be nil
  end

  describe "tax_rate" do
    let(:yen) {Yen.new(100)}
    subject{yen.tax_rate}
    it "初期状態では8%" do
      is_expected.to eq 8
    end
  end
end
