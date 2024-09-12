Step for Viz2

• Create database in SQL with necessary tables.
• Tables:
	Calendar: (idx,ddate,years,months,month_name,day_num,day_name,y_week,y_quaters)
	Languages: (idx, languages)
	Categories: (idx,categories)
	Production: (idx,produc,mode)
	Subscription: (idx,subs,price)
	States: (idx,state_code,states,regions)
	Device: (idx,device)
	Payment: (idx, paytype)
	Rates: (idx, rates)
	Programs: (idx, uploaded_on,lang_id,catg_id,prod_id)
	Users: (idx,state_id,created_on,sub_id,dev_id,pay_id)
	Viewx: (idx,user_id,view_on,prgm_id,rate_id,dev_id)

• Create fake table to help insert data on Programs, Users, Viewx.
• Find the US states on the web (exclude Alaska and Hawaii).
• Search the population of the US and make an imaginary approximate of people who could potentially use Netflix.
• Create table info in Excel and convert them to CSV (except Programs, Users, Viewx; these need to be done in python).
• Use BULK INSERT to insert the CSV files to the fake tables.
• Create stored procedure if necessary to copy the info from the fake table to the real ones.
• Drop the fake tables when ended.
