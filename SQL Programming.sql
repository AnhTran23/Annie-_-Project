DROP TABLE IF EXISTS Student,Unit,Registration,UnitGrade,Fee;
-- Create table for storing student information
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    is_current ENUM('YES', 'NO') DEFAULT 'YES'
);

-- Create table for storing courses information
CREATE TABLE Unit (
    unit_code VARCHAR(15) PRIMARY KEY,
    unit_name VARCHAR(100),
    is_advanced ENUM('YES', 'NO') DEFAULT 'NO',
    enrollment INT DEFAULT 0,
    registration_date DATE
);

CREATE TABLE Registration (
    student_id INT,
    unit_code VARCHAR(15),
    semester varchar(15),
    registration_date DATE,
    no_penalty_deadline DATE, 
    dropped_out_date DATE,
    status ENUM('active', 'dropped_with_penalty', 'dropped_without_penalty') DEFAULT 'active',  -- Newly added column
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);


CREATE TABLE UnitGrade (
    student_id INT,
    unit_code VARCHAR(15),
    semester VARCHAR(15),
    marks DECIMAL(5, 2),
    status ENUM('active', 'dropped') DEFAULT 'active', 
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);

-- Create table for storing fee information
CREATE TABLE Fee (
    student_id INT,
    semester varchar(15),
    fee_amount DECIMAL(10, 2),
    status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    description VARCHAR(255),
    PRIMARY KEY (student_id, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

-- Insert data into Student table
INSERT INTO Student (student_id, student_name, is_current) VALUES
(10001, 'Alice Smith', 'YES'),
(10002, 'Bob Johnson', 'YES'),
(10003, 'Charlie Brown', 'NO'),
(10004, 'David Wilson', 'YES'),
(10005, 'Emily Davis', 'NO'),
(10006, 'Frank Miller', 'YES'),
(10007, 'Grace Hall', 'YES'),
(10008, 'Hannah Lewis', 'YES'),
(10009, 'Ian Walker', 'NO'),
(10010, 'Julia Young', 'YES'),
(10011, 'Kevin Harris', 'YES'),
(10012, 'Lily Martin', 'YES'),
(10013, 'Mason White', 'NO'),
(10014, 'Nina Clark', 'YES'),
(10015, 'Oliver King', 'YES'),
(10016, 'Paul Scott', 'YES'),
(10017, 'Quinn Green', 'NO'),
(10018, 'Rachel Adams', 'YES'),
(10019, 'Samuel Turner', 'YES'),
(10020, 'Tina Baker', 'YES');

-- Insert data into Unit table
INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) VALUES
('IT101', 'Introduction to Programming', 'NO', 40, '2023-02-20'),
('IT102', 'Data Structures', 'NO', 35, '2023-02-20'),
('IT103', 'Database Systems', 'NO', 30, '2023-02-20'),
('IT401', 'Advanced Algorithms', 'YES', 20, '2023-02-20'),
('IT402', 'Machine Learning', 'YES', 25, '2023-02-20'),
('IT403', 'AI in Business', 'YES', 15, '2023-02-20'),
('IT404', 'Cybersecurity', 'YES', 18, '2023-02-20'),
('IT105', 'Operating Systems', 'NO', 30, '2023-02-20'),
('IT106', 'Web Development', 'NO', 28, '2023-02-20'),
('IT405', 'Cloud Computing', 'YES', 12, '2023-02-20');

-- Insert data into Registration table. 
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
(10001, 'IT101', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10001, 'IT102', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10002, 'IT103', '2023S1', '2023-01-16', '2023-02-13', NULL, 'active'), 
(10002, 'IT105', '2023S1', '2023-01-16', '2023-02-13', '2023-02-10', 'dropped_without_penalty'), 
(10003, 'IT101', '2023S1', '2023-01-17', '2023-02-12', '2023-02-15', 'dropped_with_penalty'), 
(10003, 'IT401', '2023S1', '2023-01-17', '2023-02-14', NULL, 'active'), 
(10004, 'IT402', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10004, 'IT403', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10005, 'IT404', '2023S1', '2023-01-19', '2023-02-16', NULL, 'active'), 
(10005, 'IT102', '2023S1', '2023-01-19', '2023-02-12', '2023-02-20', 'dropped_with_penalty'), 
(10006, 'IT401', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10006, 'IT105', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10007, 'IT402', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10007, 'IT101', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10008, 'IT403', '2023S2', '2023-06-12', '2023-07-10', NULL, 'active'), 
(10008, 'IT102', '2023S2', '2023-06-12', '2023-07-10', '2023-07-15', 'dropped_with_penalty'), 
(10009, 'IT404', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10009, 'IT103', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10010, 'IT401', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10010, 'IT405', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10011, 'IT101', '2024S1', '2024-01-10', '2024-02-10', NULL, 'active'), 
(10011, 'IT402', '2024S1', '2024-01-10', '2024-02-07', NULL, 'active'), 
(10012, 'IT403', '2024S1', '2024-01-11', '2024-02-11', '2024-02-10', 'dropped_with_penalty'), 
(10012, 'IT102', '2024S1', '2024-01-11', '2024-02-11', NULL, 'active'), 
(10013, 'IT105', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10013, 'IT404', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10014, 'IT101', '2024S1', '2024-01-13', '2024-02-10', '2024-02-12', 'dropped_with_penalty'), 
(10014, 'IT405', '2024S1', '2024-01-13', '2024-02-10', NULL, 'active'), 
(10015, 'IT102', '2024S1', '2024-01-14', '2024-02-11', '2024-02-01', 'dropped_without_penalty'), 
(10015, 'IT403', '2024S1', '2024-01-14', '2024-02-11', NULL, 'active'), 
(10016, 'IT401', '2024S1', '2024-01-15', '2024-02-07', NULL, 'active'), 
(10016, 'IT103', '2024S1', '2024-01-15', '2024-02-12', '2024-02-10', 'dropped_without_penalty'), 
(10017, 'IT102', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10017, 'IT404', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10018, 'IT101', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10018, 'IT401', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10019, 'IT105', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10019, 'IT402', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10020, 'IT403', '2024S2', '2024-06-04', '2024-07-02', NULL, 'active'), 
(10020, 'IT101', '2024S2', '2024-06-04', '2024-06-30', NULL, 'active');


-- Insert data into UnitGrade table with semester, marks, and status (active or dropped)
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10001, 'IT101', '2023S1', 75.00, 'active'),
(10001, 'IT102', '2023S1', 65.00, 'active'),
(10002, 'IT103', '2023S1', 85.50, 'active'),
(10002, 'IT105', '2023S1', NULL, 'dropped'),
(10003, 'IT101', '2023S1', NULL, 'dropped'),
(10003, 'IT401', '2023S1', NULL, 'dropped'),
(10004, 'IT402', '2023S1', 55.00, 'active'),
(10004, 'IT403', '2023S1', 92.00, 'active'),
(10005, 'IT404', '2023S1', 50.00, 'active'), 
(10005, 'IT102', '2023S1', NULL, 'dropped'),
(10006, 'IT401', '2023S2', 47.00, 'active'),  
(10006, 'IT105', '2023S2', 60.00, 'active'),
(10007, 'IT402', '2023S2', 88.00, 'active'),
(10007, 'IT101', '2023S2', 30.00, 'active'), 
(10008, 'IT403', '2023S2', 90.00, 'active'),
(10008, 'IT102', '2023S2', NULL, 'dropped'), 
(10009, 'IT404', '2023S2', 40.00, 'active'),
(10009, 'IT103', '2023S2', 55.00, 'active'),
(10010, 'IT401', '2023S2', 85.00, 'active'),
(10010, 'IT405', '2023S2', 32.00, 'active'), 
(10011, 'IT101', '2024S1', 75.00, 'active'),
(10011, 'IT402', '2024S1', 65.00, 'active'),
(10012, 'IT403', '2024S1', NULL, 'dropped'), 
(10012, 'IT102', '2024S1', 70.00, 'active'),
(10013, 'IT105', '2024S1', 85.00, 'active'),
(10013, 'IT404', '2024S1', 48.00, 'active'),
(10014, 'IT101', '2024S1', NULL, 'dropped'), 
(10014, 'IT405', '2024S1', 88.00, 'active'),
(10015, 'IT102', '2024S1', NULL, 'dropped'), 
(10015, 'IT403', '2024S1', 90.00, 'active'),
(10016, 'IT401', '2024S1', 75.00, 'active'),
(10016, 'IT103', '2024S1', NULL, 'dropped'),  
(10017, 'IT102', '2024S2', 70.00, 'active'),
(10017, 'IT404', '2024S2', 68.00, 'active'),
(10018, 'IT101', '2024S2', 60.00, 'active'),
(10018, 'IT401', '2024S2', 80.00, 'active'),
(10019, 'IT105', '2024S2', 82.00, 'active'),
(10019, 'IT402', '2024S2', 90.00, 'active'),
(10020, 'IT403', '2024S2', 94.00, 'active'),
(10020, 'IT101', '2024S2', 78.00, 'active');


