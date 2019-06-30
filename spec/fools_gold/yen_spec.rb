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
        context "2019年10月１日以前" do
          let(:yen) {Yen.new(100)}
          it "課税状態でなければ8%課税した金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
            expect(yen.with_tax).to eq(108)
          end

          it "課税状態であればそのままの金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
            yen.with_tax!
            expect(yen.with_tax).to eq(100)
          end
        end

        context "2019年10月1日以降" do
          let(:yen) {Yen.new(100)}
          it "課税状態でなければ10%課税した金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
            expect(yen.with_tax).to eq(110)
          end

          it "課税状態であればそのままの金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
            yen.with_tax!
            expect(yen.with_tax).to eq(100)
          end
        end
      end

      describe "without_tax" do
        context "2019年10月１日以前" do
          let(:yen){Yen.new(108)}
          it "課税状態であれば8%税抜き金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
            yen.with_tax!
            expect(yen.without_tax).to eq(100)
          end

          it "課税状態でなければそのままの金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
            expect(yen.without_tax).to eq(108)
          end
        end

        context "2019年10月1日以降" do
          let(:yen){Yen.new(110)}
          it "課税状態であれば10%税抜き金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
            yen.with_tax!
            expect(yen.without_tax).to eq(100)
          end

          it "課税状態でなければそのままの金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
            expect(yen.without_tax).to eq(110)
          end
        end
      end
    end

    describe "reduced tax" do
      describe "with_reduced_tax" do
        context "2019年10月１日以前" do
          let(:yen) {Yen.new(100)}
          it "新法施行前のためエラーになること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
            expect{yen.with_reduced_tax}.to raise_error(UninforcedLawError)
          end
        end
        context "2019年10月１日以降" do
          let(:yen) {Yen.new(100)}
          it "課税状態でなければ8%の軽減税率で課税した金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
            expect(yen.with_reduced_tax).to eq(108)
          end

          it "課税状態であればそのままの金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
            yen.with_tax!
            expect(yen.with_reduced_tax).to eq(100)
          end
        end
      end

      describe "without_reduced_tax" do
        context "2019年10月１日以前" do
          let(:yen) {Yen.new(108)}
          it "新法施行前のためエラーになること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,9,30))
            yen.with_tax!
            expect{yen.without_reduced_tax}.to raise_error(UninforcedLawError)
          end
        end
        context "2019年10月１日以降" do
          let(:yen) {Yen.new(108)}
          it "課税状態であれば8%軽減税率の税抜き金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
            yen.with_tax!
            expect(yen.without_reduced_tax).to eq(100)
          end

          it "課税状態でなければそのままの金額が返ること" do
            allow(TaxDate).to receive(:today).and_return(Date.new(2019,10,1))
            expect(yen.without_reduced_tax).to eq(108)
          end
        end
      end
    end
  end
end
