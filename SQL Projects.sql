-- TASK 1:
# Print out the details of the booking: the booking ID along with its start and end times.
# Rename the columns as ‘Tour Start Time’ and ‘Tour End Time’.

select BookingID, BookingTime "Tour Start Time",
       addtime(BookingTime,time_format(concat(TourDuration,':00:00'),'%H:%i:%s'))"Tour End Time"
from Booking b
join Tour t
on b.TourID = t.TourID
order by t.TourID;

-- TASK 2:
# Using a SUBQUERY, print the name and size of each reserve that has a vehicle with the letter ‘b’ appearing in the Rego Number (not case-sensitive). 
# All sizes should be displayed with ‘ hectares’ and the result should be sorted from the largest to the smallest reserve.

select ReserveName, concat(ReserveSize,' hectares') "ReserveSize"
from Reserve
where ReserveID in(select ReserveID
                   from Vehicle v
                   where VehicleRegoNum like '%b%')
 order by ReserveSize desc;
 
 -- TASK 3: 
# Write a query to print the name of staff members along with the dates of the booking, if the bookings were made in October of any year, and only if the staff members are either reserve managers or senior tour guides earning at least $70,000. 
# Order the results by Staff Name in ascending order
# Additionally, include staff members who do not have any bookings, and represent any null values as 'No Booking'.

select StaffName,
       if(BookingDate is null,"No Booking",BookingDate) "BookingDate"
from Staff s
left join Booking b
on s.StaffID = b.StaffID
where (month(b.BookingDate)='10' or b.BookingDate is null)
and (StaffPosition like 'Reserve Manager' 
     or (StaffPosition like 'Senior Tour Guide' and StaffSalary >=70000.00))
order by StaffName;

-- TASK 4: 
# Write a query to display the country of the visitor group and the name of the staff member assigned to the group for the booking, 
# where the tour duration is over two hours, the assigned staff member has two or more bookings, and their salary is less than or equal to the average staff salary.

select distinct VisGroupCountry,StaffName  
from Staff s
join Booking b
on b.StaffID = s.StaffID
join VisitorGroup v
on v.VisGroupID = b.VisGroupID
join Tour t
on b.TourID = t.TourID
where t.TourDuration > 2
and s.StaffID in(select StaffID
               from Booking b
               group by StaffID
               having count(b.BookingDate)>=2)
and s.StaffSalary <= (select avg(StaffSalary) from Staff);

-- TASK 5:
# Write a query to display the name of package tours along with their component tours. 
# Include only packages that consist of more than two component tours. 
# The column names should indicate whether each entry is a package or a component.

select p.TourName "PackageTourName",
       c.TourName "ComponentTourName"
from Tour p, TourPackage tp, Tour c
where p.TourID = tp.PackageTourID
and c.TourID = tp.ComponentTourID
and p.TourID in( select  PackageTourID
                         from TourPackage
                         group by PackageTourID
                         having count(ComponentTourID)>2);
                         
-- TASK 6:
# Write a query to display the ID, name, and cost of all package tours. 
# Include a column that shows the total cost of all the component tours within each package and another column that calculates the savings provided by the package tour. 
# All prices are prefixed with '$’

select tp.PackageTourID, p.TourName, 
       concat('$',p.TourCost) "TourCost", 				
       concat('$',cast(sum(c.TourCost) as decimal(5,2)))"TotalComponentCost",
       concat('$',sum(c.TourCost)-p.TourCost) "Savings"
from TourPackage tp
join Tour p on p.TourID = tp.PackageTourID
join Tour c on c.TourID = tp.ComponentTourID
group by tp.PackageTourID;

-- TASK 7:
# Write a query to display the name of the reserve and its partnering organization, the duration of the partnership in years, and the amount funded. 
# Include only records where the first digit in the organization contact number is '9' (excluding the area code), the amount funded exceeds the average funding across all organizations, and the reserve has no package tours booked. 
# The funded amount should be prefixed with “$”.

select r.ReserveName, o.OrganisationName, 
       datediff(p.EndDate,p.StartDate)/365 "Partnership Duration",
       concat('$', p.Amount )"Amount"
from Reserve r, Partnership p,Organisation o
where r.ReserveID = p.ReserveID
and p.OrganisationID = o.OrganisationID
and o.OrgContactNumber like '(__)9%'
and p.Amount>(select avg(Amount) from Partnership)
and r.ReserveID not  in ( select v.ReserveID from Vehicle v
						join Booking b 
                        on (b.ReserveID, b.VehicleID)=(v.ReserveID, v.VehicleID)
                        join Tour t
                        on t.TourID = b.TourID
                        left join TourPackage tp
                        on tp.PackageTourID = t.TourID
                        where PackageTourID is not null);

SELECT distinct r.ReserveName, 
       o.OrganisationName, 
       DATEDIFF(p.EndDate, p.StartDate) / 365 AS "Partnership Duration",
       CONCAT('$', p.Amount) AS "Amount"
FROM Reserve r
JOIN Partnership p ON r.ReserveID = p.ReserveID
JOIN Organisation o ON p.OrganisationID = o.OrganisationID
JOIN Vehicle v ON r.ReserveID = v.ReserveID
JOIN Booking b ON v.VehicleID = b.VehicleID AND v.ReserveID = b.ReserveID
JOIN Tour t ON b.TourID = t.TourID
LEFT JOIN TourPackage tp ON t.TourID = tp.PackageTourID
WHERE o.OrgContactNumber LIKE '(__)9%'
  AND p.Amount > (SELECT AVG(Amount) FROM Partnership)
  AND tp.PackageTourID IS NULL;
