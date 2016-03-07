Line of Credit Test
====================

## Summary
This project is used as a test for simulating lines of credit over a period of 30 days with the user able to create credit lines with interest rates and limits and make withdrawals and payments on those lines of credit

## Running the Project

To run the project execute the following commands in the terminal:

```
git clone git@github.com:jacksonbrodeur/CreditLinesTest.git
cd line_of_credit
bundle install
rake db:migrate
bin/rails s
```
Then navigate to http://localhost:3000 in your web browser (or whatever port is specified by the terminal)

## How to Use the Application
For the purpose of this test the date of transactions is entered by the user but in a real-world environment would be based on the system time. Therefore the entered date is constrained to be after the last transaction that was made on this line of credit and to be no more than 30 days after the first transaction. The first transaction made on a line of credit is of course not constrained.
