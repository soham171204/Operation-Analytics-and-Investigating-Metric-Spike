# project 3 Operation Analytics and Investigating Metric Spike

# Case Study 1:  Job Data Analysis


create database project_3;
show databases;
use project_3;

create table job_data (
ds date,
job_id int not null ,
actor_id int not null,
event varchar(10) not null,
language varchar(50) not null ,
time_spent int not null,
org char(2)
);

select * from job_data;

insert into job_data ( ds, job_id, actor_id ,event , language, time_spent, org )
values('2020-11-30' , 21, 1001,'skip', 'Englisg',15,'A'),
('2020-11-30' , 22, 1006,'transfer', 'Arabic',25,'B'),
('2020-11-29' , 23, 1003,'decision', 'Persian',20,'C'),
('2020-11-28' , 23, 1005,'transfer', 'Persian',22,'D'),
('2020-11-28' , 25, 1002,'decision', 'Hindi',11,'B'),
('2020-11-27' , 11, 1007,'decision', 'French',104,'D'),
('2020-11-26' , 23, 1004,'skip', 'Persian',56,'A'),
('2020-11-25' , 20, 1003,'transfer', 'Italian',45,'C');

#  case study1:
#Tasks-A  Jobs Reviewed Over Time

SELECT 
    ds AS date,
    COUNT(job_id) AS joint_jobid,
    ROUND((SUM(time_spent) / 3600), 2) AS totoal_time_sp_hr,
    ROUND((COUNT(job_id) / (SUM(time_spent) / 3600)),
            2) job_review_ph_pday
FROM
    job_data
WHERE
    ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY ds
ORDER BY ds;

# task B: Throughput Analysis
SELECT 
    ROUND(COUNT(event) / SUM(time_spent), 2) AS weekly_avg_throughput
FROM
    job_data;
SELECT 
    ds AS dates,
    ROUND(COUNT(event) / SUM(time_spent), 2) AS daily_avg_throughput
FROM
    job_data
GROUP BY ds
ORDER BY ds;

 #task C: Language Share Analysis
 
 SELECT 
    language,
    ROUND(100 * COUNT(*) / total, 2) AS percentage,
    jd.total
FROM
    job_data
        CROSS JOIN
    (SELECT 
        COUNT(*) AS total
    FROM
        job_data) AS jd
GROUP BY language , jd.total;

# task D: duplicate Rows detection
SELECT 
    actor_id, COUNT(*) AS Duplicate
FROM
    job_data
GROUP BY actor_id
HAVING COUNT(*) > 1;