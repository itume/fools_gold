RSpec.describe FoolsGold do
  describe "Yen" do
    describe "normal tax" do
      let(:yen) {Yen.new(100)}
      describe "with_tax?" do
        subject {yen.with_tax?}
        it "初期状態なら税抜きであること" do
          is_expected.to be false
        end

        it "税込みに変更すると税込みになること" do
          yen.with_tax!
          is_expected.to be true
        end
      end

      describe "without_tax?" do
        subject {yen.without_tax?}
        it "初期状態なら税抜きであること" do
          is_expected.to be true
        end

        it "税込みに変更すると税込みになること" do
          yen.with_tax!
          is_expected.to be false
        end
      end

      describe "with_tax!" do
        it "初期状態なら課税できること" do
          yen.with_tax!
          expect(yen.with_tax?).to be true
        end

        it "課税状態に課税すると二重課税になること" do
          yen.with_tax!
          expect{yen.with_tax!}.to raise_error(DoubleTaxaionError)
        end
      end

      describe "without_tax!" do
        it "非課税の状態で税抜きにすると脱税になること" do
          expect{yen.without_tax!}.to raise_error(TaxEvationError)
        end

        it "課税状態なら税抜きにできること" do
          yen.with_tax!
          yen.without_tax!
          expect(yen.without_tax?).to be true
        end
      end

      describe "with_tax" do
        it "課税状態でなければ課税した金額が返ること" do
          expect(yen.with_tax).to eq(108)
        end

        it "課税状態であればそのままの金額が返ること" do
          yen.with_tax!
          expect(yen.with_tax).to eq(100)
        end
      end
    end
  end
end
