require 'rails_helper'

describe Survey::Session do
  it { is_expected.to belong_to(:client).as_inverse_of(:sessions) }
  it { is_expected.to belong_to(:therapist).as_inverse_of(:sessions) }
end
