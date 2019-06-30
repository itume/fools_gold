RSpec.describe FoolsGold do
  it "has a version number" do
    expect(FoolsGold::VERSION).not_to be nil
  end

  describe "tax_rate" do
    let(:yen) {Yen.new(100)}
    subject{yen.tax_rate}
    context "2019年10月1日以前" do
      it "8%であること" do
        allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
        is_expected.to eq 0.08
      end
    end

    context "2019年10月１日以降" do
      it "10%であること" do
        allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
        is_expected.to eq 0.1
      end
    end
  end

  describe "reduced_tax_rate" do
    let(:yen) {Yen.new(100)}
    context "2019年10月1日以前" do
      it "軽減税率が未施行であること" do
        allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
        expect{yen.reduced_tax_rate}.to raise_error(UninforcedLawError)
      end
    end

    context "2019年10月１日以降" do
      it "8%であること" do
        allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
        expect(yen.reduced_tax_rate).to eq 0.08
      end
    end
  end
end