-- Insert data into Fee table 
INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
(10001, '2023S1', 6500.00, 'PAID', 'Tuition Fee'),
(10001, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10002, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10002, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10003, '2023S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10003, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10004, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10004, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10005, '2023S1', 6500.00, 'UNPAID', 'Tuition Fee'),
(10005, '2023S2', 6500.00, 'PAID', 'Late Unit Enrollment Fee'),
(10006, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10006, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10007, '2023S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10007, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2024S1', 8500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10009, '2023S2', 6500.00, 'UNPAID', 'Tuition Fee'),
(10009, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10010, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10010, '2024S1', 8500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10012, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10012, '2024S2', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S2', 7500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10014, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10014, '2024S2', 8500.00, 'PAID', 'Dropped Unit Penalty'),
(10015, '2024S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10015, '2024S2', 6500.00, 'UNPAID', 'Tution Fee'),
(10016, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10016, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10017, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10017, '2023S2', 6500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10018, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10018, '2023S2', 6500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10019, '2024S2', 8500.00, 'PAID', 'Tuition Fee'),
(10019, '2023S2', 7500.00, 'PAID', 'Tution Fee'),
(10020, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10020, '2023S2', 8500.00, 'PAID', 'Tuition Fee');


-- TASK 2    
DELIMITER // 
DROP FUNCTION IF EXISTS GetOutstandingBalance;
CREATE FUNCTION GetOutstandingBalance ( p_student_id int)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
     DECLARE total_balance DECIMAL(10,2) DEFAULT 0;
     
SELECT IFNULL(SUM(fee_amount),0) INTO total_balance
FROM Fee
WHERE student_id = p_student_id 
      AND status = 'UNPAID';

RETURN total_balance;
END //
DELIMITER ;


-- TASK 3
-- Procedure handling for Register or Drop Unit:
DELIMITER // 
DROP PROCEDURE IF EXISTS RegisterOrDropUnit;
CREATE PROCEDURE RegisterOrDropUnit (
    IN p_student_id INT, 
    IN p_unit_code VARCHAR(15), 
    IN p_semester VARCHAR(15),
    IN p_action VARCHAR(10)  
)
BEGIN
    DECLARE v_no_penalty_deadline DATE;
    DECLARE v_drop_date DATE;
    DECLARE v_is_advanced ENUM('YES', 'NO');
    DECLARE v_existing_fee_amount DECIMAL(10,2);
    DECLARE v_penalty_amount DECIMAL(10,2);
    DECLARE v_outstanding_balance DECIMAL(10,2);
    DECLARE v_failed_units INT;
    DECLARE v_fee_amount DECIMAL(10,2);
    DECLARE v_registration_allowed BOOLEAN DEFAULT TRUE;
    DECLARE v_already_registered INT DEFAULT 0;
	DECLARE v_previous_semester VARCHAR(15);
    DECLARE v_year INT;
    DECLARE v_term CHAR(2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'An error occurred during registration or drop handling.';
    END;

    -- Start transaction
    START TRANSACTION;
    
    -- Calculate previous semester from the current semester (p_semester)
    SET v_year = CAST(SUBSTRING(p_semester, 1, 4) AS UNSIGNED);
    SET v_term = SUBSTRING(p_semester, 5, 2);  
    
    IF v_term = 'S1' THEN
        SET v_year = v_year - 1;
        SET v_previous_semester = CONCAT(v_year, 'S2');
    ELSE
        SET v_previous_semester = CONCAT(v_year, 'S1');
    END IF;

    -- Check if the student is already registered for this unit and semester
    SELECT COUNT(*)
    INTO v_already_registered
    FROM Registration
    WHERE student_id = p_student_id 
      AND unit_code = p_unit_code
      AND semester = p_semester;

    -- Handle based on the action specified
    IF p_action = 'register' THEN
        IF v_already_registered > 0 THEN
            -- If student is already registered, display a message
            SELECT 'Student is already registered for this unit.' AS result;
        ELSE
            -- Check the outstanding balance
            SELECT SUM(fee_amount) 
            INTO v_outstanding_balance
            FROM Fee
            WHERE student_id = p_student_id 
              AND status = 'UNPAID'
              AND semester = v_previous_semester;

            -- Check the failed units
            SELECT COUNT(*) 
            INTO v_failed_units
            FROM UnitGrade
            WHERE student_id = p_student_id 
              AND marks < 50 
              AND status = 'active';

            -- Check if the unit is advanced
            SELECT is_advanced 
            INTO v_is_advanced
            FROM Unit
            WHERE unit_code = p_unit_code;

            -- Prevent advanced-level registration if the student has unpaid balance or failed units
            IF v_is_advanced = 'YES' AND (v_outstanding_balance > 0 OR v_failed_units > 2) THEN
                SET v_registration_allowed = FALSE;
                SELECT 'Cannot register for advanced unit due to outstanding balance or failed units.' AS result;
            END IF;

            -- Prevent registration if there's any outstanding balance
            IF v_outstanding_balance > 0 THEN
                SET v_registration_allowed = FALSE;
                SELECT 'Cannot register for unit due to outstanding fees.' AS result;
            END IF;

            -- If registration is allowed, proceed with registration
            IF v_registration_allowed THEN
                -- Determine the tuition fee 
                IF v_is_advanced = 'YES' THEN
                    SET v_fee_amount = 4000.00;
                ELSE
                    SET v_fee_amount = 3000.00;
                END IF;
                
             -- Insert the Registration record
                INSERT INTO Registration 
                SET student_id = p_student_id,
                    unit_code = p_unit_code,
                    semester = p_semester,
                    registration_date = CURDATE(),
                    no_penalty_deadline = DATE_ADD(CURDATE(), INTERVAL 30 DAY),
                    dropped_out_date = NULL,
                    status = 'active';
                    
                -- Insert the Fee record
                INSERT INTO Fee 
                SET student_id = p_student_id,
                    semester = p_semester,
                    fee_amount = v_fee_amount,
                    status = 'unpaid',
                    description = 'Tuition Fee';

                -- Insert the UnitGrade record
                INSERT INTO UnitGrade
                SET student_id = p_student_id,
                    unit_code = p_unit_code,
                    semester = p_semester,
                    marks = NULL,
                    status = 'active';

                -- Update the unit enrollment
                UPDATE Unit
                SET enrollment = enrollment + 1
                WHERE unit_code = p_unit_code;

                SELECT 'Registration successful.' AS result;
            END IF;
        END IF;
        
    ELSEIF p_action = 'drop' THEN
        IF v_already_registered = 0 THEN
            -- If student is not registered, display a message
            SELECT 'Student is not registered for this unit, cannot drop.' AS result;
        ELSE
            -- Get the no-penalty deadline
            SELECT no_penalty_deadline 
            INTO v_no_penalty_deadline
            FROM Registration
            WHERE student_id = p_student_id 
              AND semester = p_semester
              AND unit_code = p_unit_code;

            SET v_drop_date = CURDATE();

            -- Check if drop date is after no-penalty deadline and apply the penalty
            IF v_drop_date > v_no_penalty_deadline THEN
                IF v_is_advanced = 'YES' THEN
                    SET v_penalty_amount = 600.00;
                ELSE
                    SET v_penalty_amount = 400.00;
                END IF;

                -- Get existing unpaid fee amount
                SELECT fee_amount
                INTO v_existing_fee_amount 
                FROM Fee
                WHERE student_id = p_student_id 
                  AND semester = p_semester;

                -- Update fee with penalty
                UPDATE Fee
                SET fee_amount = v_existing_fee_amount + v_penalty_amount,
                    description = 'Dropped Unit Penalty',
                    status = 'UNPAID'
                WHERE student_id = p_student_id 
                  AND semester = p_semester;
                  
              -- Update Registration table    
				UPDATE Registration
                SET status = 'dropped_with_penalty', 
                    dropped_out_date = v_drop_date
                WHERE student_id = p_student_id
                  AND unit_code = p_unit_code
                  AND semester = p_semester;
                  
            ELSE
                -- No penalty, update to 'dropped_without_penalty'
                UPDATE Registration
                SET status = 'dropped_without_penalty', 
                    dropped_out_date = v_drop_date
                WHERE student_id = p_student_id
                  AND unit_code = p_unit_code
                  AND semester = p_semester;
            END IF;

            -- Update UnitGrade and unit enrollment after drop
            UPDATE UnitGrade
            SET status = 'dropped',
                marks = NULL
            WHERE student_id = p_student_id
              AND unit_code = p_unit_code
              AND semester = p_semester;

            UPDATE Unit
            SET enrollment = enrollment - 1
            WHERE unit_code = p_unit_code;

            SELECT 'Drop process completed.' AS result;
        END IF;
    END IF;

    COMMIT;
END //
DELIMITER ;
          
-- TASK 4:
DELIMITER //
DROP TRIGGER IF EXISTS Apply_penalty;
CREATE TRIGGER Apply_penalty 
AFTER UPDATE ON Registration
FOR EACH ROW 
    BEGIN 
    DECLARE penalty_amount DECIMAL(10, 2);
    DECLARE v_is_advanced ENUM('YES','NO');
    DECLARE fee_description VARCHAR(255);
    DECLARE fee_status ENUM('paid', 'unpaid');
    
    IF NEW.status = 'dropped_with_penalty' AND OLD.status <> 'dropped_with_penalty' THEN 
       IF NEW.dropped_out_date > NEW.no_penalty_deadline THEN
          SELECT is_advanced INTO v_is_advanced
          FROM Unit
          WHERE unit_code = NEW.unit_code; 
          
          IF v_is_advanced = 'YES' THEN
             SET penalty_amount = 600.00;
		  ELSE
             SET penalty_amount = 400.00;
		  END IF;
          
          SET fee_description = 'Dropped Unit Penalty';
		  SET fee_status = 'unpaid';
          
          INSERT INTO Fee
          SET student_id = NEW.student_id,
              semester = NEW.semester,
              fee_amount = penalty_amount,
              status = fee_status,
              description = fee_description
          ON DUPLICATE KEY UPDATE
              fee_amount = fee_amount + penalty_amount,
              status = fee_status,
              description = fee_description;
	   END IF;
	END IF;
END //

DELIMITER ;

-- Test for Task 2:
-- Insert 2 new data for Fee table:
INSERT INTO Fee (student_id, semester, fee_amount, status, description) 
VALUES 
(10020, '2024S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10020, '2023S1', 6000.00, 'UNPAID', 'Dropped Unit Penalty');

-- Case 1:
SELECT 10019 AS student_id, GetOutstandingBalance(10019) AS OutstandingBalance;

-- Case 2:
SELECT 10020 AS student_id, GetOutstandingBalance(10020) AS OutstandingBalance;

-- Test for all student
SELECT student_id, GetOutstandingBalance(student_id) AS OutstandingBalance
FROM Student;


-- Test for Task 3:
-- Insert 3 new data for UnitGrade table:
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10019, 'IT401', '2024S2', 30.00, 'active'), 
(10019, 'IT403', '2024S2', 45.00, 'active'),
(10019, 'IT103', '2024S2', 40.00, 'active');

-- Test for Registration: 
-- Case 1: Student is already registered
CALL RegisterOrDropUnit(10018, 'IT401', '2024S2','register');

-- Case 2:Prevent advanced-level registration if the student has unpaid balance or failed units
CALL RegisterOrDropUnit(10019, 'IT405', '2025S1','register');

-- Case 3:Prevent registration if there's any outstanding balance
CALL RegisterOrDropUnit(10020, 'IT101', '2025S1', 'register');

-- Case 4: Registration successful
CALL RegisterOrDropUnit(10010, 'IT401', '2025S1','register');

SELECT * FROM Registration
WHERE student_id = 10010 AND unit_code = 'IT401' AND semester = '2025S1';

SELECT * FROM UnitGrade
WHERE student_id = 10010 AND unit_code = 'IT401' AND semester = '2025S1';

SELECT * FROM Fee
WHERE student_id = 10010 AND semester = '2025S1';

-- Test Dropping Out:
-- Insert 2 new data for Registration table
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
(10009, 'IT101', '2024S2', '2024-09-20', '2024-10-18', NULL, 'active'),
(10008, 'IT401', '2024S2', '2024-09-23', '2024-10-23', NULL, 'active');

-- Insert 2 new data for UnitGrade table
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10009, 'IT101', '2024S2', NULL, 'active'),
(10008, 'IT401', '2024S2', NULL, 'active');

-- Insert 2 new data for Fee table
INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
(10009, '2024S2', 3000.00, 'UNPAID', 'Tuition Fee'),
(10008, '2024S2', 4000.00, 'UNPAID', 'Tuition Fee');

-- Case 1: Unsuccessful drop
CALL RegisterOrDropUnit(10020, 'IT401', '2024S2', 'drop');

-- Case 2: Successful drop
CALL RegisterOrDropUnit(10009, 'IT101', '2024S2', 'drop');

SELECT * FROM Registration
WHERE student_id = 10009 AND unit_code = 'IT101' AND semester = '2024S2';

SELECT * FROM Fee
WHERE student_id = 10009 AND semester = '2024S2';

SELECT * FROM UnitGrade
WHERE student_id = 10009 AND unit_code = 'IT101' AND semester = '2024S2';
--
CALL RegisterOrDropUnit(10008, 'IT401', '2024S2', 'drop');

SELECT * FROM Registration
WHERE student_id = 10008 AND unit_code = 'IT401' AND semester = '2024S2';

SELECT * FROM Fee
WHERE student_id = 10008 AND semester = '2024S2';

SELECT * FROM UnitGrade
WHERE student_id = 10008 AND unit_code = 'IT401' AND semester = '2024S2';














          