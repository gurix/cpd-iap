require 'rails_helper'

describe Survey::SessionRatingScale do
  it { is_expected.to have_one(:counselor_rating).as_inverse_of(:session) }

  it { is_expected.to validate_presence_of(:relationship) }
  it { is_expected.to validate_presence_of(:goals_and_topics) }
  it { is_expected.to validate_presence_of(:approach_or_method) }
  it { is_expected.to validate_presence_of(:overall) }
end
