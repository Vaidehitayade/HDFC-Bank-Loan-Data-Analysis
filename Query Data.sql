use [Bank Loan DB];
select * from [Bank Loan Data];

--1. Total Loan Applications

select count (id) as Total_Loan_Applications from [Bank Loan Data];

-- month to date
select count (id) as MTD_Total_Loan_Applications from [Bank Loan Data]
where month(issue_date)=12 and year(issue_date)=2021

--Previous month to month
select count (id) as PMTD_Total_Loan_Applications from [Bank Loan Data]
where month(issue_date)=11 and year(issue_date)=2021

--MOM APPLICATION = (MTD-PMTD)/PMTD


--2. Total Funded Amount

select sum(loan_amount) as Total_Funded_Amount from [Bank Loan Data]

--Month to date
select sum(loan_amount) as Total_Funded_Amount from [Bank Loan Data]
where month(issue_date)=12 and year(issue_date)=2021

--PMTD
select sum(loan_amount) as Total_Funded_Amount from [Bank Loan Data]
where month(issue_date)=11 and year(issue_date)=2021

--3. Total Amount Received

select sum(total_payment)  as Total_Amount_Received from [Bank Loan Data]

--MTD
select sum(total_payment)  as MTD_Total_Amount_Received from [Bank Loan Data]
where month(issue_date)=12 and year(issue_date)=2021

--PMTD
select sum(total_payment)  as PMTD_Total_Amount_Received from [Bank Loan Data]
where month(issue_date)=11 and year(issue_date)=2021

--4. Average Interest rate

select * from [Bank Loan Data];

select round(AVG(int_rate), 4)*100 as Average_interest_Rate from [Bank Loan Data]

--MTD
select round(AVG(int_rate), 4)*100 as MTD_Average_interest_Rate from [Bank Loan Data]
where month(issue_date)=12 and year(issue_date)=2021
--PMTD
select round(AVG(int_rate), 4)*100 as Average_interest_Rate from [Bank Loan Data]
where month(issue_date)=11 and year(issue_date)=2021

--5. Average Debt to Income Ratio

select round(avg(dti),4)*100 as Average_DTI from [Bank Loan Data]

--Current MTD
select round(avg(dti),4)*100 as MTD_Average_DTI from [Bank Loan Data]
where month(issue_date)=12 and year(issue_date)=2021

--Previous MTD
select round(avg(dti),4)*100 as PMTD_Average_DTI from [Bank Loan Data]
where month(issue_date)=11 and year(issue_date)=2021

--DashBoard 2
--GOOD Loan
select loan_status from [Bank Loan Data]

--1. Good Loan Application Percentage

select 
	(COUNT(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
	/
	count (id) as Good_Loan_Percentage
from [Bank Loan Data]

--2. Good Loan Applications
select count(id) as Good_Loan_Applications from [Bank Loan Data]
where loan_status='Fully Paid' or loan_status='Current'

--3. Good Loan Funded Amount
select sum(loan_amount) as Good_Loan_Funded_Amount from [Bank Loan Data]
where loan_status='Fully Paid' or loan_status='Current'

--4. Good Loan 
select sum(Total_Payment) as Good_Loan_Total_Received_Amount from [Bank Loan Data]
where loan_status='Fully Paid' or loan_status='Current'

--Bad Loan

--1.Bad Loan Application Percentage
select
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) /
	COUNT(id) AS Bad_Loan_Percentage
	FROM [Bank Loan Data]



--2. Bad Loan Applications
SELECT COUNT(id) as Bad_Loan_Application FROM [Bank Loan Data]
where loan_status='Charged Off'


--3. Bad Loan Funded Amouunt
select sum(loan_amount) as Bad_Loan_Funded_Amount from [Bank Loan Data]
where loan_status = 'Charged Off'

--4.Bad Loan Total Received Amount
select sum(total_payment) as Bad_Loan_Total_Received_Amount from [Bank Loan Data]
where loan_status = 'Charged Off'

-- LOAN STATUS GRIDVIEW (all the details grouped by loan status)

select * from [Bank Loan Data];
select
	loan_status,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Amount_Received,
	round(Avg(int_rate),4)*100 as Average_Interest_Rate,
	round(Avg(dti),4)*100 as Average_Debt_to_Income_Ratio
	from [Bank Loan Data]
	group by loan_status;

-- MTD Details
select
	loan_status,
	sum(total_payment) as MTD_Total_Amount_Received,
	sum(loan_amount) as MTD_Total_Funded_Amount
	from [Bank Loan Data]
	where month(issue_date)=12
	group by loan_status

--PMTD Details 
select
	loan_status,
	sum(total_payment) as MTD_Total_Amount_Received,
	sum(loan_amount) as MTD_Total_Funded_Amount
	from [Bank Loan Data]
	where month(issue_date)=11
	group by loan_status

--Dashboard 2 
--1. Monthly Trends by Issue Date 

select 
	month (issue_date) as Month_Number,
	datename(Month,issue_date) as Month_Name,
	count(id) as Total_Loan_Applications,
	Sum(loan_amount) as Total_Loan_Applications,
	sum(total_payment) as Total_Received_Amount
	from [Bank Loan Data]
	group by Month(issue_date), datename(month,issue_date)
	order by month(issue_date)

--2. Regional Analysis by State 
--a) maximum amount on top
select 
	address_state,
	count(id) as Total_Loan_Applications,
	Sum(loan_amount) as Total_Loan_Applications,
	sum(total_payment) as Total_Received_Amount
	from [Bank Loan Data]
	group by address_state
	order by Sum(loan_amount) desc

--b) maximum loan applications
select 
	address_state,
	count(id) as Total_Loan_Applications,
	Sum(loan_amount) as Total_Loan_Applications,
	sum(total_payment) as Total_Received_Amount
	from [Bank Loan Data]
	group by address_state
	order by count(id) desc

--3. Loan Term Analysis 

select 
	term,
	count(id) as Total_Loan_Applications,
	Sum(loan_amount) as Total_Loan_Applications,
	sum(total_payment) as Total_Received_Amount
	from [Bank Loan Data]
	group by term
	order by term

--4.Employee Length Analysis 
select 
	emp_length,
	count(id) as Total_Loan_Applications,
	Sum(loan_amount) as Total_Loan_Applications,
	sum(total_payment) as Total_Received_Amount
	from [Bank Loan Data]
	group by emp_length
	order by count(id) desc

--5. Loan Purpose Breakdown 
select 
	purpose,
	count(id) as Total_Loan_Applications,
	Sum(loan_amount) as Total_Loan_Applications,
	sum(total_payment) as Total_Received_Amount
	from [Bank Loan Data]
	group by purpose
	order by count(id) desc

--6. Home Ownership Analysis 
select 
	home_ownership,
	count(id) as Total_Loan_Applications,
	Sum(loan_amount) as Total_Loan_Applications,
	sum(total_payment) as Total_Received_Amount
	from [Bank Loan Data]
	where grade='A' and address_state='CA'
	group by home_ownership
	order by count(id) desc

select * from [Bank Loan Data]

