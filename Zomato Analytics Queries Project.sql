CREATE DATABASE zomato_db;
SELECT * FROM zomato;
#Q1.Build a country Map Table
CREATE TABLE country_map as
select distinct CountryCode, Country from zomato;
select * from country_map;

#Q2. Build a Calendar Table using the Column Datekey
  /*Add all the below Columns in the Calendar Table using the Formulas.
   A.Year
   B.Monthno
   C.Monthfullname
   D.Quarter(Q1,Q2,Q3,Q4)
   E. YearMonth ( YYYY-MMM)
   F. Weekdayno
   G.Weekdayname
   H.FinancialMOnth ( April = FM1, May= FM2  …. March = FM12)
   I. Financial Quarter ( Quarters based on Financial Month) */
   
   UPDATE zomato 
   SET Opening_date = STR_TO_DATE(Opening_date, '%d-%b-%y');
   
   ALTER TABLE zomato 
   MODIFY Opening_date DATE;
   
   CREATE TABLE calendar as
   select Opening_date,year(Opening_date)orderyear,month(Opening_date)monthno,monthname(Opening_date)monthfullname,
   concat("Q",quarter(Opening_date))quartername,DATE_FORMAT(Opening_date,'%Y-%b')yearmonth,dayofweek(Opening_date)weekdayno,
   dayname(Opening_date)weekdayname,IF(MONTH(Opening_date)>=4,MONTH(Opening_date)-3,MONTH(Opening_date)+9)financialmonth,
   concat("FQ",ceil(IF(MONTH(Opening_date)>=4,MONTH(Opening_date)-3,MONTH(Opening_date)+9)/3))financialmonthname from zomato;
   select * from calendar;
   
   #Q3.Find the Numbers of Resturants based on City and Country.
   select country,city,count(RestaurantID)total_restaurants from zomato group by country,city order by total_restaurants desc;
   
   #Q4.Numbers of Resturants opening based on Year , Quarter , Month
   select year(Opening_date)order_year,concat("Q",quarter(Opening_date))quarter_no,monthname(Opening_date)month_name,
   count(RestaurantID)total_restaurants from zomato group by order_year,quarter_no,month_name order by total_restaurants desc;
   
   #Q5.Count of Resturants based on Average Ratings
   select Rating_Bucket,count(RestaurantID)total_restaurants from zomato group by Rating_Bucket order by total_restaurants DESC;
   
   #Q6.Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
   select Price_Bucket,count(RestaurantID)total_restaurants from zomato group by Price_Bucket order by total_restaurants DESC;
   
   #Q7.Percentage of Resturants based on "Has_Table_booking"
   select Has_Table_booking,concat(round(count(RestaurantID)*100.0/(select count(RestaurantID) from zomato),2),"%")percentage_Restaurants
   from zomato group by Has_Table_booking;
   
   #Q8.Percentage of Resturants based on "Has_Online_delivery"
   select Has_Online_delivery,concat(round(count(RestaurantID)*100.0/(select count(RestaurantID) from zomato),2),"%")percentage_Restaurants
   from zomato group by Has_Online_delivery;
   
   #Q9. Find the Numbers of Resturants based on Cuisins,city and ratings
   select city,cuisines,Rating_Bucket,count(RestaurantID)total_restaurants from zomato 
   group by city,cuisines,Rating_Bucket order by total_restaurants desc;
   
   