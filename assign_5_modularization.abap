----------------------------------------------------------------------------------------------------------------------------------------------------
"Assignment 5.1
"Modularization – Forms, Includes and Function Module
"Implement the following java code as FORM, INCLUDE and FUNCTION MODULE in ABAP.
"Run the implementations from a report z30923XXX_RUNMODULAR.

"public static double max(double a, double b, double c) {
"if (c > a) {
"return (c > b) ? c : b;
"} else {
"return (a > b) ? a : b;
"}
"}

-----------------------------------------------------------------------------------------------------------------------------------------------------

REPORT z30923_712_ass5_1.

* Declare variables for input values and result
DATA: gv_a TYPE p, gv_b TYPE p, gv_c TYPE p, gv_result TYPE p.

* Set values for input variables
gv_a = 95.
gv_b = 60.
gv_c = 450.

* Perform calculation using the subroutine
PERFORM calculate USING gv_a gv_b gv_c CHANGING gv_result.

* Display the result
WRITE gv_result.

* Include the external ABAP include program with comments
INCLUDE Z30923_712_INC_5_1.

----------------------------------------------------------------------------------------------------------------------------------------------------

"Assignment 5.2
"Modularization – Function Modules
"Develop a function module (z30923XXXXFM_RectCal), that takes the length and width of a rectangle as import parameters and returns the area and
"perimeter as export parameters. If a value less than or equal to 0 is entered for length or width, an exception should be triggered.
"Test the function module.

-----------------------------------------------------------------------------------------------------------------------------------------------------

REPORT z30923_712_ass5_2.

DATA: lv_length    TYPE i,
      lv_width   TYPE i,
      lv_area      TYPE i,
      lv_perimeter TYPE i.

PARAMETERS: p_length  TYPE i,
            p_width TYPE i.

lv_length = p_length.
lv_width = p_width.

CALL FUNCTION 'Z30923_712_FM_5_2'
  EXPORTING
    ip_length    = lv_length
    ip_width   = lv_width
  IMPORTING
    ep_area      = lv_area
    ep_perimeter = lv_perimeter
   EXCEPTIONS
     ZERO_ERROR = 1.


IF sy-subrc = 1.
  MESSAGE 'The values are invalid.' TYPE 'E'.
  ENDIF.

WRITE:/ 'Length:' , lv_length,
/ 'Breadht:' , lv_width,
/ 'Area:' , lv_area,
/ 'Perimeter:' , lv_perimeter.


-----------------------------------------------------------------------------------------------------------------------------------------------------

"Assignment 5.3
"Modularization – Function Modules – Student Database
"Develop a new function module (z30923XXXXFM_AddStu) that creates a new entry in your student table. All necessary information - apart from the
"matriculation number - should be passed to the function module as import parameters. The matriculation number should be generated by the function
"module (e.g., by accessing the database table, SELECT MAX ...) and returned as export parameter. Should not all the necessary parameters be specified,
"or an error occurs when inserting data into the database table, the function module triggers a suitable exception. Test the function module.


-----------------------------------------------------------------------------------------------------------------------------------------------------

REPORT Z30923_712_ASS5_3.

PARAMETERS: p_name TYPE Z30923712_st_rec-FIRST_NAME,
            p_sname TYPE Z30923712_st_rec-LAST_NAME,
            p_dob TYPE Z30923712_st_rec-DATE_OF_BIRTH.

CALL FUNCTION 'Z30923_712_FM_5_3'
  EXPORTING
    lv_first_name  = p_name
    lv_last_name   = p_sname
    lv_date_of_birth = p_dob.

IF sy-subrc <> 0.
  WRITE: / 'Error has occurred.'.
ELSE.
  WRITE: / 'New record updated successfully.'.
ENDIF.











