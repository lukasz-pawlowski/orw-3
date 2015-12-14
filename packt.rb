require 'mechanize'

#set agent
agent = Mechanize.new

#set user agent
agent.user_agent_alias = "Windows Chrome"

#set login page
login_page = agent.get "https://www.somepage.com/"

#set login form
login_form = login_page.form_with(id: "packt-user-login-form")

email_field = login_form.field_with(id: 'email')
email_field.value = 'email@email.com'

password_field = login_form.field_with(id: "password")
password_field.value = 'VeryStrongPassword'

#submit form
submit_form = login_form.submit

#go to download page
download_page = agent.get "https://www.somepage.com/somecontent"

link = download_page.link_with(class: 'x-days-claim').href
split = link.split(/\//)

#claim
profile_page = download_page.link_with(class: 'x-days-claim').click

#download link
download_pdf = agent.get "https://www.somepage.com/ebook_download/"+split[2]+"/pdf"

#get name
filename = download_pdf.header['content-disposition'][/"(.*)"/, 1]
download_pdf.save_as  split[2] + "-" + filename

#logout
agent.get "https://www.packtpub.com/logout"
