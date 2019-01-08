require 'rails_helper'

feature 'manage counselors' do
  scenario 'displaying a list with all counselors' do
    create :counselor, name: 'Hansli Muster'
    create :counselor, name: 'Heiri Müller'

    visit counselors_path

    expect(page).to have_content 'Hansli Muster'
    expect(page).to have_content 'Heiri Müller'
  end

  scenario 'creating a counselor' do
    visit new_counselor_path

    fill_in 'Name', with: 'Hans Muster'
    fill_in 'E-Mail', with: 'stupidwhiteman@trump.com'

    expect { click_button 'Speichern' }.to change { Counselor.count }.by(1)
  end

  scenario 'editing a counselor' do
    counselor = create :counselor, name: 'Hansli Muster'

    visit edit_counselor_path(counselor)

    fill_in 'Name', with: 'Hans Muster'

    expect { click_button 'Speichern' }.to change { counselor.reload.name }.from('Hansli Muster').to('Hans Muster')
  end

  scenario 'deleting a counselor' do
    counselor = create :counselor, name: 'Hansli Muster'

    visit edit_counselor_path(counselor)

    expect { click_link 'Beratungspersonlöschen' }.to change { Counselor.count }.by(-1)
  end
end
