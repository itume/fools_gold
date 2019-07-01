RSpec.describe FoolsGold do
  it "has a version number" do
    expect(FoolsGold::VERSION).not_to be nil
  end

  # describe "settingslogic" do
  #   it "設定変更を行うことで強制的に新税適用できること" do
  #     class Settings < Settingslogic
  #       require "tempfile"
  #       text = <<-EOS
  #       row_inforced: true
  #       EOS
  #       tf = Tempfile.new("test.yaml")
  #       tf.print(text)
  #       tf.open
  #       source tf.path
  #     end
  #     allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
  #     expect(Yen.new(100).with_tax).to eq(110)
  #     expect(Yen.new(100).with_reduced_tax).to eq(108)
  #   end
  # end

  describe "settingslogic" do
    it "設定変更を行うことで強制的に新税適用できること" do
      class MyTaxLaw < TaxLaw
        inforced_201910 true
      end
      allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
      expect(Yen.new(100).with_tax).to eq(110)
      expect(Yen.new(100).with_reduced_tax).to eq(108)
    end
  end
end
