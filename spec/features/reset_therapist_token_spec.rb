require 'rails_helper'

feature 'reset therapist token' do
  scenario 'a therapist enters an incorrect email address' do
    visit new_reset_therapist_token_path

    fill_in 'reset_therapist_token_email', with: 'hans@muster.de'

    click_button 'Zugriffsinformationen zusenden'

    expect(page).to have_content 'Die E-Mail-Adresse hans@muster.de ist keiner Beratungsperson zugeordnet.'
  end

  scenario 'a therapist enters the correct email address' do
    Therapist.create(name: 'Sigmund Freud', email: 'sigmund@sigmund-freud.at')

    visit new_reset_therapist_token_path

    fill_in 'reset_therapist_token_email', with: 'sigmund@sigmund-freud.at'

    expect { click_button 'Zugriffsinformationen zusenden' }.to change { ActionMailer::Base.deliveries.count }.by(1)

    expect(page).to have_content 'Ihre Zugriffsinformationen werden Ihnen in Kürze per E-Mail zugestellt.'
  end

  scenario 'old tokens expires after a week' do
    expired = Therapist.create(name: 'Sigmund Freud', email: 'sigmund@sigmund-freud.at')
    expired_token = expired.token
    expired.update_attribute(:token_generated_at, 2.weeks.ago)

    not_expired = Therapist.create(name: 'Saul Goodman', email: 'me@bettercallsaul.goodman')
    not_expired_token = not_expired.token
    not_expired.update_attribute(:token_generated_at, 3.days.ago)

    visit root_path

    expect(expired.reload.token).not_to eq expired_token
    expect(not_expired.reload.token).to eq not_expired_token
  end
end
