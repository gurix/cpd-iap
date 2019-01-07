require 'rails_helper'

feature 'children session rating scale input' do
  scenario 'a new client fills a survey' do
    Therapist.create(name: 'Sigmund Freud', email: 'sigmund@sigmund-freud.at')
    Therapist.create(name: 'Dr. Paul Weston', email: 'paul.weston@intreatment.movie')

    visit new_client_path

    fill_in 'Bitte geben Sie Ihre Klienten-Nummer an.', with: 'test'

    click_button 'Weiter'

    expect(page).to_not have_content 'Bitte geben Sie Ihre Klienten-Nummer an'

    expect(page).to have_content 'Bitte geben Sie Ihren Namen und Vornamen an'
    expect(page).to_not have_content 'muss ausgefüllt werden'

    click_button 'Weiter'

    expect(page).to have_content 'muss ausgefüllt werden'

    fill_in 'Bitte geben Sie Ihren Namen und Vornamen an.', with: 'Hanf Ueli'
    select 'Dr. Paul Weston', from: 'client_therapist_id'

    choose 'Kind / Jugendliche'

    expect { click_button 'Weiter' }.to change { Client.count }.by(1)

    expect(current_path).to eq new_client_survey_children_session_rating_scale_path(Client.last)

    find("input[id$='survey_children_session_rating_scale_relationship']").set 10
    find("input[id$='survey_children_session_rating_scale_goals_and_topics']").set 20
    find("input[id$='survey_children_session_rating_scale_approach_or_method']").set 10
    find("input[id$='survey_children_session_rating_scale_overall']").set 20
    find("input[id$='survey_children_session_rating_scale_coping']").set 10

    find("textarea[id$='survey_children_session_rating_scale_comment']").set 'Teste den Test'

    expect { click_button 'Ich bin fertig!' }.to change { ActionMailer::Base.deliveries.count }.by(1)

    expect(Survey::Session.last.therapist).to eq Client.last.therapist

    expect(page).to have_content 'Vielen Dank. Ihre Bewertung wurde erfolreich gespeichert.'
  end
end
