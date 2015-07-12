require 'rails_helper'

RSpec.describe Match, :type => :model do
  before { @match = FactoryGirl.build(:match) }

  subject { @match }

  it_behaves_like "model: main attributes",
                  [{name: :tournament,     type: :object,  presence: true},
                   {name: :api_match_id,   type: :integer, presence: true, uniq: true},
                   {name: :league_tier,    type: :integer, presence: true},
                   {name: :spectators,     type: :integer, presence: true},
                   {name: :online,         type: :boolean}] do
    let(:record) { @match }

    describe "after save" do
      before {@match.save}
      its(:online) { should be_falsey }
    end

  end
end

