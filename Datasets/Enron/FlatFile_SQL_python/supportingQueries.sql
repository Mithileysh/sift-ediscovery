SELECT  m.mid, sender, r.rvalue, subject
FROM message m, recipientinfo r
WHERE m.mid = r.mid
  AND LOWER(m.sender) LIKE "%jeff.dasovich@enron.com%"
  AND r.rvalue LIKE "%james.d.steffes@enron.com%";

SELECT  COUNT(*)
FROM message m, recipientinfo r
WHERE m.mid = r.mid
  AND LOWER(m.sender) LIKE "%jeff.dasovich@enron.com%"
  AND r.rvalue LIKE "%james.d.steffes@enron.com%";

SELECT  COUNT(*)
FROM message m, recipientinfo r
WHERE m.mid = r.mid
  AND LOWER(m.sender) LIKE "%james.d.steffes@enron.com%"
  AND r.rvalue LIKE "%jeff.dasovich@enron.com%";



SELECT  m.sender, e.firstName, e.lastName, COUNT(*) AS emailCounts
FROM message m, employeelist e
WHERE m.sender = e.Email_id
      AND YEAR(m.date) = 2001
      AND m.mid IN (
      SELECT mid
      FROM message
      WHERE LOWER(message.body) LIKE "%FERC%"
            OR LOWER(message.body) LIKE "%Affair%"
)
GROUP BY m.sender
ORDER BY emailCounts DESC;



SELECT message.sender, mid
      FROM message
      WHERE LOWER(message.body) LIKE "%FERC%"
            OR LOWER(message.body) LIKE "%Affair%";

SELECT  sender, COUNT(*) AS emailCounts
FROM message
WHERE message.body LIKE "%FERC%"
GROUP BY sender
ORDER BY emailCounts DESC;

SELECT
  rvalue, COUNT(*) AS emailCounts
FROM recipientinfo
GROUP BY rvalue
ORDER BY emailCounts DESC;

#Most email recieved
SELECT firstName, lastName, emailCountsTable.emailCounts
FROM employeelist e, (
  SELECT
    rvalue, COUNT(*) AS emailCounts
  FROM recipientinfo
  GROUP BY rvalue
  ORDER BY COUNT(*) DESC
) AS emailCountsTable
WHERE e.Email_id = emailCountsTable.rvalue
ORDER BY emailCountsTable.emailCounts DESC

#List of employees by emails sent
SELECT  m.sender, e.firstName, e.lastName, COUNT(*) AS emailCounts
FROM message m, employeelist e
WHERE m.sender = e.Email_id
AND YEAR(m.date) = 2001
GROUP BY sender
ORDER BY emailCounts DESC;

# List of employee emails with most emails sent
SELECT  m.sender, COUNT(*) AS emailCounts
FROM message m, employeelist e
WHERE m.sender = e.Email_id
AND YEAR(m.date) = 2001
GROUP BY sender
ORDER BY emailCounts DESC;

  SELECT
    rvalue
  FROM recipientinfo
  GROUP BY rvalue
  ORDER BY COUNT(*) DESC;

SELECT  m.sender, e.firstName, e.lastName, COUNT(*) AS emailCounts
FROM message m, employeelist e
WHERE m.sender = e.Email_id
AND YEAR(m.date) = 2001
AND m.mid IN (
	SELECT mid FROM message
	WHERE LOWER(message.body) LIKE "%ferc%"
	OR LOWER(message.body) LIKE "%affair%"
	OR LOWER(message.body) LIKE "%devastating%"
	OR LOWER(message.body) LIKE "%investigation%"
	OR LOWER(message.body) LIKE "%disclosure%"
	OR LOWER(message.body) LIKE "%bonus%"
	OR LOWER(message.body) LIKE "%meeting%"
	OR LOWER(message.body) LIKE "%plan%"
	OR LOWER(message.body) LIKE "%services%"
	OR LOWER(message.body) LIKE "%report%"
)
GROUP BY m.sender ORDER BY emailCounts DESC;

# Queries for producing the flat file structure

SELECT m.mid AS MessageID, e.Email_id AS SenderEmail, r.rvalue AS RecieverEmail, YEAR(m.date) AS Year, MONTH(m.date) AS Month, DAY(m.date) AS Day, DAYNAME(m.date) AS DayName, HOUR(m.date) AS Hour, m.subject AS Subject, m.body AS Body
FROM message m, employeelist e, recipientinfo r
WHERE e.Email_id = m.sender
  AND m.mid = r.mid
  AND e.Email_id IN ("jeff.dasovich@enron.com", "j.kaminski@enron.com", "kay.mann@enron.com","james.d.steffes@enron.com","matthew.lenhart@enron.com"
"sara.shackleton@enron.com","debra.perlingiere@enron.com","tana.jones@enron.com","steven.j.kean@enron.com","gerald.nemec@enron.com")

