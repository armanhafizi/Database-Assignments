create database testbench25;
use testbench25;



CREATE TABLE Course
(
    CID varchar(10) PRIMARY KEY NOT NULL,
    name varchar(20)
);


CREATE TABLE PreconditionCourse
(
    CID varchar(10) PRIMARY KEY NOT NULL,
    PCID varchar(20),
    depth int default 0,
    foreign key (PCID) references testbench25.Course(CID)
);


WITH previous(CID, PCID, depth) as (
	select CID,
			PCID,
            0 depth
		from PreconditionCourse
        where PCID is NULL
        union all
        select cur.CID,
				cur.PCID,
                previous.depth + 1 depth
		from PreconditionCourse cur, PreconditionCourse previous
        where  cur.PCID = previous.CID
	)
    select previous.*
    from previous