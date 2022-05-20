-- Deliverable 1
-- Retirement list
SELECT e.emp_no,
    e.first_name,
	e.last_name,
	t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t 
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibilty
 
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
	rt.emp_no,
    rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

-- number of employees by their most recent job title who are about to retire

SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;

SELECT * FROM retiring_titles
SELECT SUM(count) FROM retiring_titles


----------------
-- Deliverable 2
-- mentorship eligibilty list
------------------
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
    de.from_date,
    de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
LEFT JOIN dept_emp as de 
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') 
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, de.to_date DESC

SELECT * FROM mentorship_eligibilty
---------------------
-- Deliverable 3
-- Other tables
--------------------
-- mentor by title count
SELECT me.title, 
COUNT(me.title) As total
INTO mentor_title_count
FROM mentorship_eligibilty as me
GROUP BY me.title
ORDER BY total DESC

-- Enlarge the mentor group 
-- by expand the birth range 
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
    de.from_date,
    de.to_date,
	t.title
INTO mentorship_eligibilty_2
FROM employees as e
LEFT JOIN dept_emp as de 
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1964-01-01' AND '1965-12-31') 
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, de.to_date DESC


SELECT me2.title, 
COUNT(me2.title) As new_total
--INTO mentor_title_count_2
FROM mentorship_eligibilty_2 as me2
GROUP BY me2.title
ORDER BY new_total DESC
