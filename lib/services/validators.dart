import '../strings.dart';

/*----------------------------------------------------------------------------\
|
|  Module Details:
|
|  Name:     validators.dart
|
|  Purpose:  validators for forms.
|
|  History:
|
|  Date      Release  Name    Ver.    Comments
|  --------- -------  -----   -----   -----------------------------------------
|  31-Aug-20 Alpha    Sohel   $$1     Created
/---------------------------------------------------------------------------- */

/*---------------------------------------------------------------------------\
| Function: textFieldValidator::validators
| Purpose: validate if the is not empty
| Input: Field Value
| Output:  null if its valid otherwise sPleaseEnterText message
\---------------------------------------------------------------------------*/
String textFieldValidator(String value) {
  if (value.isEmpty) {
    return sPleaseEnterText;
  }
  return null;
}

/*---------------------------------------------------------------------------\
| Function: yearFieldValidator::validators
| Purpose: validate if the field is a between 1940-2020
| Input: Field Value
| Output:  null if its valid year otherwise sPleaseEnterValidYear message
\---------------------------------------------------------------------------*/
String yearFieldValidator(String value) {
  try {
    if (value.isEmpty) {
      return sPleaseEnterText;
    }
    var val = int.parse(value);
    if (val >= 1940 && val <= 2020) {
      return null;
    }
  } catch (e) {}
  return sPleaseEnterValidYear;
}

/*---------------------------------------------------------------------------\
| Function: monthFieldValidator::validators
| Purpose: validate if the field is a between 1-12
| Input: Field Value
| Output:  null if its valid month otherwise sPleaseEnterValidMonth message
\---------------------------------------------------------------------------*/
String monthFieldValidator(String value) {
  try {
    if (value.isEmpty) {
      return sPleaseEnterText;
    }
    var val = int.parse(value);
    if (val >= 1 && val <= 12) {
      return null;
    }
  } catch (e) {}
  return sPleaseEnterValidMonth;
}

/*---------------------------------------------------------------------------\
| Function: dayFieldValidator::validators
| Purpose: validate if the field is a between 1-31
| Input: Field Value
| Output:  null if its valid day otherwise sPleaseEnterValidDay message
\---------------------------------------------------------------------------*/
String dayFieldValidator(String value) {
  try {
    if (value.isEmpty) {
      return sPleaseEnterText;
    }
    var val = int.parse(value);
    if (val >= 1 && val <= 31) {
      return null;
    }
  } catch (e) {}
  return sPleaseEnterValidDay;
}

/*---------------------------------------------------------------------------\
| Function: numberFieldValidator::validators
| Purpose: validate if the field contains numbers only
| Input: Field Value
| Output:  null if its number otherwise sPleaseEnterValidNumber message
\---------------------------------------------------------------------------*/
String numberFieldValidator(String value) {
  try {
    if (value.isEmpty) {
      return sPleaseEnterText;
    }
    int.parse(value);
    return null;
  } catch (e) {}
  return sPleaseEnterValidNumber;
}
