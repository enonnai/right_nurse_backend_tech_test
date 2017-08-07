head_nurse_role = Role.create!(name: 'Head Nurse')
trainee_nurse_role = Role.create!(name: 'Trainee Nurse')
ward_manager_nurse_role = Role.create!(name: 'Ward Manager Nurse')

Nurse.create!(email: 'jane1991@msn.com', first_name: 'Jane', last_name:'Adams', phone_number: '+44712167553448', verified: true, sign_in_count: 11, role: ward_manager_nurse_role)
Nurse.create!(email: 'marksmith7@gmail.com', first_name: 'Mark', last_name:'Smith', phone_number: '0303 123 7300', verified: true, sign_in_count: 1, role: head_nurse_role)
Nurse.create!(email: 'samtheman@hotmail.com', first_name: 'Sam', last_name:'Jarvis', phone_number: '+443031237334', verified: true, sign_in_count: 198, role: trainee_nurse_role)
Nurse.create!(email: 'jadefostersmith@gmail.com', first_name: 'Jade', last_name: 'foster-smith', phone_number: '+44871 222 2001', verified: true, sign_in_count: 7, role: trainee_nurse_role)
