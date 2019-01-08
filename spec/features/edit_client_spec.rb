require 'rails_helper'

feature 'client' do
  let(:sigmund) { Counselor.create(name: 'Sigmund Freud', email: 'sigmund@sigmund-freud.at') }

  scenario 'entering a client identifier works either upcase or downcase' do
    client = create :client, counselor: sigmund, identifier: 'test'

    visit new_client_path

    fill_in 'Bitte geben Sie Ihre Klienten-Nummer an.', with: 'test'

    click_button 'Weiter'

    expect(current_path).to eq new_client_survey_session_rating_scale_path(client)

    visit new_client_path

    fill_in 'Bitte geben Sie Ihre Klienten-Nummer an.', with: 'TEST'

    click_button 'Weiter'

    expect(current_path).to eq new_client_survey_session_rating_scale_path(client)
  end

  scenario 'a client changes his preferences' do
    Counselor.create(name: 'Dr. Paul Weston', email: 'paul.weston@intreatment.movie')

    client = create :client, counselor: sigmund

    visit edit_client_path(client)

    select 'Dr. Paul Weston', from: 'client_counselor_id'

    click_button 'Weiter'

    expect(page).to have_content 'Dr. Paul Weston'

    expect(current_path).to eq new_client_survey_session_rating_scale_path(client)
  end
end
