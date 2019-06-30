RSpec.describe FoolsGold do
  it "has a version number" do
    expect(FoolsGold::VERSION).not_to be nil
  end

  describe "tax_rate" do
    let(:yen) {Yen.new(100)}
    subject{yen.tax_rate}
    context "2019年10月1日以前" do
      it "8%であること" do
        is_expected.to eq 8
      end
    end

    context "2019年10月１日以降" do
      it "10%であること" do
        allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
        is_expected.to eq 10
      end
    end
  end
end
