require 'rails_helper'

RSpec.describe Tournament, :type => :model do
  before { @tournament = FactoryGirl.build(:tournament) }

  subject { @tournament }

  it_behaves_like "model: main attributes",
                  [{name: :name,           type: :string,  presence: true, maximum: 255},
                   {name: :api_league_id,  type: :integer, presence: true, uniq: true},
                   {name: :description,    type: :string},
                   {name: :tournament_url, type: :string},
                   {name: :grabbable,      type: :boolean},
                   {name: :matches,        type: :object}] do
    let(:record) { @tournament }

    describe "after save" do
      before {@tournament.save}
      its(:grabbable) { should be_falsey }
    end

  end

end
