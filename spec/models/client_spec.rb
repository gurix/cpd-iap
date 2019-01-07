require 'rails_helper'

describe Client do
  it { is_expected.to validate_uniqueness_of(:identifier) }
  it { is_expected.to validate_presence_of(:identifier) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:class_of_age) }
  it { is_expected.to validate_uniqueness_of(:token) }
  it { is_expected.to validate_presence_of(:token_generated_at) }
  it { is_expected.to have_many(:sessions).with_dependent(:destroy).as_inverse_of(:client) }
  it { is_expected.to belong_to(:therapist).as_inverse_of(:clients) }

  it 'downcases the identifier automatically' do
    subject.identifier = 'this should be in DOWNCASE'
    subject.valid?
    expect(subject.identifier).to eq 'this should be in downcase'
  end

  it 'generates a view token automatically' do
    session = create :client, therapist: create(:therapist)
    expect(session.token).not_to be_empty
    expect(session.token_generated_at).to be < Time.now
  end

  it 'returns the session type depnding on the class of age' do
    subject.class_of_age = 'adult'
    expect(subject.session_type_by_age).to eq Survey::SessionRatingScale

    subject.class_of_age = 'child'
    expect(subject.session_type_by_age).to eq Survey::ChildrenSessionRatingScale
  end
end
