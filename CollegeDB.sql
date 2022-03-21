-- Generated by Oracle SQL Developer Data Modeler 21.4.1.349.1605
--   at:        2022-03-21 13:37:08 NPT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE address (
    address_id    INTEGER NOT NULL,
    country       VARCHAR2(60 CHAR) NOT NULL,
    province      VARCHAR2(20 CHAR) NOT NULL,
    city_locality VARCHAR2(80 CHAR) NOT NULL,
    street_name   VARCHAR2(80 CHAR) NOT NULL
);

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( address_id );

CREATE TABLE assignment (
    assignment_id   INTEGER NOT NULL,
    assignment_type VARCHAR2(30 CHAR) NOT NULL,
    department_id   INTEGER NOT NULL
);

ALTER TABLE assignment ADD CONSTRAINT assignment_pk PRIMARY KEY ( assignment_id );

CREATE TABLE assignment_result (
    student_id    INTEGER NOT NULL,
    module_id     INTEGER NOT NULL,
    assignment_id INTEGER NOT NULL,
    grade         VARCHAR2(2 CHAR) NOT NULL,
    post_date     DATE NOT NULL
);

ALTER TABLE assignment_result
    ADD CONSTRAINT assignment_result_pk PRIMARY KEY ( assignment_id,
                                                      student_id,
                                                      module_id );

CREATE TABLE attendance (
    attendance_id   INTEGER NOT NULL,
    attendance_date DATE NOT NULL,
    department_id   INTEGER NOT NULL
);

ALTER TABLE attendance ADD CONSTRAINT attendance_pk PRIMARY KEY ( attendance_id );

CREATE TABLE department (
    department_id       INTEGER NOT NULL,
    department_name     VARCHAR2(25 CHAR) NOT NULL,
    department_location VARCHAR2(30 CHAR) NOT NULL,
    num_employees       SMALLINT NOT NULL
);

ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( department_id );

CREATE TABLE fee (
    fee_id        INTEGER NOT NULL,
    fee_type      VARCHAR2(30 CHAR) NOT NULL,
    fee_amount    NUMBER(8, 2) NOT NULL,
    department_id INTEGER NOT NULL
);

ALTER TABLE fee ADD CONSTRAINT fee_pk PRIMARY KEY ( fee_id );

CREATE TABLE grade_status (
    grade  VARCHAR2(2 CHAR) NOT NULL,
    status VARCHAR2(4 CHAR) NOT NULL
);

ALTER TABLE grade_status
    ADD CHECK ( status IN ( 'Fail', 'Pass' ) );

ALTER TABLE grade_status ADD CONSTRAINT grade_status_pk PRIMARY KEY ( grade );

CREATE TABLE module (
    module_id     INTEGER NOT NULL,
    module_code   VARCHAR2(10 CHAR) NOT NULL,
    module_name   VARCHAR2(100 CHAR) NOT NULL,
    week_duration SMALLINT NOT NULL,
    credit_hours  SMALLINT NOT NULL
);

ALTER TABLE module ADD CONSTRAINT module_pk PRIMARY KEY ( module_id );

CREATE TABLE module_allocation (
    teacher_id INTEGER NOT NULL,
    module_id  INTEGER NOT NULL
);

ALTER TABLE module_allocation ADD CONSTRAINT module_allocation_pk PRIMARY KEY ( teacher_id,
                                                                                module_id );

CREATE TABLE module_enrolment (
    student_id INTEGER NOT NULL,
    module_id  INTEGER NOT NULL
);

ALTER TABLE module_enrolment ADD CONSTRAINT module_enrolment_pk PRIMARY KEY ( student_id,
                                                                              module_id );

CREATE TABLE person (
    person_id   INTEGER NOT NULL,
    person_type VARCHAR2(15 CHAR) NOT NULL,
    full_name   VARCHAR2(40 CHAR) NOT NULL,
    gender      VARCHAR2(6 CHAR) NOT NULL,
    dob         DATE NOT NULL,
    phone       VARCHAR2(15 CHAR) NOT NULL,
    email       VARCHAR2(40 CHAR) NOT NULL
);

ALTER TABLE person
    ADD CHECK ( gender IN ( 'Female', 'Male', 'Other' ) );

