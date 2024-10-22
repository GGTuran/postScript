-- Active: 1729147065427@@127.0.0.1@5432@university_db
--Creating student table

CREATE Table students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(30) DEFAULT NULL
);

--Creating courses table

CREATE Table courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INT NOT NULL
);

--Creating enrollment table
CREATE Table enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id)
);



--Insert data into students table

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark)
VALUES
('Sameer', 21, 'sameer@example.com', 48, 60),
('Zoya', 23, 'zoya@example.com', 52, 58),
('Nabil', 22, 'nabil@example.com', 37, 46),
('Rafi', 24, 'rafi@example.com', 41, 40),
('Sophia', 22, 'sophia@example.com', 50, 52),
('Hasan', 23, 'hasan@gmail.com', 43, 39);


--Insert data into courses table

INSERT INTO courses (course_name, credits)
VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);


--Insert data into enrollment table

INSERT INTO enrollment (student_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2);


--Query 1:Insert a new student record 

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES
('Turan', 22, 'tayyabturan67@gmail.com', 58, 55, NULL);



--Query 2:Retrieve the names of all students who are enrolled in the course titled 'Next.js'

--first we will use JOIN keyword to join all three tables and then filter using WHERE keyword
SELECT student_name FROM students
JOIN enrollment USING(student_id)              --query for joining enrollment table
JOIN courses USING(course_id)                  --query for joining courses table
WHERE course_name = 'Next.js'                  --filtering by course NAME



--Query 3:Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.

--first we need to find the student who has highest total
--then we will update the status using UPDATE keyword

UPDATE students
SET status = 'Awarded'                                                                                      --query for updating status
WHERE student_id = 
(SELECT student_id from students ORDER BY(frontend_mark + backend_mark) DESC LIMIT 1)                       --query for searching the student with highest mark


--Query 4:Delete all courses that have no students enrolled.

--first we will find those course_id which are enrolled by students
--then we will delete the other courses by separating them by using DISTINCT keyword

DELETE FROM courses
WHERE course_id  NOT IN(                                            --excluding the courses which are already enrolled
    SELECT DISTINCT course_id FROM enrollment                       --query for excluding the courses
);


--Query 5:Retrieve the names of students using a limit of 2, starting from the 3rd student.

--We can do this by using limit and offset
--Offset is used to skip a specific number of rows before returning the rows in the result set.

SELECT student_name FROM students
LIMIT 2 OFFSET 2;                                                                                                --Offset will exclude first two students



--Query 6:Retrieve the course names and the number of students enrolled in each course.

--First we will join courses and enrollment
--Then we will use COUNT function to count the number of students based on student_id


SELECT course_name, COUNT(student_id) AS students_enrolled                                                  --retrieving name and count function
FROM courses 
JOIN enrollment USING(course_id)                                                                             --joining both tables  
GROUP BY course_id;




--Query 7:Calculate and display the average age of all students.

--We need to use avg function to get the average age of all students

SELECT avg(age) as average_age from students;



--Query 8:Retrieve the names of students whose email addresses contain 'example.com'.

--We need to use Like keyword while filtering the email name

SELECT student_name from students
WHERE email LIKE '%example.com';                                                             --query for filtering email