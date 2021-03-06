Creating a dataset for each columm of a dataset (great example of vnext())


  INPUT
  =====
   WORK.CLASS total obs=19

     NAME       SEX     AGE

     Alfred      M      14
     Alice       F      13
     Barbara     F      13
     Carol       F      14
     Henry       M      14
    ...

   WORKING CODE
   ============
       if 0 then set class;

       do I=1 by 1 ;

         call vnext(varname);
         call symputx('varname',varname);

         if upcase(varname) eq "VARNAME" then leave;

         rc=dosubl('
           data &varname;
              set class(keep=&varname);
           run;quit;
         ');

       end;

   OUTPUT
   ======
      WORK.NAME

        NAME
        Alfred
        Alice

      WORK.SEX

        SEX
         M
         F
         F

      WORK.AGE

        AGE
        14
        13
        13


https://goo.gl/qHj2rS
https://communities.sas.com/t5/General-SAS-Programming/How-to-split-a-sas-dataset-columnwise/m-p/409480#M51377

M Keintz  profile
https://communities.sas.com/t5/user/viewprofilepage/user-id/31461

*                _                _       _
 _ __ ___   __ _| | _____      __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \    / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/   | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|    \__,_|\__,_|\__\__,_|

;
data class;
  set sashelp.class(keep=name sex age);
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

data _null_;
  if 0 then set class;
  length varname $32;
  do I=1 by 1 ;
    call vnext(varname);
    call symputx('varname',varname);
    if varname eq "VARNAME" then leave;
      rc=dosubl('
       data &varname;
          set class(keep=&varname);
       run;quit;
    ');
  end;
run;quit;



