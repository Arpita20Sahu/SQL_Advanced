-- 1.	List customers who have active policies.
select c.customer_id, c.name
from customers c 
join policies p 
on c.customer_id = p.customer_id
where p.status = "Active";


-- 2.	Find the total premium paid by each customer.
select c.customer_id, c.name, sum(p.premium_amount) as total_premium
from customers c 
join policies p 
on c.customer_id = p.customer_id
group by c.customer_id, c.name;


-- 3.	Find customers whose policies expired before 2023.
select c.customer_id, c.name, c.join_date
from customers c 
join policies p 
on c.customer_id = p.customer_id
where p.end_date < "2023-01-01";


-- 4.	Get customers who have never raised a claim.
select c.customer_id, c.name
from customers c 
join policies p on c.customer_id = p.customer_id
left join claims cl on p.policy_id = cl.policy_id
where cl.claim_id is null;

-- 5.	Fetch policy holders with more than one policy.
SELECT 
    c.customer_id, 
    c.name, 
    COUNT(p.policy_id) AS policy_count
FROM customers c 
JOIN policies p 
  ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(p.policy_id) > 1;

-- 6.	For each policy, show the time taken (in days) to settle claims.
SELECT 
    p.policy_id,
    c.claim_id,
    DATEDIFF(c.settlement_date, c.claim_date) AS settlement_days
FROM policies p
JOIN claims c ON p.policy_id = c.policy_id
WHERE c.claim_status = 'Approved';

-- 7.	Find the customer with the highest total claim amount.
select *
from
(
SELECT 
    c.customer_id, 
    c.name,
    sum(cl.claim_amount) as claim_amount,
    rank() over(order by sum(cl.claim_amount) desc) as claim_rank
FROM customers c 
join policies p on c.customer_id = p.customer_id
join claims cl on p.policy_id = cl.policy_id
group by c.customer_id, c.name
) A
where claim_rank = 1;

-- 8.	Monthly claim summary report (Year 2022).
select month(claim_date) as claim_month,
       sum(claim_amount) as monthly_claim
from claims
where year(claim_date) = 2022
group by claim_date
order by claim_month;

-- 9.	Get active customers who haven't submitted any claims yet.
SELECT 
    c.customer_id, 
    c.name
FROM customers c 
join policies p on c.customer_id = p.customer_id
left join claims cl on p.policy_id = cl.policy_id
where  p.status = 'Active' and cl.claim_status is null;

-- 10.	Find agents and count of customers in their city.
select a.agent_id, a.agent_name, a.city,
       count(c.customer_id) as customer_count
from agents a 
join customers c
on a.city = c.city
group by a.agent_id, a.agent_name, a.city;


-- 11.	Rank Customers Based on Total Premium Paid (Highest First)
SELECT 
    c.customer_id, 
    c.name,
    sum(p.premium_amount) as total_premium,
    rank() over(order by sum(p.premium_amount) desc) as ranked
from customers c 
join policies p 
on c.customer_id = p.customer_id
group by c.customer_id, c.name;


-- 12.	Get Previous and Next Claim Dates for Each Policy.
select policy_id,
	   claim_id,
       claim_date,
	   lag(claim_date) over(partition by policy_id order by claim_date) as previous_claim,
       lead(claim_date) over(partition by policy_id order by claim_date) as next_claim
from claims;
