UPDATE students
SET student_top_grade = (
  SELECT MAX(grades_value)
  FROM grades
  WHERE grades_stud_id = students.students_id
);

Select *
from professors;

Select *
from courses;

Select *
from students;

Select *
from grades;

INSERT INTO grades (grades_stud_id, grades_prof_id, grades_course_id, grades_value)
VALUES (4, 2, 3, 87.5),
       (5, 3, 4, 92.3),
       (6, 4, 2, 79.8),
       (7, 1, 2, 79.8),
       (8, 2, 2, 79.8),
       (9, 3, 2, 79.8),
       (10, 4, 2, 79.8);
       
SELECT courses.courses_name, AVG(grades.grades_value) AS avg_grade
FROM courses
INNER JOIN grades ON courses.courses_id = grades.grades_course_id
GROUP BY courses.courses_name
ORDER BY avg_grade ASC;

SELECT students.students_name, professors.professors_name, COUNT(DISTINCT grades.grades_course_id) AS num_courses
FROM grades
INNER JOIN students ON grades.grades_stud_id = students.students_id
INNER JOIN professors ON grades.grades_prof_id = professors.professors_id
WHERE students.students_id IN (
    SELECT grades.grades_stud_id
    FROM grades
    GROUP BY grades.grades_stud_id
    HAVING COUNT(DISTINCT grades.grades_course_id) = (
        SELECT MAX(course_count)
        FROM (
            SELECT COUNT(DISTINCT grades.grades_course_id) AS course_count
            FROM grades
            GROUP BY grades.grades_stud_id
        ) AS counts
    )
)
GROUP BY students.students_name, professors.professors_name
ORDER BY num_courses DESC;
       