ALTER TABLE person
    ADD CONSTRAINT fkarc_lov CHECK ( person_type IN ( 'Student', 'Teacher' ) );

ALTER TABLE person ADD CONSTRAINT person_pk PRIMARY KEY ( person_id );

ALTER TABLE person ADD CONSTRAINT person_email_un UNIQUE ( email );

ALTER TABLE person ADD CONSTRAINT person_phone_un UNIQUE ( phone );

CREATE TABLE person_address (
    address_id INTEGER NOT NULL,
    person_id  INTEGER NOT NULL
);

ALTER TABLE person_address ADD CONSTRAINT person_address_pk PRIMARY KEY ( address_id,
                                                                          person_id );

CREATE TABLE student (
    student_id     INTEGER NOT NULL,
    specialization VARCHAR2(60 CHAR) NOT NULL,
    "group"        VARCHAR2(5 CHAR) NOT NULL,
    date_joined    DATE NOT NULL
);

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( student_id );

CREATE TABLE student_attendance (
    student_id        INTEGER NOT NULL,
    attendance_id     INTEGER NOT NULL,
    attendance_status VARCHAR2(8 CHAR) NOT NULL
);

ALTER TABLE student_attendance
    ADD CHECK ( attendance_status IN ( 'Absent', 'Present' ) );

ALTER TABLE student_attendance ADD CONSTRAINT student_attendance_pk PRIMARY KEY ( student_id,
                                                                                  attendance_id );

CREATE TABLE student_fee (
    student_id   INTEGER NOT NULL,
    fee_id       INTEGER NOT NULL,
    payment_date DATE NOT NULL
);

ALTER TABLE student_fee ADD CONSTRAINT student_fee_pk PRIMARY KEY ( student_id,
                                                                    fee_id );

CREATE TABLE teacher (
    teacher_id  INTEGER NOT NULL,
    salary      NUMBER(8, 2) NOT NULL,
    date_joined DATE NOT NULL
);

ALTER TABLE teacher ADD CONSTRAINT teacher_pk PRIMARY KEY ( teacher_id );

ALTER TABLE assignment_result
    ADD CONSTRAINT ar_assignment_fk FOREIGN KEY ( assignment_id )
        REFERENCES assignment ( assignment_id );

ALTER TABLE assignment_result
    ADD CONSTRAINT ar_grade_status_fk FOREIGN KEY ( grade )
        REFERENCES grade_status ( grade );

ALTER TABLE assignment_result
    ADD CONSTRAINT ar_module_enrolment_fk FOREIGN KEY ( student_id,
                                                        module_id )
        REFERENCES module_enrolment ( student_id,
                                      module_id );

ALTER TABLE assignment
    ADD CONSTRAINT as_department_fk FOREIGN KEY ( department_id )
        REFERENCES department ( department_id );

ALTER TABLE attendance
    ADD CONSTRAINT at_department_fk FOREIGN KEY ( department_id )
        REFERENCES department ( department_id );

ALTER TABLE fee
    ADD CONSTRAINT f_department_fk FOREIGN KEY ( department_id )
        REFERENCES department ( department_id );

ALTER TABLE module_allocation
    ADD CONSTRAINT ma_module_fk FOREIGN KEY ( module_id )
        REFERENCES module ( module_id );

ALTER TABLE module_allocation
    ADD CONSTRAINT ma_teacher_fk FOREIGN KEY ( teacher_id )
        REFERENCES teacher ( teacher_id );

ALTER TABLE module_enrolment
    ADD CONSTRAINT me_module_fk FOREIGN KEY ( module_id )
        REFERENCES module ( module_id );

ALTER TABLE module_enrolment
    ADD CONSTRAINT me_student_fk FOREIGN KEY ( student_id )
        REFERENCES student ( student_id );

ALTER TABLE person_address
    ADD CONSTRAINT pa_address_fk FOREIGN KEY ( address_id )
        REFERENCES address ( address_id );

ALTER TABLE person_address
    ADD CONSTRAINT pa_person_fk FOREIGN KEY ( person_id )
        REFERENCES person ( person_id );

