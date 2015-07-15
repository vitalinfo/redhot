require 'rails_helper'

RSpec.describe Tournament, :type => :model do
  before { @tournament = FactoryGirl.build(:tournament) }

  subject { @tournament }

  it_behaves_like "model: main attributes",
                  [{name: :name,               type: :string,  presence: true, maximum: 255},
                   {name: :api_league_id,      type: :integer, presence: true, uniq: true},
                   {name: :description,        type: :string},
                   {name: :tournament_url,     type: :string},
                   {name: :grabbable,          type: :boolean},
                   {name: :finished,           type: :boolean},
                   {name: :final_api_match_id, type: :boolean},
                   {name: :matches,            type: :object}] do
    let(:record) { @tournament }

    describe "after save" do
      before {@tournament.save}
      its(:grabbable) { should be_falsey }
      its(:finished) { should be_falsey }

      describe "when max_match_id" do
        it{expect(@tournament.max_match_id).to be_zero}

        describe "with match" do
          before { FactoryGirl.create(:match, tournament: @tournament) }
          it{expect(@tournament.max_match_id).not_to be_zero}
        end

      end
    end

  end

end
