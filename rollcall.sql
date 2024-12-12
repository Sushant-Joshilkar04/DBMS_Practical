drop database practical;
create database practical;
use practical;

CREATE TABLE N_RollCall (
    rollcall_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    date DATE NOT NULL,
    status VARCHAR(10) NOT NULL
);

CREATE TABLE O_RollCall (
    rollcall_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    date DATE NOT NULL,
    status VARCHAR(10) NOT NULL
);

INSERT INTO N_RollCall (rollcall_id, student_id, date, status)
VALUES
    (1, 101, '2024-12-10', 'Present'),
    (2, 102, '2024-12-10', 'Absent'),
    (3, 103, '2024-12-11', 'Present'),
    (4, 104, '2024-12-11', 'Present');
    
INSERT INTO O_RollCall (rollcall_id, student_id, date, status)
VALUES
    (1, 101, '2024-12-10', 'Present'),
    (2, 102, '2024-12-10', 'Absent');
    
DELIMITER $$

CREATE PROCEDURE merge_rollcall_data()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE v_rollcall_id INT;
    DECLARE v_student_id INT;
    DECLARE v_date DATE;
    DECLARE v_status VARCHAR(10);
    
    
    DECLARE cur_rollcall CURSOR FOR
        SELECT rollcall_id, student_id, date, status
        FROM N_RollCall;
    
  
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
   
    OPEN cur_rollcall;
    
  
    read_loop: LOOP
        FETCH cur_rollcall INTO v_rollcall_id, v_student_id, v_date, v_status;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
       
        IF NOT EXISTS (SELECT 1 FROM O_RollCall WHERE rollcall_id = v_rollcall_id) THEN
            
            INSERT INTO O_RollCall (rollcall_id, student_id, date, status)
            VALUES (v_rollcall_id, v_student_id, v_date, v_status);
        END IF;
    END LOOP;
    
    
    CLOSE cur_rollcall;
    
    
    SELECT 'Data merge completed.' AS message;
    
END$$

DELIMITER ;


CALL merge_rollcall_data();

SELECT * FROM O_RollCall;
