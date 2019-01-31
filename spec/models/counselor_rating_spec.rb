require 'rails_helper'

describe Survey::CounselorRating do
  it { is_expected.to belong_to(:session).as_inverse_of(:counselor_rating) }
end
