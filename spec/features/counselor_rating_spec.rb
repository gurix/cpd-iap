require 'rails_helper'

feature 'counselor rating input' do
  scenario 'a counselor is asked to rate a given session' do
    counselor = create(:counselor)
    client = create :client, counselor: counselor
    session = create :session_rating_scale, client: client, counselor: counselor, consultation_date: Time.zone.now

    visit new_client_survey_session_rating_scale_counselor_rating_url(session.client, session)

    fill_in 'Wievielter Termin?', with: 3
    fill_in 'Dauer der Sitzung in Minuten', with: 60

    choose 'survey_counselor_rating_crq_knowledge_and_skills_0'
    choose 'survey_counselor_rating_crq_motivation_1'
    choose 'survey_counselor_rating_crq_environment_2'
    choose 'survey_counselor_rating_crq_activity_4'

    check 'Ressourcenbilder'
    check 'KV-IT'
    check 'emotionale Unterstützung geboten'

    fill_in 'Andere Interventionen/Aktivitäten', with: 'Ein Bier zusammen getrunken.'

    fill_in 'Zeitpunkt an dem die Sitzung stattgefunden hat', with: '24.08.2021'

    find("input[id$='survey_counselor_rating_counselor_relationship']").set 10
    find("input[id$='survey_counselor_rating_counselor_goals_and_topics']").set 20
    find("input[id$='survey_counselor_rating_counselor_approach_or_method']").set 30
    find("input[id$='survey_counselor_rating_counselor_overall']").set 40

    check 'Beratung fand online statt'

    click_button 'Speichern'

    expect(page).to have_content 'Ihre Eingabe wurde gespeichert.'

    counselor_rating = session.reload.counselor_rating

    expect(counselor_rating.session_number).to eq 3
    expect(counselor_rating.session_duration).to eq 60
    expect(counselor_rating.session_date).to eq 'Tue, 24 Aug 2021 00:00:00 UTC +00:00'
    expect(counselor_rating.online_session).to eq true

    expect(counselor_rating.crq_knowledge_and_skills).to eq 0
    expect(counselor_rating.crq_motivation).to eq 1
    expect(counselor_rating.crq_environment).to eq 2
    expect(counselor_rating.crq_activity).to eq 4

    expect(counselor_rating.counselor_relationship).to eq 10
    expect(counselor_rating.counselor_goals_and_topics).to eq 20
    expect(counselor_rating.counselor_approach_or_method).to eq 30
    expect(counselor_rating.counselor_overall).to eq 40

    expect(counselor_rating.intervention_contents).to eq %w[qual7 quant5 coach7]
  end
end
