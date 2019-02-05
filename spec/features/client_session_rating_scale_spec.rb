require 'rails_helper'

def range_select(name, value)
  selector = %(input[type=range][name=\\"#{name}\\"])
  script = %-$("#{selector}").val(#{value}).trigger('click')-
  page.execute_script(script)
end

feature 'session rating scale input', js: true do
  scenario 'a new client fills a survey' do
    Counselor.create(name: 'Sigmund Freud', email: 'sigmund@sigmund-freud.at')
    Counselor.create(name: 'Dr. Paul Weston', email: 'paul.weston@intreatment.movie')

    visit new_client_path

    fill_in 'Bitte geben Sie Ihre Klienten-Nummer an.', with: 'test'

    click_button 'Weiter'

    expect(page).to_not have_content 'Bitte geben Sie Ihre Klienten-Nummer an'

    expect(page).to have_content 'Bitte geben Sie Ihren Namen und Vornamen an'
    expect(page).to_not have_content 'muss ausgefüllt werden'

    click_button 'Weiter'

    expect(page).to have_content 'muss ausgefüllt werden'

    fill_in 'Bitte geben Sie Ihren Namen und Vornamen an', with: 'Hanf Ueli'
    select 'Dr. Paul Weston', from: 'client_counselor_id'

    expect { click_button 'Weiter' }.to change { Client.count }.by(1)

    expect(current_path).to eq new_client_survey_session_rating_scale_path(Client.last)

    range_select('relationship', 10)
    range_select('goals_and_topics', 20)

    click_button 'Abschliessen'
    expect(page).to have_content 'muss ausgefüllt werden'

    range_select('approach_or_method', 30)
    range_select('overall', 40)

    expect { click_button 'Abschliessen' }.to change { ActionMailer::Base.deliveries.count }.by(1)

    session = Survey::Session.desc(:created_at).last

    expect(session.relationship).to eq 10
    expect(session.goals_and_topics).to eq 20
    expect(session.approach_or_method).to eq 30
    expect(session.overall).to eq 40

    expect(ActionMailer::Base.deliveries.last.body).to have_content new_client_survey_session_rating_scale_counselor_rating_url(session.client, session)

    expect(session.counselor).to eq Client.last.counselor

    expect(page).to have_content 'Vielen Dank. Ihre Bewertung wurde erfolreich gespeichert.'
  end
end
