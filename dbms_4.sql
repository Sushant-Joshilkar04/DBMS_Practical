-- Create the table N_RollCall
CREATE TABLE N_RollCall (
  Student_ID INT NOT NULL,
  Date DATE NOT NULL,
  Status VARCHAR(10),
  PRIMARY KEY (Student_ID, Date)
);

-- Create the table O_RollCall
CREATE TABLE O_RollCall (
  Student_ID INT NOT NULL,
  Date DATE NOT NULL,
  Status VARCHAR(10),
  PRIMARY KEY (Student_ID, Date)
);

-- Insert sample data into N_RollCall
INSERT INTO N_RollCall (Student_ID, Date, Status) VALUES (1, '2024-12-10', 'Present');
INSERT INTO N_RollCall (Student_ID, Date, Status) VALUES (2, '2024-12-10', 'Absent');
INSERT INTO N_RollCall (Student_ID, Date, Status) VALUES (3, '2024-12-10', 'Present');

-- Insert sample data into O_RollCall
INSERT INTO O_RollCall (Student_ID, Date, Status) VALUES (1, '2024-12-10', 'Present');
INSERT INTO O_RollCall (Student_ID, Date, Status) VALUES (4, '2024-12-09', 'Present');

-- Create the stored procedure for merging data
DELIMITER $$

CREATE PROCEDURE MergeRollCallData()
BEGIN
  -- Loop through rows in N_RollCall
  DECLARE done INT DEFAULT FALSE;
  DECLARE v_Student_ID INT;
  DECLARE v_Date DATE;
  DECLARE v_Status VARCHAR(10);
  DECLARE rollcall_cursor CURSOR FOR SELECT Student_ID, Date, Status FROM N_RollCall;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN rollcall_cursor;

  read_loop: LOOP
    FETCH rollcall_cursor INTO v_Student_ID, v_Date, v_Status;
    IF done THEN
      LEAVE read_loop;
    END IF;

    -- Check and insert if the row does not exist in O_RollCall
    IF NOT EXISTS (
      SELECT 1 FROM O_RollCall
      WHERE Student_ID = v_Student_ID AND Date = v_Date
    ) THEN
      INSERT INTO O_RollCall (Student_ID, Date, Status)
      VALUES (v_Student_ID, v_Date, v_Status);
    END IF;
  END LOOP;

  CLOSE rollcall_cursor;
END$$

DELIMITER ;

-- Check data in N_RollCall
SELECT * FROM N_RollCall;

-- Check data in O_RollCall
SELECT * FROM O_RollCall;


-- Call the procedure
CALL MergeRollCallData();

SELECT * FROM O_RollCall;