ALTER TABLE student
    ADD CONSTRAINT s_person_fk FOREIGN KEY ( student_id )
        REFERENCES person ( person_id );

ALTER TABLE student_attendance
    ADD CONSTRAINT sa_attendance_fk FOREIGN KEY ( attendance_id )
        REFERENCES attendance ( attendance_id );

ALTER TABLE student_attendance
    ADD CONSTRAINT sa_student_fk FOREIGN KEY ( student_id )
        REFERENCES student ( student_id );

ALTER TABLE student_fee
    ADD CONSTRAINT sf_fee_fk FOREIGN KEY ( fee_id )
        REFERENCES fee ( fee_id );

ALTER TABLE student_fee
    ADD CONSTRAINT sf_student_fk FOREIGN KEY ( student_id )
        REFERENCES student ( student_id );

ALTER TABLE teacher
    ADD CONSTRAINT t_person_fk FOREIGN KEY ( teacher_id )
        REFERENCES person ( person_id );

CREATE OR REPLACE TRIGGER arc_fkarc_student BEFORE
    INSERT OR UPDATE OF student_id ON student
    FOR EACH ROW
DECLARE
    d VARCHAR2(15 CHAR);
BEGIN
    SELECT
        a.person_type
    INTO d
    FROM
        person a
    WHERE
        a.person_id = :new.student_id;

    IF ( d IS NULL OR d <> 'Student' ) THEN
        raise_application_error(
                               -20223,
                               'FK S_Person_FK in Table Student violates Arc constraint on Table Person - discriminator column person_type doesn''t have value ''Student'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_teacher BEFORE
    INSERT OR UPDATE OF teacher_id ON teacher
    FOR EACH ROW
DECLARE
    d VARCHAR2(15 CHAR);
BEGIN
    SELECT
        a.person_type
    INTO d
    FROM
        person a
    WHERE
        a.person_id = :new.teacher_id;

    IF ( d IS NULL OR d <> 'Teacher' ) THEN
        raise_application_error(
                               -20223,
                               'FK T_Person_FK in Table Teacher violates Arc constraint on Table Person - discriminator column person_type doesn''t have value ''Teacher'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE SEQUENCE Address_address_id_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER Address_address_id_TRG 
BEFORE INSERT ON Address 
FOR EACH ROW 
WHEN (NEW.address_id IS NULL) 
BEGIN
:new.address_id := address_address_id_seq.nextval;

end;
/

CREATE SEQUENCE Assignment_assignment_id_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER Assignment_assignment_id_TRG 
BEFORE INSERT ON Assignment 
FOR EACH ROW 
WHEN (NEW.assignment_id IS NULL) 
BEGIN
:new.assignment_id := assignment_assignment_id_seq.nextval;

end;
/

CREATE SEQUENCE Attendance_attendance_id_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER Attendance_attendance_id_TRG 
BEFORE INSERT ON Attendance 
FOR EACH ROW 
WHEN (NEW.attendance_id IS NULL) 
BEGIN
:new.attendance_id := attendance_attendance_id_seq.nextval;

end;
/

CREATE SEQUENCE Department_department_id_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER Department_department_id_TRG 
BEFORE INSERT ON Department 
FOR EACH ROW 
WHEN (NEW.department_id IS NULL) 
BEGIN
:new.department_id := department_department_id_seq.nextval;

end;
/

CREATE SEQUENCE Fee_fee_id_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER Fee_fee_id_TRG 
BEFORE INSERT ON Fee 
FOR EACH ROW 
WHEN (NEW.fee_id IS NULL) 
BEGIN
:new.fee_id := fee_fee_id_seq.nextval;

end;
/

CREATE SEQUENCE Module_module_id_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER Module_module_id_TRG 
BEFORE INSERT ON Module 
FOR EACH ROW 
WHEN (NEW.module_id IS NULL) 
BEGIN
:new.module_id := module_module_id_seq.nextval;

end;
/

CREATE SEQUENCE Person_person_id_SEQ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER Person_person_id_TRG 
BEFORE INSERT ON Person 
FOR EACH ROW 
WHEN (NEW.person_id IS NULL) 
BEGIN
:new.person_id := person_person_id_seq.nextval;

end;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             40
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           9
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          7
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
