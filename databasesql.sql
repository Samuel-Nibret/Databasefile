CREATE OR REPLACE TYPE MinitermFragment AS OBJECT (
  fragment VARCHAR2(1000),
  CONSTRUCTOR FUNCTION MinitermFragment(self IN OUT NOCOPY MinitermFragment, fragment VARCHAR2) RETURN SELF AS RESULT
);
/

CREATE OR REPLACE TYPE BODY MinitermFragment AS
  CONSTRUCTOR FUNCTION MinitermFragment(self IN OUT NOCOPY MinitermFragment, fragment VARCHAR2) RETURN SELF AS RESULT IS
  BEGIN
    self.fragment := fragment;
    RETURN;
  END;
END;
/

CREATE OR REPLACE TYPE MinitermFragmentList AS TABLE OF MinitermFragment;
/

CREATE OR REPLACE PACKAGE MinitermFragmentGenerator AS
  FUNCTION generate_fragments(predicates IN SYS.ODCIVARCHAR2LIST) RETURN MinitermFragmentList PIPELINED;
END;
/

CREATE OR REPLACE PACKAGE BODY MinitermFragmentGenerator AS
  FUNCTION generate_fragments(predicates IN SYS.ODCIVARCHAR2LIST) RETURN MinitermFragmentList PIPELINED IS
    fragment MinitermFragment;
  BEGIN
    FOR i IN 1..predicates.COUNT LOOP
      fragment := MinitermFragment(predicates(i));
      PIPE ROW(fragment);
    END LOOP;
    RETURN;
  END;
END;
/