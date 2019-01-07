require 'rails_helper'

describe Therapist do
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:token) }
  it { is_expected.to validate_presence_of(:token_generated_at) }
  it { is_expected.to have_many(:sessions).with_dependent(:destroy).as_inverse_of(:therapist) }
  it { is_expected.to have_many(:clients).as_inverse_of(:therapist) }

  it 'generates a view token automatically' do
    subject = create :therapist
    expect(subject.token).not_to be_empty
    expect(subject.token_generated_at).to be < Time.now
  end

  it 'validates the email address' do
    subject = build :therapist

    subject.email = 'stupidwhiteman@trump.com'
    expect(subject).to be_valid

    subject.email = 'noemailaddress'
    expect(subject).not_to be_valid
  end
end
