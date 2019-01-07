require 'rails_helper'

feature 'client' do
  let(:sigmund) { Therapist.create(name: 'Sigmund Freud', email: 'sigmund@sigmund-freud.at') }

  scenario 'entering a client identifier works either upcase or downcase' do
    client = create :client, therapist: sigmund, identifier: 'test', class_of_age: 'adult'

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
    Therapist.create(name: 'Dr. Paul Weston', email: 'paul.weston@intreatment.movie')

    client = create :client, therapist: sigmund, class_of_age: 'adult'

    visit edit_client_path(client)

    select 'Dr. Paul Weston', from: 'client_therapist_id'

    choose 'Kind / Jugendliche'

    click_button 'Weiter'

    expect(current_path).to eq new_client_survey_children_session_rating_scale_path(client)

    expect(page).to have_content 'Dr. Paul Weston'

    visit edit_client_path(client)

    choose 'Erwachsene'

    click_button 'Weiter'

    expect(current_path).to eq new_client_survey_session_rating_scale_path(client)
  end
end
