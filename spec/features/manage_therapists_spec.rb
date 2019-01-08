require 'rails_helper'

feature 'manage therapists' do
  scenario 'displaying a list with all therapists' do
    create :therapist, name: 'Hansli Muster'
    create :therapist, name: 'Heiri Müller'

    visit therapists_path

    expect(page).to have_content 'Hansli Muster'
    expect(page).to have_content 'Heiri Müller'
  end

  scenario 'creating a therapist' do
    visit new_therapist_path

    fill_in 'Name', with: 'Hans Muster'
    fill_in 'E-Mail', with: 'stupidwhiteman@trump.com'

    expect { click_button 'Speichern' }.to change { Therapist.count }.by(1)
  end

  scenario 'editing a therapist' do
    therapist = create :therapist, name: 'Hansli Muster'

    visit edit_therapist_path(therapist)

    fill_in 'Name', with: 'Hans Muster'

    expect { click_button 'Speichern' }.to change { therapist.reload.name }.from('Hansli Muster').to('Hans Muster')
  end

  scenario 'deleting a therapist' do
    therapist = create :therapist, name: 'Hansli Muster'

    visit edit_therapist_path(therapist)

    expect { click_link 'Beratungspersonlöschen' }.to change { Therapist.count }.by(-1)
  end
end
