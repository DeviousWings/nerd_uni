USE uni_schema;

SELECT *
FROM professors;

SELECT *
FROM grades;

SELECT *
FROM courses;

SELECT *
FROM students;

ALTER TABLE Grades
ADD FOREIGN KEY (grades_course_id)
REFERENCES Courses(courses_id);



SELECT professors.professors_name, AVG(grades.grades_value) as avg_grades
FROM professors
INNER JOIN courses ON professors.professors_id = courses.courses_prof_id
INNER JOIN grades ON courses.courses_id = grades.grades_course_id
GROUP BY professors.professors_name;