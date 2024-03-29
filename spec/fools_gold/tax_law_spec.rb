RSpec.describe FoolsGold do
  describe "TaxLaw" do
    it "設定変更を行うことで強制的に新税適用できること" do
      class MyTaxLaw < TaxLaw
        inforced_201910 true
      end
      allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
      expect(Yen.new(100).with_tax).to eq(110)
      expect(Yen.new(100).with_reduced_tax).to eq(108)
      Object.send(:remove_const, :MyTaxLaw)
    end
  end
end
