feature 'New user sign up' do

  let(:user){build :user}

  scenario 'I can sign up as a new user' do
    expect{ sign_up(user) }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome to Chitter, #{user.username}"
  end

  scenario 'password and confirmation must match' do
    user = build(:user, password_confirmation: 'wrong')
    expect{ sign_up(user) }.not_to change(User, :count)
    expect(page).to have_content "Password and confirmation password don't match"
  end

  scenario 'can\'t register with an email that\'s already taken' do
    sign_up(user)
    user_diff = build(:user, username: 'other_name')
    expect{ sign_up(user_diff) }.not_to change(User, :count)
    expect(page).to have_content "Email already taken"
  end

  scenario 'can\'t register with a username that\'s already taken' do
    sign_up(user)
    user_diff = build(:user, email: 'other@email.co.uk')
    expect{ sign_up(user_diff) }.not_to change(User, :count)
    expect(page).to have_content "Username already taken"
  end

  scenario 'email must be provided' do
    user = build(:user, email: '')
    expect{ sign_up(user) }.not_to change(User, :count)
    expect(page).to have_content "Email address needed"
  end

  scenario 'username must be provided' do
    user = build(:user, username: '')
    expect{ sign_up(user) }.not_to change(User, :count)
    expect(page).to have_content "Username needed"
  end

  scenario 'email must be of an email format' do
    user = build(:user, email: 'badEmail')
    expect{ sign_up(user) }.not_to change(User, :count)
    expect(page).to have_content "That doesn't seem to be a valid email"
  end

  def sign_up(user)
    visit ('/')
    click_button 'Sign up'
    fill_in 'email',    with: user.email
    fill_in 'name',     with: user.name
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    fill_in 'password_confirmation', with: user.password_confirmation
    click_button 'Register'
  end

end