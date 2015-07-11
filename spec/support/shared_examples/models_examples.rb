shared_examples_for "model: main attributes" do |attributes|

  attributes.each do |attribute|
    it {should respond_to(attribute[:name])}

    if attribute[:presence]
      describe "when #{attribute[:name]} is not present" do
        before { record.send("#{attribute[:name]}=", nil) }
        it { should_not be_valid }
      end
    end

    if attribute[:allow_blank]
      describe "when #{attribute[:name]} is blank" do
        before { record.send("#{attribute[:name]}=", "") }
        it { should be_valid }
      end
    end

    if attribute[:maximum]
      describe "when #{attribute[:name]} is to long" do
        before { record.send("#{attribute[:name]}=", "*" * (attribute[:maximum] + 1)) }
        it { should_not be_valid }
      end
    end

    if attribute[:uniq]
      describe "when #{attribute[:name]} is uniq" do
        before do
          record_dup = record.clone
          record_dup.save
        end
        it { should_not be_valid }
      end
    end


    it_behaves_like("model: predefined enum content", attribute[:name], attribute[:enums]) if attribute[:type] == :enum &&
        attribute[:enums]

  end

  describe "when valid" do
    it { should be_valid }
  end

end